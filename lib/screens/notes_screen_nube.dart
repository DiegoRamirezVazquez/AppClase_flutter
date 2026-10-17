import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/config/firestore_notes.dart';
import 'package:flutter_application_1/database/notes_dao.dart';
import 'package:flutter_application_1/database/notes_db.dart';

class NotesScreenNube extends StatefulWidget {
  const NotesScreenNube({super.key});

  @override
  State<NotesScreenNube> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreenNube> {
  FirestoreNotes? _firestoreNotes;

  @override
  void initState() {
    super.initState();
    _firestoreNotes = FirestoreNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Notas'),
      ),
      body: StreamBuilder(
        stream: _firestoreNotes!.m_select(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                return ItemNote(snapshot.data!.docs[index]);
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
        onPressed: ()=> Navigator.pushNamed(context, "/addNube").then((value) {
          setState(() {});
        },)
      ),
    );
  }

  Widget ItemNote(QueryDocumentSnapshot <Object?>note) {
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
                  Text(note.get('title')),
                  Text(note.get('content')),
                ],
              ),
            ),
            IconButton(onPressed: (){
              Navigator.pushNamed(context, "/addNube", arguments: {"idNote":note.id, "title": note.get("title"), "content": note.get("content")}).then((
                value,
                ){
                  setState(() {});
                }
                );
            }, icon: Icon(Icons.edit)),
            IconButton(onPressed: () async {
              return showDialog(
                context: context, 
                builder: (context) => _buildAlertDialog(note.id),
              );
            }, icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  }

  Widget _buildAlertDialog(String idNote) {
    return AlertDialog(
      title: Text('Alerta del sistema'),
      content:
          Text("¿Desea eliminar el registró :) ?"),
      actions: [
        TextButton(
            child: Text("Aceptar"),
            onPressed: () {
              _firestoreNotes!.m_delete(idNote).then((value) {
                String msj = ( value ) ? "Registro borrado" : "Ocurrió un error";
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