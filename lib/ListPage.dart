import 'dart:collection';

import 'package:crudop/AddPage.dart';
import 'package:crudop/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final ref = FirebaseDatabase.instance.ref("Todo");
  final searchFilter = TextEditingController();
  final editTodo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("List of Todo"),
        leading: Visibility(
          visible: Provider.of<SelectTodoProvider>(context).isSelectAll == true,
          child: const Icon(
            Icons.select_all,
            size: 30,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: searchFilter,
              decoration: const InputDecoration(hintText: "Search todo"),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
              child: StreamBuilder(
            stream: ref.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                Map<dynamic, dynamic> map =
                    snapshot.data!.snapshot.value as dynamic;
                List<dynamic> list = [];
                list.clear();
                list = map.values.toList();

                return ListView.builder(
                    itemCount: snapshot.data!.snapshot.children.length,
                    itemBuilder: (context, index) {
                      final title = list[index]["todo"].toString();
                      final id = list[index]["id"].toString();
                      if (searchFilter.text.isEmpty) {
                        return ListTile(
                          title: Consumer<SelectTodoProvider>(
                            builder: (context, value, child) => InkWell(
                              // onHover: value.SelectAll(id),


                              child: Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(title),
                                          Text(id),
                                        ],
                                      ),
                                      Visibility(
                                        visible:
                                            value.selectedItem.contains(id),
                                        child: const Icon(
                                          Icons.check_circle,
                                          color: Colors.blue,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () {
                                value.doMultiSelection(id);
                              },
                            ),
                          ),
                          trailing: PopupMenuButton(
                            elevation: 1,
                            icon: Icon(Icons.more_horiz_sharp),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialog(title, id);
                                  },
                                  trailing: Icon(Icons.edit),
                                  title: Text("Edit"),
                                ),
                              ),
                              PopupMenuItem(
                                  child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  ref
                                      .child(list[index]["id"].toString())
                                      .remove();
                                  setState(() {});
                                },
                                trailing: Icon(Icons.delete),
                                title: Text("Delete"),
                              )),
                            ],
                          ),
                        );
                      } else if (title.toLowerCase().contains(
                          searchFilter.text.toLowerCase().toString())) {
                        return ListTile(
                          title: Text(title),
                          subtitle: Text(id),
                          trailing: PopupMenuButton(
                            elevation: 1,
                            icon: Icon(Icons.more_horiz_sharp),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialog(title, id);
                                  },
                                  trailing: Icon(Icons.edit),
                                  title: Text("Edit"),
                                ),
                              ),
                              PopupMenuItem(
                                  child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  ref
                                      .child(list[index]["id"].toString())
                                      .remove();
                                  setState(() {});
                                },
                                trailing: Icon(Icons.delete),
                                title: Text("Delete"),
                              )),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    });
              }
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editTodo.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Update Todo"),
            content: Container(
              child: TextField(
                controller: editTodo,
                decoration: const InputDecoration(hintText: "Edit"),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cencel"),
              ),
              TextButton(
                onPressed: () {
                  ref.child(id).update({"todo": editTodo.text.toLowerCase()});
                  Navigator.pop(context);
                },
                child: const Text("Update"),
              )
            ],
          );
        });
  }
}
