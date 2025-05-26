import 'package:barbermanager_fe/models/message.dart';
import 'package:barbermanager_fe/view_models/chat_viewmodel.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {


  final ChatViewModel viewModel = ChatViewModel();
  @override
  void initState() {
    super.initState();

  Future.microtask(() async {
    await viewModel.init();
    setState(() {});
  });
}
  final TextEditingController _controller = TextEditingController();
  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        var newMessage = Message(text, true);
        viewModel.addMessage(newMessage);
        _controller.clear();
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chatbot')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: viewModel.messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Align(
                    
                    alignment: viewModel.messages[index].fromMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: viewModel.messages[index].fromMe ? Color.fromRGBO(23, 23, 180, 1) : Colors.blue[200] ,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        viewModel.messages[index].message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.elliptical(20, 20), topRight: Radius.elliptical(20, 20)),
              color: Colors.black,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      maxLines: null,
                      controller: _controller,

                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        hintText: 'Digite uma mensagem...',
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.white),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
