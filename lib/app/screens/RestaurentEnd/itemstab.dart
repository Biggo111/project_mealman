
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/Controllers/resend_controller.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/addnewitem.dart';

import '../../Modules/RestaurentendModels/item_Model.dart';
import '../../core/app_colors.dart';

class ItemsTab extends StatefulWidget {
  const ItemsTab({super.key});

  @override
  State<ItemsTab> createState() => _ItemsTabState();
}

class _ItemsTabState extends State<ItemsTab> {
  ResEndController controller = Get.find();
  List<GlobalKey> textKeys = [];
  
  @override
  void initState() {
    super.initState();
    // Create a new GlobalKey for each item in the list
    textKeys = List.generate(controller.menuList!.length, (_) => GlobalKey());
  }

  // updateIndex()f{

  // }
  

  removeIndex(index){
    void deleteFromDatabase(int index2) async{
      await FirebaseFirestore.instance.collection("${controller.resName} Menu").doc("${controller.menuList![index2]["itemName"]}").delete().then((value) => Logger().i("Item Deleted")).catchError((error) => Logger().i("Error deleting item: $error"));
    }
    deleteFromDatabase(index);      
    setState(() {
    controller.menuList!.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
            itemCount: controller.menuList?.length ?? 0,
            itemBuilder: (_, index) {
            final document = controller.menuList?[index];
            if(document==null){
              Logger().i("Here is the problem");
              return const SizedBox.shrink();
            }
            return Slidable(
              key: ValueKey(index),
              startActionPane: ActionPane(
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    label: "Update",
                    icon: Icons.auto_fix_high_outlined,
                    backgroundColor: AppColors.mainColor,
                    onPressed: (context){},
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    label: "Delete",
                    icon: Icons.delete_outlined,
                    backgroundColor: AppColors.mainColor,
                    onPressed: (context){
                      removeIndex(index);
                    },
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    //border: Border.all(),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        offset: Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, 0),
                      ),
                    ]),
                child: Row(
                  children: [
                    Image.network(
                      "${document['imageURL']}",
                      width: 60,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${document['itemName']}",
                                key: textKeys[index],
                                style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainColor,
                                ),
                              ),
                              // const SizedBox(
                              //   width: 10,
                              // ),
                              Text(
                                "${document['itemPrice']}",
                                style: const TextStyle(
                                  fontFamily: 'Jua',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          margin: const EdgeInsets.only(left: 20),
                          height: 95,
                          width: 250,
                          child: SingleChildScrollView(
                            child: Text(
                              "${document['itemDescription']}",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        floatingActionButton: SizedBox(
          height: 45,
          width: 385,
          child: FloatingActionButton(
            onPressed: () {
              Get.to(()=>const AddNewItem());
            },
            backgroundColor: AppColors.mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Text(
              "Add Item",
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 20,
              ),
            ),
          ),
        ));
  }
}
