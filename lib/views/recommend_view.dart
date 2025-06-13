import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:barbermanager_fe/models/chat_step.dart';
import 'package:flutter/material.dart';

class RecommendView extends StatefulWidget {
  @override
  _RecommnedViewState createState() => _RecommnedViewState();
}

class _RecommnedViewState extends State<RecommendView> {
  bool isTyping = false;
  List<ChatStep> steps = [];
  int currentStepIndex = 0;
  List<Map<String, String>> chatHistory = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    steps = [
      ChatStep(
        question:
            'Olá! Estou aqui para ajudar você. Sou uma especialista em visagismo e posso te ajudar a escolher o melhor corte. Mas antes me diga qual o seu objetivo?',
        options: [
          ChatOption(
            answerText: 'Quero um corte para parecer mais profissional.',
            nextStepIndex: 1,
            label: 'profissional',
          ),
          ChatOption(
            answerText: 'Quero um corte mais ousado.',
            nextStepIndex: 1,
            label: 'ousado',
          ),
          ChatOption(
            answerText: 'Quero um corte mais social.',
            nextStepIndex: 1,
            label: 'social',
          ),
        ],
      ),
      ChatStep(
        question: 'Ótimo! Agora me diga qual é o seu tipo de cabelo?',
        options: [
          ChatOption(answerText: 'Liso', nextStepIndex: 2, label: 'liso'),
          ChatOption(
            answerText: 'Cacheado',
            nextStepIndex: 2,
            label: 'cacheado',
          ),
          ChatOption(answerText: 'Crespo', nextStepIndex: 2, label: 'crespo'),
          ChatOption(
            answerText: 'Ondulado',
            nextStepIndex: 2,
            label: 'ondulado',
          ),
        ],
      ),
      ChatStep(
        question: 'Perfeito, agora qual o formato do seu rosto?',
        options: [
          ChatOption(
            answerText: 'Meu rosto é Quadrado',
            nextStepIndex: 3,
            label: 'quadrado',
          ),
          ChatOption(
            answerText: 'Meu rosto é Redondo',
            nextStepIndex: 3,
            label: 'redondo',
          ),
          ChatOption(
            answerText: 'Meu rosto é Losango',
            nextStepIndex: 3,
            label: 'losango',
          ),
          ChatOption(
            answerText: 'Meu rosto é Oval',
            nextStepIndex: 3,
            label: 'oval',
          ),
        ],
      ),
      ChatStep(
        question: 'Perfeito! Agora para finalizar qual a tom da sua pele?',
        options: [
          ChatOption(
            answerText: 'Minha pele é mais Clara.',
            nextStepIndex: null,
            label: 'clara',
          ),
          ChatOption(
            answerText: 'Minha pele é mais Escura.',
            nextStepIndex: null,
            label: 'negra',
          ),
        ],
      ),
    ];

    // Adiciona a primeira pergunta como mensagem do bot
    chatHistory.add({'question': steps[0].question, 'answer': ''});

    // Rola para o final depois que a frame for renderizada
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
  }

  void _onOptionSelected(ChatOption option) async {
    setState(() {
      chatHistory.last['answer'] = option.answerText;
      chatHistory.last['label'] = option.label;
    });

    _scrollToEnd();

    if (option.nextStepIndex != null) {
      setState(() => isTyping = true);

      await Future.delayed(Duration(seconds: 1)); // animação "escrevendo..."
      setState(() {
        isTyping = false;
        currentStepIndex = option.nextStepIndex!;
        chatHistory.add({
          'question': steps[currentStepIndex].question,
          'answer': '',
        });
      });
      _scrollToEnd();
    } else {
      // Bate na API para sugerir próxima resposta
      setState(() => isTyping = true);

      final suggestion = await _fetchSuggestion(option.answerText);

      setState(() => isTyping = false);

      if (suggestion != null) {
        await Future.delayed(Duration(milliseconds: 800));
        setState(() {
          chatHistory.add({
            'question':
                "Com base nas suas respostas, eu sugiro o corte: $suggestion",
            'answer': '',
          });
        });
      }

      setState(() {
        currentStepIndex = -1; // marca fim da conversa
      });
    }
  }

  Future<String?> _fetchSuggestion(String userInput) async {
    try {
      final request = {
        "formato_do_rosto": "${chatHistory[0]['label']}",
        "tipo_de_cabelo": "${chatHistory[1]['label']}",
        "preferencia": "${chatHistory[2]['label']}",
        "cor_da_Pele": "${chatHistory[3]['label']}",
      };
      print(request);
      final response = await http.post(
        Uri.parse('https://7712-34-16-198-20.ngrok-free.app/prever_corte'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['corte_escolhido']; // ajusta conforme estrutura da tua API
      } else {
        print('Erro na API: ${response.statusCode} - ${response.body}');
        return 'Desculpe, não entendi. Pode repetir?';
      }
    } catch (e) {
      print('Erro na requisição: $e');
      return 'Ocorreu um erro. Tente novamente mais tarde.';
    }
  }

  void _scrollToEnd() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnd = currentStepIndex == -1;

    return Scaffold(
      appBar: AppBar(title: Text('Qual melhor corte para mim?')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 16),
              itemCount: chatHistory.length + (isEnd ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < chatHistory.length) {
                  final entry = chatHistory[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (entry['question']!.isNotEmpty)
                        _buildAnimatedMessage(
                          isUser: false,
                          text: entry['question']!,
                        ),
                      if (entry['answer']!.isNotEmpty)
                        _buildAnimatedMessage(
                          isUser: true,
                          text: entry['answer']!,
                        ),
                    ],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(child: Text('Fim da conversa.')),
                  );
                }
              },
            ),
          ),
          if (!isEnd)
            Container(
              height: 200,
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              color: const Color.fromARGB(255, 44, 44, 44),
              child: Wrap(
                alignment: WrapAlignment.center,

                spacing: 12, // espaço horizontal entre botões
                runSpacing: 12, // espaço vertical entre linhas
                children:
                    steps[currentStepIndex].options.map((opt) {
                      int totalOptions = steps[currentStepIndex].options.length;
                      int buttonsPerRow;

                      if (totalOptions <= 2) {
                        buttonsPerRow = 2;
                      } else if (totalOptions <= 4) {
                        buttonsPerRow = 2;
                      } else {
                        buttonsPerRow = 3;
                      }

                      double screenWidth = MediaQuery.of(context).size.width;
                      double totalSpacing =
                          (buttonsPerRow - 1) * 12 +
                          32; // 32 = padding horizontal container
                      double buttonWidth =
                          (screenWidth - totalSpacing) / buttonsPerRow;

                      return SizedBox(
                        width: buttonWidth,
                        height: 70,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => _onOptionSelected(opt),
                          child: Text(
                            opt.answerText,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            
        ],
      ),
    );
  }

  Widget _buildAnimatedMessage({required bool isUser, required String text}) {
    double maxBubbleWidth =
        MediaQuery.of(context).size.width * 0.7; // 70% da largura da tela

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 300),
      builder: (context, double opacity, child) {
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(
              isUser ? 30 * (1 - opacity) : -30 * (1 - opacity),
              0,
            ),
            child: Align(
              alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxBubbleWidth),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
