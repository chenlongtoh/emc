import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emc/screens/student/chatbot/model/entity/quote.dart';

class QuoteService {
  static Future genrateRandomQuote() async {
    try {
      CollectionReference quotes = FirebaseFirestore.instance.collection("quotes");
      var documentId = FieldPath.documentId;
      var quotes_doc_id = quotes.doc().id;
      QuerySnapshot querySnapshot = await quotes.where(documentId, isGreaterThanOrEqualTo: quotes_doc_id).orderBy(documentId).limit(1).get();
      if (querySnapshot?.docs?.isEmpty ?? true) {
        querySnapshot = await quotes.where(documentId, isLessThan: quotes_doc_id).orderBy(documentId).limit(1).get();
      }
      if(querySnapshot?.docs?.isEmpty ?? true){
        return null;
      }
      log("querySnapshot.docs[0].data() => ${querySnapshot.docs[0].data()}");
      return Quote.fromJson(querySnapshot.docs[0].data());
    } catch (exception) {
      log("Error @ genrateRandomQuote => $exception");
    }
    return null;
  }
}
