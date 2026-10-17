import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreNotes {

  FirebaseFirestore conexion = FirebaseFirestore.instance;

  CollectionReference? notesCollection;

  FirestoreNotes(){
    notesCollection = conexion.collection("notes");
  }

  Future<bool>m_insert(Map<String, dynamic> note) async{    
    try{
      notesCollection!.doc().set(note);
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool>m_update(Map<String, dynamic> note, String id) async{
    try{
      notesCollection!.doc(id).update(note);
      return true;
    }catch(e){
      return false;
    }
    
  }

  Future<bool>m_delete(String id) async{
    try{
      notesCollection!.doc(id).delete();
      return true;
    }catch(e){
      return false;
    }
  }

  Stream<QuerySnapshot> m_select(){
    return notesCollection!.snapshots();
  }

}