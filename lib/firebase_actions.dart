import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
Future<dynamic >create_account({required name,required String email,required String password})async{
  dynamic error_text = null;
  try{
    UserCredential? user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  }on FirebaseAuthException catch(e){
    error_text = e.message;
  }
  return error_text;
}
Future<dynamic> signIn_account({required String email,required String password})async{
  dynamic error_text = null;
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }on FirebaseAuthException catch(e){
    error_text = e.message;
  }
  return error_text;
}