import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/api.dart';
import 'package:intl/intl.dart';
import '../main.dart';


class ModififierIntervention extends StatefulWidget {
  final String id;
  final String id_User;
  final String startTime;
  final String endTime;
  final String description;
  ModififierIntervention(this.id,this.id_User,this.startTime,this.endTime,this.description);

  @override
  _ModififierInterventionState createState() => _ModififierInterventionState();
}

class _ModififierInterventionState extends State<ModififierIntervention> {
  TextEditingController _txtId_User = TextEditingController();
  TextEditingController _textstartTime = TextEditingController();
  TextEditingController _txtendTime = TextEditingController();
  TextEditingController _txtdescription = TextEditingController();
  String idI = '';
  final ValueNotifier<TimeOfDay?> startTime = ValueNotifier(null);
  void initState() {
    super.initState();
    setState(() {
      idI = widget.id;
      _txtId_User.text = widget.id_User;
      _textstartTime.text = widget.startTime;
      _txtendTime.text = widget.endTime;
      _txtdescription.text = widget.description;
      print(idI);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier Intervention'),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              const SizedBox(
                height: 20,
              ),
              buildTextField(controller: _txtId_User, hint: 'Id_user'),

              const SizedBox(
                height: 10,
              ),



              buildTextField( controller: _textstartTime, hint: 'Heure de début'),
           /*   ValueListenableBuilder<TimeOfDay?>(
                  valueListenable: startTime,
                  builder: (context, timeVal, child) {
                    return InkWell(

                        onTap: () async {
                          TimeOfDay? time = await showTimePicker(
                            context: context,

                            initialTime: TimeOfDay.now(),
                          );
                          startTime.value = time;
                        },
                        child: buildDateTime(timeVal != null
                            ? convertTime(timeVal)
                            : ''),);
                  }),*/

              const SizedBox(
                height: 20.0,
              ),


              buildTextField( controller: _txtendTime, hint: 'Heure de fin'),


              const SizedBox(
                height: 20,
              ),

              buildTextField( controller: _txtdescription, hint: 'Description'),



              const SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: () {
                Api.deleteIntervention(idI);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MyApp()),
                );
                Fluttertoast.showToast(
                    msg: "Supprimer avec succès",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );

              }, child: const Text('Supprimer', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 18),
                ),
              ),


              const SizedBox(height: 20.0,),
              ElevatedButton(onPressed: () {
                Api.ModifIntervention(
                    idI, _txtId_User.text, _textstartTime.text, _txtendTime.text,
                    _txtdescription.text);
                Fluttertoast.showToast(
                    msg: "Modifier avec succès",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,

                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MyApp()),
                );

              }, child: const Text('Modifier', style: TextStyle(fontSize: 18)),
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