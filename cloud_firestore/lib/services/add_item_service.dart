import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_tutorial/components/show_notification.dart';
import 'package:flutter/material.dart';

import 'logger_service.dart';

Future<void> addItem(
    BuildContext context, Map<String, dynamic> data, String documentName) {
  return Firestore.instance
      .collection("catalog")
      .document(documentName)
      .setData(data)
      .then((returnData) {
    showMessageBox(context, "Success", "Added item($documentName) to Firestore",
        actions: [dismissButton(context)]);
    logger.i("setData success");
  }).catchError((e) {
    logger.e(e);
  });
}
