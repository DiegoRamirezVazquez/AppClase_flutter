import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future <bool> m_creaUsuario({required String user, required String email, required String password, required String confirmPassword}) async{
    try {
      final credentials= await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      credentials.user!.sendEmailVerification(); 
      return true;   
    } catch (e) {
      return false;
    }
  }

  Future<bool> m_loginUser({required String user,required String password}) async {
    try{
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(email: user, password: password);
      if(credentials.user!.emailVerified){
        return true;
      }else{
        return false;
      }
    }catch(e){
      print("Error al crear usuario: $e");
      return false;
    }
  }
}

