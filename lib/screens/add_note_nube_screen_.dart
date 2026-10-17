import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/config/firestore_notes.dart';
import 'package:flutter_application_1/database/notes_dao.dart';


class AddNoteNubeScreen extends StatefulWidget {
  const AddNoteNubeScreen({super.key});

  @override
  State<AddNoteNubeScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteNubeScreen> {
  
  FirestoreNotes? notesDB;

  @override
  void initState() {
    super.initState();
    notesDB = FirestoreNotes();
  }
  
    final conTitle = TextEditingController();
    final conContent = TextEditingController();
    final conDate = TextEditingController();
    DateTime _selectedDate = DateTime.now();
    Map<String, dynamic>?  note;

  @override
  Widget build(BuildContext context) {
    if( ModalRoute.of(context)!.settings.arguments != null ){
      note = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      conTitle.text = note!["title"];
      conContent.text = note!["content"];
      conDate.text = note!["dateNote"];
    }
    conDate.text=_selectedDate.toString();

    final txtTitle = TextFormField(controller: conTitle);
    final txtContent = TextFormField(maxLines: 8, controller: conContent);
    final txtDate = TextFormField(
      controller: conDate, 
      decoration: InputDecoration(
        hintText: "Fecha de vencimiento"), 
      onTap: () => _desplegarFechas(context),);
    final space = SizedBox(height: 5,);
    final btnSave = ElevatedButton(
      onPressed: (){
        if( note == null ){
          notesDB!.m_insert({
            "title" : conTitle.text,
            "content": conContent.text,
            "dateNote": "2026-09-25"
          }).then((value) {
            if(value){
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
          notesDB!.m_update({
            "title" : conTitle.text,
            "content" : conContent.text
          },note!["idNote"]).then((value) {
            if(value){
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
      appBar: AppBar(title: Text('Insertar Nota Nube'),),
      body: Column(
        children: [
          txtTitle,
          space,
          txtContent,
          space,
          txtDate,
          space,
          btnSave
        ],
      ),
    );
  }

  _desplegarFechas(BuildContext context) async{
  final DateTime? _date = await showDatePicker(
    context: context, 
    initialDate: _selectedDate, 
    firstDate: DateTime(2025), 
    lastDate: DateTime(2075)
    );

    if(_date!=null && _date!=_selectedDate){
      setState(() {
        _selectedDate = _date;
      });
    }
  }
}