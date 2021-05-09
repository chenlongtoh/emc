enum ChatType{
  bot,
  user,
  botLoading,
}

class Chat{
  final ChatType chatType;
  final String text;

  Chat({this.chatType, this.text});
}