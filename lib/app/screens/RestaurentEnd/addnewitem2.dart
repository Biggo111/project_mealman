import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/Controllers/resend_controller.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/restaurent_home_screen.dart';
import 'dart:io';
import '../../Data/RestaurantEnd Repositories/resownerrepository.dart';
import '../../Modules/RestaurentendModels/item_Model.dart';
import '../../core/app_colors.dart';
import '../UserEnd/Drawers/MyDrawer.dart';

class AddNewItem2 extends StatefulWidget {
  const AddNewItem2({super.key});

  @override
  State<AddNewItem2> createState() => _AddNewItem2State();
}

class _AddNewItem2State extends State<AddNewItem2> {


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
  //final resEndController = Get.put(ResEndController());
  
  String dropdownvalue = 'Rice';
  String dropdownvalue2="";

  // List of items in our dropdown menu
  var items = [
    'Rice',
    'Fast Food',
    'Beverage',
    
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: ()async{
          Get.to(()=>const RestaurentHomeScreen());
          return false;
        },
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/userend_images/vector.png"),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            drawer: MyDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "Add Item",
                style: TextStyle(fontSize: 20),
              ), //Fetch from database-restaurant name
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " Add new item",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        _getEventImageCover(),
                        _getEventFormFields(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getEventImageCover() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // image: DecorationImage(
                  //     image: AssetImage("assets/userend_images/vector.png"),
                  //     fit: BoxFit.scaleDown)
                ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add event cover image"),
                      Container(
                        width: 46,
                        child: _getImagePicker(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _getEventFormFields() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getName(),
                  SizedBox(
                    height: 10,
                  ),
                  _getDescription(),
                 
                   SizedBox(
                    height: 10,
                  ),
                  _getItemPrice(),
                   SizedBox(
                    height: 10,
                  ),
                  _getQuantity(),
                   SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select category",style: TextStyle(fontSize: 20,),),
                      _getCategory(),
                    ],
                  ),

                  _getSubmitButton(context),
                  
                ],
              ),
            ),
          )),
    );
  }
  Widget _getItemPrice() {
    return TextFormField(
        decoration: const InputDecoration(labelText: "Enter Item Price "),
        controller: priceController,
      );
  }
  Widget _getQuantity() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Enter Quantity"),
      controller: quantityController,
    );
  }

  Widget _getSubmitButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor("FE7C00"),
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              onPressed: () async{
                if (iteamNameController.text.isEmpty ||
              priceController.text.isEmpty ||
              quantityController.text.isEmpty ||
              itemDescriptionController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Please fill up all the fields"),
            ));
            return;
          }
          if (imageurl.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Please Upload an Image"),
            ));
            return;
          }
          // creatIteam(iteamControler.text, priceController.text,
          //     quantityController.text,itemDescriptionController.text);
          final item = ItemModel(
            itemName: iteamNameController.text.trim(),
            itemDespriction: itemDescriptionController.text.trim(), 
            itemPrice: double.parse(priceController.text.trim()),
            //imageURL: _imageFile != null ? _imageFile!.path.toString() : '',
            imageURL: imageurl,
            category: categoryController.text.trim(),
          );
          
          //Logger().i(item.itemName);
          //resOwnerRepository.createItem(item);
          createItem(item);
              },
              child: Text(
                "Submit",
                style: TextStyle(fontSize: 20),
              )),
        ),
      ],
    );
  }

  Widget _getName() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Enter item name"),
      controller: iteamNameController,
    );
  }

  Widget _getDescription() {
    return TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: const InputDecoration(labelText: "Enter Item Description"),
        controller: itemDescriptionController,
      );
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
      : 
    Container(
        //use image picker and then preview the image on the preview container
        decoration: BoxDecoration(
          border: Border.all(color: HexColor("FE7C00")),
           image: DecorationImage(
                    image: FileImage(File(_imageFile!.path)),
                    fit: BoxFit.cover,
                  ),
        ),
        ),
    );
  }

  Widget _getCategory()
  {
    return DropdownButton(
                    
                    value: dropdownvalue,

                    
                    icon: const Icon(Icons.keyboard_arrow_down),

                   
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items,style: TextStyle(fontSize: 15),),
                      );
                    }).toList(),
                    
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                        dropdownvalue2 = newValue;
                      });
                    },
                  );
  }

  Widget _getImagePicker() {
    return TextButton(
       
        onPressed: () async {
         file =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (file == null) {
            return;
          }
          // _imageFile = file;
          // Logger().i("The image file is $_imageFile");
          setState(() {
            _imageFile = file;
            //Logger().i("The image file is $_imageFile");
          });
          Reference referenceroot = FirebaseStorage.instance.ref();
          Reference referencefirst = referenceroot.child('images');
          Reference referenceimageupload = referencefirst.child(file!.path);
          try {
            await referenceimageupload.putFile(File(file!.path));
            imageurl = await referenceimageupload.getDownloadURL();
            //Logger().i(" The image URL is - $imageurl");
          } catch (e) {
            //Logger().i(e);
          }
          if (imageurl.isEmpty) {
            //Logger().i("Image URl is Empty");
            (ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Add an image")),
            ));
            return;
          }
        },
        child: Text("Here",style: TextStyle(color:HexColor("FE7C00")),),
    );

  }

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
      setState(() {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    "Item added",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Jua"),
                                  ),
                                  content: const Text(
                                    "You will see the item in the items list!",
                                    style: TextStyle(
                                        fontSize: 17, fontFamily: "Ubuntu"),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Get.to(() => const RestaurentHomeScreen());
                                      },
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(
                                            color: AppColors.mainColor),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
    });
  }
}