import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  String id;
  String? imageUrl;
  String userName;
  String? lastMessage;
  String? date;

  ChatModel({
    required this.id,
    required this.imageUrl,
    required this.userName,
    this.lastMessage,
    this.date,
  });

  @override
  List<Object?> get props => [
        this.id,
        this.imageUrl,
        this.userName,
        this.lastMessage,
      ];
}
