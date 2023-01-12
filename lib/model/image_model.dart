
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel {
  final String uid;
  final String imageUrl;
  ImageModel({
    required this.uid,
    required this.imageUrl,
  });

  Map<String , dynamic> toJson() => {
    "uid": uid,
    "imageUrl": imageUrl,
  };

    static ImageModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;

    return ImageModel(
      uid: snapshot['uid'],
      imageUrl: snapshot['imageUrl'],
    );
  }
}
