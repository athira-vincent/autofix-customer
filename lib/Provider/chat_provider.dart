import 'dart:io';

import 'package:auto_fix/Constants/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ChatProvider {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ChatProvider(
      {
      required this.firebaseStorage,
      required this.firebaseFirestore});

  UploadTask uploadImageFile(File image, String filename) {
    Reference reference = firebaseStorage.ref().child(filename);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Future<void> updateFirestoreData(
      String collectionPath, String docPath, Map<String, dynamic> dataUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataUpdate);
  }

  Stream<QuerySnapshot> getChatMessage(String collectionName,String groupChatId, int limit) {
    return firebaseFirestore
        //.collection(FirestoreConstants.pathMessageCollection)
        .collection("${collectionName}")
        //.doc(groupChatId)
        .doc(groupChatId)
        //.collection(groupChatId)
        .collection("messages")
        .orderBy(FirestoreConstants.timestamp, descending: true,)
        .limit(limit)
        .snapshots();
  }

  /*void sendChatMessage(String content, int type, String groupChatId,
      String currentUserId, String peerId) {
    print(">>>>02");
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    print(">>>>03");
    ChatMessages chatMessages = ChatMessages(
        idFrom: currentUserId,
        idTo: peerId,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        type: type);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, chatMessages.toJson());
    });
  }*/

  void sendChatMessage(String content, int type, String collection, String groupChatId,
      String currentUserId, String peerId) {
    print(">>>>02");

    FirebaseFirestore.instance
        .collection('${collection}')
        .doc("${groupChatId}")
        .collection("messages")
        .add({
      'content': content,
      'idFrom': currentUserId,
      'idTo': peerId,
      'type': type,
      'timestamp': DateTime.now()
          .microsecondsSinceEpoch
          .toString(),
    });
  }
}

class MessageType {
  static const text = 0;
  static const image = 1;
  static const sticker = 2;
}
