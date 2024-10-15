import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class UserEvent {
  int id;
  int userId;
  int eventId;
  int roleId;
  int confirmationTypeId;
  int taskId;

  UserEvent({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.roleId,
    required this.confirmationTypeId,
    required this.taskId,
  });

  // fromMap method to create a UserEvent object from a map
  factory UserEvent.fromMap(Map<String, dynamic> map) {
    return UserEvent(
      id: map['id'],
      userId: map['userId'],
      eventId: map['eventId'],
      roleId: map['roleId'],
      confirmationTypeId: map['confirmationTypeId'],
      taskId: map['taskId'],
    );
  }

  // toJson method to convert the UserEvent object to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'eventId': eventId,
      'roleId': roleId,
      'confirmationTypeId': confirmationTypeId,
      'taskId': taskId,
    };
  }

  // toString method for a readable format of the UserEvent object
  @override
  String toString() {
    return 'UserEvent{id: $id, userId: $userId, eventId: $eventId, roleId: $roleId, confirmationTypeId: $confirmationTypeId, taskId: $taskId}';
  }
}
