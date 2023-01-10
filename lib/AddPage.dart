import 'package:crudop/ListPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _todoContoller = TextEditingController();
  bool loading = false;
  final detabaseRef = FirebaseDatabase.instance.ref("Todo");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a Todo"),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              child: TextField(
                controller: _todoContoller,
                decoration:
                    const InputDecoration(hintText: "What I will do today"),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if(_todoContoller.value.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        dismissDirection: DismissDirection.endToStart,
                        content: const Text('To do is required'),

                        duration: const Duration(milliseconds: 1500),
                        width: 160.0, // Width of the SnackBar.
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,vertical: 20 // Inner padding for SnackBar content.
                        ),

                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    );
                  }else{
                  String id = DateTime.now().microsecondsSinceEpoch.toString();
                  detabaseRef.child(id).set({
                    "todo": _todoContoller.text.toString(),
                    "id": id,
                  });
                  setState(() {
                    _todoContoller.clear();
                  });
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ListPage(),
                    ),
                  );
                }},
                child: const Text("Add"))
          ],
        ),
      ),
    );
  }
}
