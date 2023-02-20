import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:logger/logger.dart';


class ResEndController extends GetxController{
  
  String resName = "";
  List<Map<String, dynamic>>? menuList;

  void setResName(String name) {
    resName = name;
    Logger().i(resName);
  }

  void setMenuList(List<Map<String, dynamic>> list) {
    menuList = list;
    //Logger().i(menuList);
  }
}