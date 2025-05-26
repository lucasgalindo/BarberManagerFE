import 'package:barbermanager_fe/models/message.dart';
import 'package:barbermanager_fe/utils/shared_preferences_utils.dart';

class ChatViewModel {
  Future<void> init() async {
    final userData = await getUserData();
    if (userData != null && userData['username'] != null) {
      Message helloMessage = Message('Olá, ' + userData["username"] + '. Como Posso Ajudar?', false);
      addMessage(helloMessage);
    }
  }
  ChatViewModel();

  final List<Message> _messages = [];

  List<Message> get messages => List.unmodifiable(_messages);

  void addMessage(Message message) {
    _messages.insert(0, message);
  }
}