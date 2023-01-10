// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'main.dart';
//
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// final CollectionReference _Collection = _firestore.collection('student');
//
// class FirebaseCrud {
//
//
//   // Add Student
//   static Future<Response> addStudent({
//     required String name,
//     required String surname,
//     required int rollno,
//   }) async {
//
//     Response response = Response();
//     DocumentReference documentReferencer =
//     _Collection.doc();
//
//     Map<String, dynamic> data = <String, dynamic>{
//       "name": name,
//       "surname": surname,
//       "rollno" : rollno
//     };
//
//     var result = await documentReferencer
//         .set(data)
//         .whenComplete(() {
//       response.code = 200;
//       response.message = "Sucessfully added to the database";
//     })
//         .catchError((e) {
//       response.code = 500;
//       response.message = e;
//     });
//
//     return response;
//
//   }
// //read student
//   static Stream<QuerySnapshot> readStudent() {
//     CollectionReference notesItemCollection =
//         _Collection;
//
//     return notesItemCollection.snapshots();
//   }
//   //update student
//   static Future<Response> updateEmployee({
//     required String name,
//     required String position,
//     required String contactno,
//     required String docId,
//   }) async {
//     Response response = Response();
//     DocumentReference documentReferencer =
//     _Collection.doc(docId);
//
//     Map<String, dynamic> data = <String, dynamic>{
//       "employee_name": name,
//       "position": position,
//       "contact_no" : contactno
//     };
//
//     await documentReferencer
//         .update(data)
//         .whenComplete(() {
//       response.code = 200;
//       response.message = "Sucessfully updated Employee";
//     })
//         .catchError((e) {
//       response.code = 500;
//       response.message = e;
//     });
//
//     return response;
//   }
//   //delete student
//
//   static Future<Response> deleteEmployee({
//     required String docId,
//   }) async {
//     Response response = Response();
//     DocumentReference documentReferencer =
//     _Collection.doc(docId);
//
//     await documentReferencer
//         .delete()
//         .whenComplete((){
//       response.code = 200;
//       response.message = "Sucessfully Deleted Employee";
//     })
//         .catchError((e) {
//       response.code = 500;
//       response.message = e;
//     });
//
//     return response;
//   }
// }