import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_sheet_flutter/services/api.dart';

import '../main.dart';

class AjouterIntervention extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        debugShowCheckedModeBanner: false,
        home: FlutterDatePickerExample());
  }
}

class FlutterDatePickerExample extends StatelessWidget {

  final ValueNotifier<DateTime?> dateSub = ValueNotifier(null);
  final ValueNotifier<TimeOfDay?> Starttime = ValueNotifier(null);
  final ValueNotifier<TimeOfDay?> Endtime = ValueNotifier(null);
  final TextEditingController iduser = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saisir une nouvelle intervention'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              const SizedBox(
                height: 20,
              ),
              buildTextField(controller: iduser, hint: 'Id_user'),

              const SizedBox(
                height: 10,
              ),
              const Text(
                'Date',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              ValueListenableBuilder<DateTime?>(
                  valueListenable: dateSub,
                  builder: (context, dateVal, child) {
                    return InkWell(
                        onTap: () async {
                          DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2050),
                              currentDate: DateTime.now(),
                              initialEntryMode: DatePickerEntryMode.calendar,
                              initialDatePickerMode: DatePickerMode.day,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: Colors.blueGrey,
                                        onSurface: AppColors.blackCoffee,
                                      )
                                  ),
                                  child: child!,
                                );
                              });
                          dateSub.value = date;
                        },
                        child: buildDateTimePicker(
                            dateVal != null ? convertDate(dateVal) : ''));
                  }),
              const SizedBox(
                height: 10,
              ),
              const Text(
                ' Heure de début ',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              ValueListenableBuilder<TimeOfDay?>(
                  valueListenable: Starttime,
                  builder: (context, timeVal, child) {
                    return InkWell(
                        onTap: () async {
                          TimeOfDay? time = await showTimePicker(
                            context: context,

                            initialTime: TimeOfDay.now(),
                          );
                          Starttime.value = time;
                        },
                        child: buildDateTime(timeVal != null
                            ? convertTime(timeVal)
                            : ''));
                  }),
              const SizedBox(
                height: 20.0,
              ),



              const Text(
                ' Heure de fin',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              ValueListenableBuilder<TimeOfDay?>(
                  valueListenable: Endtime,
                  builder: (context, timeVal, child) {
                    return InkWell(
                        onTap: () async {
                          TimeOfDay? time = await showTimePicker(
                            context: context,

                            initialTime: TimeOfDay.now(),
                          );
                          Endtime.value = time;
                        },
                        child: buildDateTime(timeVal != null
                            ? convertTime(timeVal)
                            : ''));
                  }),

              const SizedBox(
                height: 20,
              ),

              buildTextField( controller: description, hint: 'Description'),



              const SizedBox(
                height: 10,
              ),

              const SizedBox(height: 20.0,),
             ElevatedButton(onPressed: () {
              // Api.addIntervention(iduser.text,Starttime.toString(),Endtime.value,description.text);

               String year = dateSub.value!.year.toString();
               int month = dateSub.value!.month;
               String day = dateSub.value!.day.toString();
               String date;
               if(month<=9) {
                  date = year + "-0" + month.toString() + "-" + day;
               }
               else {
                  date = year + "-" + month.toString() + "-" + day;
               }

               int hour_heurDebut=Starttime.value!.hour;
               int minute_heurDebut=Starttime.value!.minute;
               String start_Time;
                if(hour_heurDebut<=9 || minute_heurDebut<=9){
                   start_Time ="0"+hour_heurDebut.toString()+":0"+minute_heurDebut.toString();
                }else{
                   start_Time =hour_heurDebut.toString()+":"+minute_heurDebut.toString();
                }
               String ch_tart_Time=date+"T"+start_Time+":00.721Z";


               int hour_heurFin=Endtime.value!.hour;
               int minute_heurFin=Endtime.value!.minute;
               String Fin_Time;
               if(hour_heurFin<=9 && minute_heurFin<=9){
                 Fin_Time ="0"+hour_heurFin.toString()+":0"+minute_heurDebut.toString();
               }else{
                 Fin_Time =hour_heurFin.toString()+":"+minute_heurDebut.toString();
               }

               String ch_Fin_Time=date+"T"+Fin_Time+":00.721Z";


               var unintervention ={

                 "id_User" : iduser.text,
                 "startTime" : ch_tart_Time,
                 "endTime" : ch_Fin_Time,
                 "description" : description.text,
               };

               Api.addIntervention(unintervention);
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) =>  MyApp()),
               );
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Meeting Created'),
                  duration: Duration(seconds: 5),));

              /* */
              }, child: const Text('Ajouter', style: TextStyle(fontSize: 18)),
               style: ElevatedButton.styleFrom(
                 padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 18),


               ),
             ),
            ],
          ),
        ),

      ),
    );
  }

  String convertDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }



  String convertTime(TimeOfDay timeOfDay) {
    DateTime tempDate = DateFormat('hh:mm').parse(
        timeOfDay.hour.toString() + ':' + timeOfDay.minute.toString());
    var dateFormat = DateFormat('h:mm a');
    return dateFormat.format(tempDate);
  }



  Widget buildDateTime(String data) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: AppColors.eggPlant, width: 1.5),
      ),
      title: Text(data),
      trailing: const Icon(
        Icons.timelapse,
        color: AppColors.eggPlant,
      ),
    );
  }

  Widget buildDateTimePicker(String data) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: AppColors.eggPlant, width: 1.5),
      ),
      title: Text(data),
      trailing: const Icon(
        Icons.date_range,
        color: AppColors.eggPlant,
      ),
    );
  }

  Widget buildTextField(
      {String? hint, required TextEditingController controller}) {
    return TextField(
      minLines: 1,
      maxLines: null,
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: hint ?? '',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.eggPlant, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.eggPlant, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    );
  }

}
class AppColors {
  AppColors._();

  static const Color blackCoffee = Color(0xff7985d0);
  static const Color eggPlant = Color(0xff7985d0);//0xff2196f3
  static const Color celeste = Color(0xFFb1ede8);
  static const Color babyPowder = Color(0xFFFFFcF9);
  static const Color ultraRed = Color(0xFFFF6978);
}