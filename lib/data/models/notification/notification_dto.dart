class NotificationDTO {
  String id;
  String ownerUser;
  String toUser;
  String? message;

  NotificationDTO({
    required this.id,
    required this.ownerUser,
    required this.toUser,
    this.message,
  });

  factory NotificationDTO.fromJson(Map<String, dynamic> json) {
    return NotificationDTO(
      id: json['id'],
      ownerUser: json['ownerUser'],
      toUser: json['toUser'],
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'ownerUser': ownerUser,
        'toUser': toUser,
        'message': message ?? '',
      };
}
