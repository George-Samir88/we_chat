class MessageModel {
  MessageModel({
    required this.msg,
    required this.toId,
    required this.read,
    required this.type,
    required this.fromId,
    required this.sent,
  });

  late final String msg;
  late final String toId;
  late final String read;
  late final Type type;
  late final String fromId;
  late final String sent;

  MessageModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'].toString();
    toId = json['toId'].toString();
    read = json['read'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    fromId = json['fromId'].toString();
    sent = json['sent'].toString();
  }

  Map<String, dynamic> toJson() {
    final date = <String, dynamic>{};
    date['msg'] = msg;
    date['toId'] = toId;
    date['read'] = read;
    date['type'] = type.name;
    date['fromId'] = fromId;
    date['sent'] = sent;
    return date;
  }
}

enum Type { text, image }
