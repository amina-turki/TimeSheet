import 'package:flutter/material.dart';
import 'package:time_sheet_flutter/Vue/AjouterIntervention.dart';

import '../main.dart';


class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return  Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          // padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(decoration:BoxDecoration(color: const Color(0xFF01A1EF),),
              child:
              Text('CAB',textAlign: TextAlign.center, style: TextStyle(fontSize: 40.0,color: Colors.white,  ),),
            ),
            /* UserAccountsDrawerHeader(
                  accountName: Text("Turki Amina"),
                  accountEmail: Text("aminaturki123@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Text(
                      "CAB",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),*/
            ListTile(
              leading: Icon(Icons.home), title: Text("Mon Dashbord"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MyApp()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.date_range), title: Text("Fiche d'eures"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AjouterIntervention()),
                );
              },
            ),


            ListTile(
              leading: Icon(Icons.date_range), title: Text("Saisir une nouvelle intervention"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AjouterIntervention()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.density_medium ), title: Text("Mes projets"),
              onTap: () {
                //   Navigator.pushNamed(context, '/AjouterIntervention');
              },
            ),

            ListTile(
              leading: Icon(Icons.playlist_add_check), title: Text("Etats et resprting"),
              onTap: () {
                // Navigator.pushNamed(context, '/AjouterIntervention');
              },
            ),

            ListTile(
              leading: Icon(Icons.person), title: Text("Mes collégues"),
              onTap: () {
                //   Navigator.pushNamed(context, '/AjouterIntervention');
              },
            ),






            ListTile(
              leading: Icon(Icons.date_range), title: Text("Saisir une nouvelle intervention"),
              onTap: () {
                // Navigator.pushNamed(context, '/AjouterIntervention');
              },
            ),

          ],
        ),
      );


  }
}