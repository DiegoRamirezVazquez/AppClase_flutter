import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/database/notes_dao.dart';
import 'package:flutter_application_1/database/notes_db.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  
  NotesDB? notesDB;
  @override
  void initState() {
    super.initState();
    notesDB = NotesDB();
  }
  
  @override
  Widget build(BuildContext context) {

    final conTitle = TextEditingController();
    final conContent = TextEditingController();
    NotesDAO? note;

    if( ModalRoute.of(context)!.settings.arguments != null ){
      note = ModalRoute.of(context)!.settings.arguments as NotesDAO;
      conTitle.text = note.title!;
      conContent.text = note.content!;
    }
  
    final txtTitle = TextFormField(
      controller: conTitle,
    );
    final txtContent = TextFormField(
      maxLines: 8,
      controller: conContent,
    );
    final space = SizedBox(height: 5,);
    final btnSave = ElevatedButton(
      onPressed: (){
        if( note == null ){
          notesDB!.INSERT({
            "title" : conTitle.text,
            "content": conContent.text,
            "dateNote": "2026-09-25"
          }).then((value) {
            if(value>0){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Se guardo el registro correctamente'),
                  duration: Duration(seconds: 3),
                ),
              );
              Navigator.pop(context);
            }
          },);
        }else{
          notesDB!.UPDATE({
            "idNote" : note.idNote,
            "title" : conTitle.text,
            "content" : conContent.text
          }).then((value) {
            if(value>0){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Se guardo el registro correctamente'),
                  duration: Duration(seconds: 3),
                ),
              );
              Navigator.pop(context);
            }
          },);
        }
      }, 
      child: Text('Save Note')
    );

    return Scaffold(
      appBar: AppBar(title: Text('Insertar Nota'),),
      body: Column(
        children: [
          txtTitle,
          space,
          txtContent,
          space,
          btnSave
        ],
      ),
    );
  }
}