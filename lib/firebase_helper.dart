import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseHelper{

  Firestore _fireStore;

  FireBaseHelper(){
    _fireStore=Firestore.instance;
  }

  Map<String,dynamic> map=Map<String,dynamic>();
  Future<Map<String,dynamic>> getDateSpecificEvents(String documentName,String date) async{

      _fireStore.collection("total_analyze").document(documentName).get().then((event){
        return event[date];
      });
      return map;
 }
  
}


 final FireBaseHelper fBHelper=FireBaseHelper();