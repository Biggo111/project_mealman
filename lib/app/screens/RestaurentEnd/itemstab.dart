import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/Controllers/resend_controller.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/addnewitem.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/addnewitem2.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/homesellertab.dart';
 
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
  //HomeSellerTab homeSellerTabInstance = HomeSellerTab();
  TextEditingController updateNameController = TextEditingController();
  TextEditingController updateDescriptionController = TextEditingController();
  TextEditingController updatePriceController = TextEditingController();
  TextEditingController updateCategoryController = TextEditingController();
 
  String imageurlForUpdate = '';
  XFile? _imageFileForUpdate;
  XFile? fileForUpdate;
 
  @override
  void initState() {
    super.initState();
    // Create a new GlobalKey for each item in the list
    textKeys = List.generate(controller.menuList!.length, (_) => GlobalKey());
  }
 
  updateIndex(index){
    void updateDatabase(int index) async{
      await FirebaseFirestore.instance.collection("${controller.resName} Menu").doc("${controller.menuList![index]["itemName"]}").update({
        'itemName': updateNameController.text,
        'itemDescription': updateDescriptionController.text,
        'itemPrice': updatePriceController.text,
        //'imageURL': imageurlForUpdate,
        'itemCategory': updateCategoryController.text,
      }).then((value) => Logger().i("Item Updated"));
    }
    updateDatabase(index);
    setState(() {
      controller.menuList![index]["itemName"] = updateNameController.text;
        controller.menuList![index]["itemDescription"] = updateDescriptionController.text;
        controller.menuList![index]["itemPrice"] = updatePriceController.text;
        controller.menuList![index]["imageURL"] = imageurlForUpdate;
        controller.menuList![index]["itemCategory"] = updateCategoryController.text;
    });
  }
 
  // updateIndex(index){
  //   setState(() {
  //     void updateDatabase(int index) async{
  //       await FirebaseFirestore.instance.collection("${controller.resName} Menu").doc("${controller.menuList![index]["itemName"]}").update({
  //         'itemName': updateNameController.text,
  //         'itemDescription': updateDescriptionController.text,
  //         'itemPrice': updatePriceController.text,
  //         //'imageURL': imageurlForUpdate,
  //         'itemCategory': updateCategoryController.text,
  //       }).then((value) => Logger().i("Item Updated"));
  //     }
  //     updateDatabase(index);
  //   });
  // }
 
  removeIndex(index) {
    void deleteFromDatabase(int index2) async {
      await FirebaseFirestore.instance
          .collection("${controller.resName} Menu")
          .doc("${controller.menuList![index2]["itemName"]}")
          .delete()
          .then((value) => Logger().i("Item Deleted"))
          .catchError((error) => Logger().i("Error deleting item: $error"));
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
                if (document == null) {
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
                        onPressed: (context) {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: updateNameController,
                                        decoration: const InputDecoration(
                                            labelText:
                                                "Enter the new item Name"),
                                      ),
                                      TextFormField(
                                        controller: updateDescriptionController,
                                        maxLines: null,
                                        decoration: const InputDecoration(
                                            labelText:
                                                "Enter the new Item Description"),
                                      ),
                                      TextFormField(
                                        controller: updatePriceController,
                                        maxLines: null,
                                        decoration: const InputDecoration(
                                            labelText:
                                                "Enter the new Item Price"),
                                      ),
                                      TextFormField(
                                        controller: updateCategoryController,
                                        maxLines: null,
                                        decoration: const InputDecoration(
                                            labelText:
                                                "Enter the new Item Category"),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            //ImagePicker imagePicker = ImagePicker();
                                            fileForUpdate = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (fileForUpdate == null) {
                                              return;
                                            }
                                            // _imageFile = file;
                                            // Logger().i("The image file is $_imageFile");
                                            setState(() {
                                              _imageFileForUpdate =
                                                  fileForUpdate;
                                              Logger().i(
                                                  "The image file is $_imageFileForUpdate");
                                            });
                                            Reference referencerootForUpdate =
                                                FirebaseStorage.instance.ref();
                                            Reference referencefirstForUpdate =
                                                referencerootForUpdate
                                                    .child('images');
                                            Reference
                                                referenceimageuploadForUpdate =
                                                referencefirstForUpdate
                                                    .child(fileForUpdate!.path);
                                            try {
                                              await referenceimageuploadForUpdate
                                                  .putFile(File(
                                                      fileForUpdate!.path));
                                              imageurlForUpdate =
                                                  await referenceimageuploadForUpdate
                                                      .getDownloadURL();
                                              Logger().i(
                                                  " The image URL is - $imageurlForUpdate");
                                            } catch (e) {
                                              Logger().i(e);
                                            }
                                            if (imageurlForUpdate.isEmpty) {
                                              Logger().i("Image URl is Empty");
                                              (ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content:
                                                        Text("Add an image")),
                                              ));
                                              return;
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.camera_alt,
                                            size: 40,
                                          )),
                                      SizedBox(
                                        height: 45,
                                        width: 300,
                                        child: FloatingActionButton(
                                          onPressed: () {
                                            if (updateNameController
                                                    .text.isEmpty ||
                                                updateDescriptionController
                                                    .text.isEmpty ||
                                                updatePriceController
                                                    .text.isEmpty ||
                                                updateCategoryController
                                                    .text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Please fill up all the fields"),
                                              ));
                                              return;
                                            }
                                            // final updateItem = ItemModel(
                                            //   itemName:
                                            //       updateNameController.text,
                                            //   itemDespriction:
                                            //       updateDescriptionController
                                            //           .text,
                                            //   itemPrice: double.parse(
                                            //       updatePriceController.text),
                                            //   //imageURL: _imageFile != null ? _imageFile!.path.toString() : '',
                                            //   imageURL: imageurlForUpdate,
                                            //   category:
                                            //       updateCategoryController.text,
                                            // );
                                            updateIndex(index);
                                            // if(mounted){
                                            // }
                                            // Future<void>reload()async{
                                            // QuerySnapshot snapshot = await homeSellerTabInstance.fetchResName();
                                            // }
                                          },
                                          backgroundColor: AppColors.mainColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: const Text(
                                            "Add the updated Item",
                                            style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
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
                        onPressed: (context) {
                          removeIndex(index);
                        },
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(10),
                    height: 140,
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
 
                        Container(
                          height: 100,
                          width: 100,
 
                          decoration: BoxDecoration(
                               color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(image: NetworkImage("${document['imageURL']}"),
                             fit: BoxFit.cover,
 
 
                            ),
 
 
                          ),
                        ),
                        // Container(
                        //   height: 100,
                        //   width: 100,
                        //   child: Image.network(
                        //     "${document['imageURL']}",
 
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "${document['itemName']}",
                                    key: textKeys[index],
                                    style: const TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
 
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: 10,
                              ),
                              margin: const EdgeInsets.only(left: 20),
                              height: 50,
                              width: 200,
                              child: SingleChildScrollView(
                                child: Text(
                                  "${document['itemDescription']}",
                                ),
                              ),
                            ),
                             Padding(
                               padding: const EdgeInsets.only(left: 20),
                               child: Row(
                                 children: [
                                   Text(
                                          "${document['itemPrice']}",
                                          style: const TextStyle(
                                            fontFamily: 'Jua',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
 
                                    Text(
                                          "TK",
                                          style: const TextStyle(
                                            fontFamily: 'Jua',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
 
 
 
 
                                 ],
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
              Get.to(() => const AddNewItem2());
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
 