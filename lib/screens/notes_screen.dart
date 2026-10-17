import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/database/notes_dao.dart';
import 'package:flutter_application_1/database/notes_db.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {

  NotesDB? notesDB;
  
  @override
  void initState() {
    super.initState();
    notesDB = NotesDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Notas'),
      ),
      body: FutureBuilder(
        future: notesDB!.SELECT(), 
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ItemNote(snapshot.data![index]);
              },
            );
          }else{
            if( snapshot.hasError ){
              return Text(snapshot.error.toString());
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.note),
        onPressed: ()=> Navigator.pushNamed(context, "/add").then((value) {
          setState(() {});
        },)
      ),
    );
  }

  Widget ItemNote(NotesDAO note){
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              width: 40,
              child: Center(child: Text('10')),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20)
              ),
            ),

            SizedBox(width: 15),

            Expanded(
              child: Column(
                children: [
                  Text(note.title!),
                  Text(note.content!)
                ],
              ),
            ),
            IconButton(onPressed: (){
              Navigator.pushNamed(context, "/add", arguments: note).then((
                value,
                ){
                  setState(() {});
                }
                );
            }, icon: Icon(Icons.edit)),
            IconButton(onPressed: () async {
              return showDialog(
                context: context, 
                builder: (context) => _buildAlertDialog(note.idNote!),
              );
            }, icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  }

  Widget _buildAlertDialog(int idNote) {
    return AlertDialog(
      title: Text('Alerta del sistema'),
      content:
          Text("¿Desea eliminar el registró :) ?"),
      actions: [
        TextButton(
            child: Text("Aceptar"),
            onPressed: () {
              notesDB!.DELETE(idNote).then((value) {
                String msj = ( value == 1 ) ? "Registro borrado" : "Ocurrió un error";
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(msj),
                    duration: Duration(seconds: 3),
                  ),
                ); 
              },);
              Navigator.of(context).pop();
              setState(() {});
            }),

        TextButton(
            child: Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}