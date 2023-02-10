
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_mealman/app/Modules/RestaurentendModels/item_Model.dart';

class ResOwnerRepository extends GetxController{

  static ResOwnerRepository get instance => Get.find();

  final _database = FirebaseFirestore.instance;
  
  createItem(ItemModel itemModel)async{
    User? user = FirebaseAuth.instance.currentUser;
    if(user==null){
      return;
    }
    String resName = await FirebaseFirestore.instance.collection("Authenticated_User_Info").doc(user.uid).get().then((value)=>value.data()!['name']);
    await _database.collection("$resName Menu").add(itemModel.toJson()).whenComplete((){

    });
  }
}