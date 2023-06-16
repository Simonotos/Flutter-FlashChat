class Chat{
  final String? text;
  final String? sender;

  Chat({this.text, this.sender});

  Map<String, dynamic> sendToFirestore(){
    return{
      "text" : text,
      "sender" : sender,
    };
  }

}