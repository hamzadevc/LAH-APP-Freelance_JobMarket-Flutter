class Chat {
  final String peer1ID;
  final String peer2ID;
  final String chatID;
  final String message;
  final String sentTime;
  final bool isPeer1Seen;
  final String isPeer2Seen;
  final String senderName;
  final String receiverName;

  Chat({
    this.message,
    this.senderName,
    this.chatID,
    this.isPeer1Seen,
    this.isPeer2Seen,
    this.peer1ID,
    this.peer2ID,
    this.receiverName,
    this.sentTime,
  });

  Map<String, dynamic> toJson() => {
    'peer1': peer1ID,
    'peer2': peer2ID,
    'chatId': chatID,
    'message': message,
    'sentTime': sentTime,
    'peer1Seen': isPeer1Seen,
    'peer2Seen': isPeer2Seen,
    'senderName': senderName,
    'receiverName': receiverName,
  };

  Chat fromJson(Map<String, dynamic> data) => Chat(
    senderName: data['senderName'],
    chatID: data['chatId'],
    isPeer1Seen: data['peer1Seen'],
    isPeer2Seen: data['peer2Seen'],
    message: data['message'],
    peer1ID: data['peer1'],
    peer2ID: data['peer2'],
    receiverName: data['receiverName'],
    sentTime: data['sentTime'],
  );

}
