import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:barbermanager_fe/models/message.dart';
import 'package:barbermanager_fe/widgets/message_balloon.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String currentText = "";
  final List<Message> chatHistory = [];
  bool isEnd = false;

  Future<void> enviarMensagem(String text) async {
    try {
      print("Enviando mensagem: $text");
      final response = await http
          .post(
            Uri.parse("https://12e7-34-142-138-253.ngrok-free.app/chat"),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: json.encode({
              "message": text,
            }),
          )
          .timeout(const Duration(seconds: 100));
      final message = json.decode(response.body)["response"];
      if (response.statusCode == 200) {
        setState(() {
          chatHistory.add(Message(message, false));
        });
        print('Mensagem enviada com sucesso');
      } else {
        print('Erro do servidor: ${response.statusCode}');
        print(response.body);
      }
    } on TimeoutException catch (_) {
      print('Erro: tempo de requisição excedido');
    } catch (e) {
      print('Erro geral: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              child: Column(
                children: [
                  Icon(Icons.smart_toy_outlined, size: 40),
                  Padding(padding: const EdgeInsets.only(left: 8.0)),
                  Text(
                    "Assistente Virtual do Cliente",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 16),
              itemCount: chatHistory.length + (isEnd ? 1 : 0),
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [MessageBalloon(msg: chatHistory[index])],
                );
              },
            ),
          ),
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      // quero que quando o usuario precionar enter, o texto seja enviado e o campo de texto seja limpo
                      decoration: InputDecoration(
                        hintText: "Digite sua mensagem",
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),

                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      maxLines: 5,
                      minLines: 1,
                      onChanged:
                          (value) => setState(() {
                            currentText = value;
                          }),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        currentText = _textController.text.trim();
                        if (currentText.isNotEmpty) {
                          chatHistory.add(Message(currentText, true));
                          enviarMensagem(currentText);
                          currentText = "";
                          _textController.clear();
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
