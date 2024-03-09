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
 void post_comments({required string,required Map<String, dynamic>? datas}) async{
  try{
    var current_user_id = FirebaseAuth.instance.currentUser?.uid;
    var user_name,user_gmail;
    await FirebaseFirestore.instance.collection("Users").doc(current_user_id).get().then((value){
      user_name = value.get("name");
      user_gmail = value.get("gmail");
    });

    FirebaseFirestore.instance.collection("Queries").doc(DateTime.now().millisecondsSinceEpoch.toString()).set({
      "UID":current_user_id,
      "Data":datas,
      "query":string,
      "reply":false,
      "name":user_name,
      "gmail":user_gmail

    });
  }catch(e){
    print(e.toString());
  }
} 