class MessageModel {
  String? id;
  String? text;
  String? sender;

  DateTime? senttime;

  MessageModel(
      {required this.id,
      required this.text,
      required this.sender,
      required this.senttime});

  MessageModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    text = map["text"];
    sender = map["sender"];

    senttime = map["senttime"];
  }

  Map<String, dynamic> fromMap() {
    return {"id": id, "text": text, "sender": sender, "sentime": senttime};
  }
}
