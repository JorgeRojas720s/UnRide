import 'package:equatable/equatable.dart';

class ClientChat extends Equatable {
  final String id;
  final String userName;
  final String? userAvatar;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool hasNewMessage;
  final bool isOnline;

  const ClientChat({
    required this.id,
    required this.userName,
    this.userAvatar,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.hasNewMessage,
    required this.isOnline,
  });

  @override
  List<Object?> get props => [
    id,
    userName,
    userAvatar,
    lastMessage,
    lastMessageTime,
    hasNewMessage,
    isOnline,
  ];

  ClientChat copyWith({
    String? id,
    String? userName,
    String? userAvatar,
    String? lastMessage,
    DateTime? lastMessageTime,
    bool? hasNewMessage,
    bool? isOnline,
  }) {
    return ClientChat(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      hasNewMessage: hasNewMessage ?? this.hasNewMessage,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  factory ClientChat.fromJson(Map<String, dynamic> json) {
    return ClientChat(
      id: json['id'] as String,
      userName: json['userName'] as String,
      userAvatar: json['userAvatar'] as String?,
      lastMessage: json['lastMessage'] as String,
      lastMessageTime: DateTime.parse(json['lastMessageTime'] as String),
      hasNewMessage: json['hasNewMessage'] as bool,
      isOnline: json['isOnline'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userAvatar': userAvatar,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.toIso8601String(),
      'hasNewMessage': hasNewMessage,
      'isOnline': isOnline,
    };
  }

  @override
  String toString() {
    return 'ClientChat(id: $id, userName: $userName, lastMessage: $lastMessage, hasNewMessage: $hasNewMessage)';
  }
}
