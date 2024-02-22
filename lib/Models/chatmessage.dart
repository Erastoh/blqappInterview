

class GetChatMessage {
  String? status;
  List<Messages>? messages;

  GetChatMessage({this.status, this.messages});

  GetChatMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Messages {
  String? chatId;
  String? datetime;
  String? rideId;
  String? userType;
  String? message;
  String? read;

  Messages(
      {this.chatId,
        this.datetime,
        this.rideId,
        this.userType,
        this.message,
        this.read});

  Messages.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    datetime = json['datetime'];
    rideId = json['ride_id'];
    userType = json['user_type'];
    message = json['message'];
    read = json['read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_id'] = this.chatId;
    data['datetime'] = this.datetime;
    data['ride_id'] = this.rideId;
    data['user_type'] = this.userType;
    data['message'] = this.message;
    data['read'] = this.read;
    return data;
  }
}