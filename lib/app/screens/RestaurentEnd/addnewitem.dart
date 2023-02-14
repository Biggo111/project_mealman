import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/Data/RestaurantEnd%20Repositories/resownerrepository.dart';
import 'package:project_mealman/app/Modules/RestaurentendModels/item_model.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  TextEditingController iteamNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  String imageurl = '';
  XFile? _imageFile;
  XFile? file;
  final resOwnerRepository = Get.put(ResOwnerRepository());
  final _database = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("EDDFDF"),
      appBar: AppBar(
          leading: const BackButton(color: Colors.white),
          backgroundColor: HexColor("FE7C00"),
          title: Title(
            color: Colors.white,
            child: const Text(
              "Add a new Item",
              style: TextStyle(fontSize: 25),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _getSizedBox(),
            _getName(),
            _getSizedBox(),
            _getDescription(),
            _getSizedBox(),
            _getQuantity(),
            _getSizedBox(),
            _getItemPrice(),
            _getSizedBox(),
            _getItemCategory(),
            _getSizedBox(),
            _getImagePreview(),
            _getSizedBox(),
            _getImagePicker(),
            _getSizedBox(),
            _getSubmitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _getName() {
    return TextFormField(
      controller: iteamNameController,
      decoration: const InputDecoration(labelText: "Enter Item Name"),
    );
  }

  Widget _getQuantity() {
    return TextFormField(
        keyboardType: TextInputType.multiline,
        controller: quantityController,
        maxLines: null,
        decoration: const InputDecoration(labelText: "Enter Item Quantity"));
  }

  Widget _getSizedBox() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget _getItemPrice() {
    return TextFormField(
        controller: priceController,
        decoration: const InputDecoration(labelText: "Enter Item Price "));
  }
  Widget _getItemCategory() {
    return TextFormField(
        controller: categoryController,
        decoration: const InputDecoration(labelText: "Enter Item Category"));
  }
  Widget _getDescription() {
    return TextFormField(
        controller: itemDescriptionController,
        decoration:
            const InputDecoration(labelText: "Enter Item Description "));
  }

  Widget _getImagePreview() {
    return Center(
      child: _imageFile==null?
      Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(color: HexColor("FE7C00")),
        ),
        child: const Center(child: Text("Add an image")),
    )
      :Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(color: HexColor("FE7C00")),
           image: DecorationImage(
                    image: FileImage(File(_imageFile!.path)),
                    fit: BoxFit.cover,
                  ),
        ),
    )
    );
  }

  Widget _getImagePicker() {
    return IconButton(
        onPressed: () async {
          //ImagePicker imagePicker = ImagePicker();
          file =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (file == null) {
            return;
          }
          // _imageFile = file;
          // Logger().i("The image file is $_imageFile");
          setState(() {
            _imageFile = file;
            Logger().i("The image file is $_imageFile");
          });
          Reference referenceroot = FirebaseStorage.instance.ref();
          Reference referencefirst = referenceroot.child('images');
          Reference referenceimageupload = referencefirst.child(file!.path);
          try {
            await referenceimageupload.putFile(File(file!.path));
            imageurl = await referenceimageupload.getDownloadURL();
            Logger().i(" The image URL is - $imageurl");
          } catch (e) {
            Logger().i(e);
          }
          if (imageurl.isEmpty) {
            Logger().i("Image URl is Empty");
            (ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Add an image")),
            ));
            return;
          }
        },
        icon: const Icon(
          Icons.camera_alt,
          size: 40,
        ));
  }

  Widget _getSubmitButton(context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: HexColor("FE7C00"),
          elevation: 3.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        ),
        onPressed: () async {
          if (iteamNameController.text.isEmpty ||
              priceController.text.isEmpty ||
              quantityController.text.isEmpty ||
              itemDescriptionController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Please fill up all the fields"),
            ));
            return;
          }
          // if (imageurl.isEmpty) {
          //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //     content: Text("Please Upload an Image"),
          //   ));
          //   return;
          // }
          // creatIteam(iteamControler.text, priceController.text,
          //     quantityController.text,itemDescriptionController.text);
          final item = ItemModel(
            itemName: iteamNameController.text,
            itemDespriction: itemDescriptionController.text, 
            itemPrice: double.parse(priceController.text),
            //imageURL: _imageFile != null ? _imageFile!.path.toString() : '',
            imageURL: imageurl,
            category: categoryController.text,
          );
          
          //Logger().i(item.itemName);
          //resOwnerRepository.createItem(item);
          createItem(item);
        },
        child: const Text("Submit"));
  }
  // Future creatIteam(
  //     String itemName, String itemPrice, String itemQuantity , String description) async {
  //   await Future.delayed(const Duration(seconds: 5));
  //   final docuser = FirebaseFirestore.instance
  //       .collection('Sarash')
  //       .doc(iteamControler.text);
  //   final jsona = {
  //     'Iteam name': itemName,
  //     'Price': itemPrice,
  //     'Description':description,
  //     'Quantity': itemQuantity,
  //     'image': imageurl,
  //   };
  //   docuser.set(jsona);
  //   (ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text("Item added"),
  //   )));
  // }
  void createItem(ItemModel itemModel)async{
    User? user = FirebaseAuth.instance.currentUser;
    if(user==null){
      return;
    }
    if(imageurl.isEmpty){
      return;
    }
    await Future.delayed(const Duration(seconds: 5));
    String resName = await FirebaseFirestore.instance.collection("Authenticated_User_Info").doc(user.uid).get().then((value)=>value.data()!['name']);
    await _database.collection("$resName Menu").doc(itemModel.itemName).set(itemModel.toJson()).whenComplete((){
      Logger().i("Items added");
    });
  }
}
