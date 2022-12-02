import 'package:equatable/equatable.dart';

enum ChatMessageOwner { Sender, Receiver }

class MessageModel extends Equatable {
  String? recieverId;
  String? senderId;
 String? date;
  String? text;
  ChatMessageOwner chatMessageOwner;

  MessageModel({
    this.recieverId,
    this.senderId,
    this.date,
    this.text,
    this.chatMessageOwner = ChatMessageOwner.Sender,
  });

  Map<String, dynamic> toMap() {
    return {
      'recieverId': recieverId,
      'senderId': senderId,
      'date': date,
      'text': text,
    };
  }

  factory MessageModel.fromJson(
      Map<String, dynamic>? json, String currentUserUid) {
    return MessageModel(
      recieverId: json!['recieverId'],
      senderId: json['senderId'],
      date: json['date'],
      text: json['text'],
      chatMessageOwner: currentUserUid == json['senderId']
          ? ChatMessageOwner.Sender
          : ChatMessageOwner.Receiver,
    );
  }
  bool get isSender => chatMessageOwner == ChatMessageOwner.Sender;

  @override
  List<Object?> get props => [
        senderId,
        recieverId,
        date,
        text,
        chatMessageOwner,
      ];
}
