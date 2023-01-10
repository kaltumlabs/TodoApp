import 'dart:collection';

import 'package:flutter/cupertino.dart';

class SelectTodoProvider extends ChangeNotifier {
  HashSet<dynamic> selectedItem = HashSet();
  late String id;
  bool isSelectAll = false;

  void doMultiSelection(String id) {
    if (selectedItem.contains(id)) {

      selectedItem.remove(id);
      if(selectedItem.isEmpty){
        isSelectAll = false;
      }
    } else {
      isSelectAll = true;
      selectedItem.add(id);
    }
    notifyListeners();
  }

//   SelectAll(String id) {
//     if (selectedItem.contains(id)) {
//
//     } else {
//       isSelectAll = false;
//     }
//     notifyListeners();
//   }
 }
