import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreProvider {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  ///  ******* Get Booking details *******   ///

  Stream<DocumentSnapshot> getBookingDetails() {
    final result = _firestore
    .collection("ResolMech").doc('87').snapshots();
    return result;
  }


}