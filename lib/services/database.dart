import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
   Future addUserInfoToDB(String userId, Map<String, dynamic> userInfoMap) async{
    return FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .set(userInfoMap);
  }
}