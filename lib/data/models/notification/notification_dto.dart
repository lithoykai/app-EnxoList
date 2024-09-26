class NotificationDTO {
  String id;
  String ownerUser;
  String toUser;
  String? message;
  String toUserName;

  NotificationDTO({
    required this.id,
    required this.ownerUser,
    required this.toUser,
    required this.toUserName,
    this.message,
  });

  factory NotificationDTO.fromJson(Map<String, dynamic> json) {
    return NotificationDTO(
      id: json['id'],
      ownerUser: json['ownerUser'],
      toUser: json['toUser'],
      message: json['message'] ?? '',
      toUserName: json['toUserName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'ownerUser': ownerUser,
        'toUser': toUser,
        'message': message ?? '',
        'toUserName': toUserName,
      };
}
