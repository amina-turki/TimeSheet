
class Intervention {
  final String id;
  final String id_User;
  final String startTime;
  final String endTime;
  final String description;



  const Intervention({
    required this.id,
    required this.id_User,
    required this.startTime,
    required this.endTime,
    required this.description,

  });

  static Intervention fromJson(json) => Intervention(
    id : json['id'],
    id_User : json['id_User'],
    startTime : json['startTime'],
    endTime : json['endTime'],
    description : json['description'],

  );

}