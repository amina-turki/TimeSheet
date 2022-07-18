import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_sheet_flutter/Vue/Menu.dart';
import 'package:time_sheet_flutter/services/api.dart';
import 'Model/Meeting.dart';
import 'Vue/AjouterIntervention.dart';
import 'Vue/ModifierIntervention.dart';



void main() =>  runApp(MaterialApp(

  routes: <String, WidgetBuilder>{
    '/': (context) => MyApp(),
    '/AjouterIntervention': (context) => AjouterIntervention(),

  },
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
        title: Text("Fiche d'heures"),
        ),
          body: OnlineJsonData(),

          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  AjouterIntervention()),
              );
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),

       drawer:Menu()

        ),

    );
  }
}

class OnlineJsonData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalendarExample();
}

class CalendarExample extends State<OnlineJsonData> {
  List<Color> _colorCollection=<Color>[];
  String? _networkStatusMsg;

  @override
  void initState() {
    _initializeEventColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: Container(
        child: FutureBuilder(
          future: getDataFromWeb(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return SafeArea(
                child: Container(
                    child: SfCalendar(

                      view: CalendarView.week,
                      initialDisplayDate: DateTime(2022, 07, 03, 9, 0, 0),
                      dataSource: MeetingDataSource(snapshot.data),

                      onTap: (CalendarTapDetails details) {

                        dynamic appointment = details.appointments;
                        DateTime date = details.date!;
                        CalendarElement element = details.targetElement;

                        if(appointment != null){
                          for(var apprme in appointment){

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                //  UpdateAuthor(apprme.id,apprme.iduser,apprme.startTime,apprme.endTime,apprme.eventName),
                                ModififierIntervention(apprme.id,apprme.iduser,apprme.startTime,apprme.endTime,apprme.eventName),
                              ),
                            );


                          }
                        }

                      },
                    )
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: Text('$_networkStatusMsg'),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Meeting>> getDataFromWeb() async {
    var data = await http.get(Uri.parse("http://localhost:5125/api/Interventions"));
    var jsonData = json.decode(data.body);
    //var jsonData = Api.getAll();
    final List<Meeting> appointmentData = [];
    final Random random = new Random();
    for (var data in jsonData) {
      Meeting meetingData = Meeting(
        eventName: data['description'],

        from: _convertDateFromString(
          data['startTime'],
        ),
        to: _convertDateFromString(data['endTime']),
        background: _colorCollection[random.nextInt(9)],

        id: data['id'],
        iduser: data['id_User'],
        startTime: data['startTime'],
        endTime: data['endTime'],
      );
      appointmentData.add(meetingData);
    }
    return appointmentData;
  }



  DateTime _convertDateFromString(String date) {
    return DateTime.parse(date);
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }

}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  String getid(int index) {
    return appointments![index].id;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }


}



