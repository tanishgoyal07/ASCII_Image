import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;

  UserModel({this.uid, this.email, this.firstName, this.secondName});

  static UserModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;

    return UserModel(
      uid: snapshot['uid'],
      email: snapshot['email'],
      firstName: snapshot['firstName'],
      secondName: snapshot['secondName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
    };
  }
}
