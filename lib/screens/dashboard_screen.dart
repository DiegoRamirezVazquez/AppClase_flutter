import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/menu_circular.dart';
import 'package:flutter_application_1/components/global_values.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Diego Ramirez Vazquez'), 
              accountEmail: Text('diego@itcelaya.edu.mx'),
              currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),),
              ),
              ListTile(
                title: Text('Practica 1'),
                subtitle: Text('App de practica'),
                leading: Icon(Icons.youtube_searched_for_outlined),
                trailing: Icon(Icons.chevron_right)
              ),
              ListTile(
                title: Text('Lista de Notas'),
                subtitle: Text('App Notes'),
                leading: Icon(Icons.note),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pushNamed(context, "/note");
                  },
              ),
              ListTile(
                 title: Text('Cerrar sesion'),
                subtitle: Text('Salir'),
                leading: Icon(Icons.logout),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/');
                  //Navigator.pop(context);
                  //Navigator.pop(context);
                }
              ),
              ListTile(
                title: Text('Lista de Notas nube'),
                subtitle: Text('App Notes nube'),
                leading: Icon(Icons.cloud),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pushNamed(context, "/notesNube");
                  },
              ),
              
          ],
        ),
      ),
      floatingActionButton: MenuCircular(),
    );
  }
}