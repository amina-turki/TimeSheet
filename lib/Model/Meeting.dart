import 'package:flutter/cupertino.dart';
class Meeting {
  Meeting(
      {
        this.eventName,
        this.id,
        this.iduser,
        this.endTime,
        this.startTime,
        this.from,
        this.to,
        this.background,
        this.allDay = false});

  String? eventName;
  String? id ;
  String? iduser ;
  String? startTime;
  String? endTime;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? allDay;

}