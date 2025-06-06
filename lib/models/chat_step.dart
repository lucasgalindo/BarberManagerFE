class ChatStep {
  final String question;
  final List<ChatOption> options;

  ChatStep({required this.question, required this.options});
}

class ChatOption {
  final String answerText;
  final int? nextStepIndex;
  final String label;
  ChatOption({required this.answerText, this.nextStepIndex, required this.label});
}