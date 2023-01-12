import 'dart:typed_data';
import 'package:ascii_image/model/image_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  //upload image
  Future<String> uploadImage(
    Uint8List file,
    String uid,
  ) async {
    String photoUrl = "";
    String res = "Some error occured";
    try {
      photoUrl =
          await uploadImageToStorage("images", file, true);

      String postId = const Uuid().v1();
      ImageModel post = ImageModel(
        uid: uid,
        imageUrl: photoUrl,
      );

      _fireStore.collection('images').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return photoUrl;
  }

  Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) async {
    
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);
    
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

}
