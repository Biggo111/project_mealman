import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../UserEnd/Drawers/MyDrawer.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  String dropdownvalue = 'Rice';

  // List of items in our dropdown menu
  var items = [
    'Rice',
    'Fastfood',
    'Drinks',
    
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/addnewitemcover.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Sarah's Cafe",
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
                  image: DecorationImage(
                      image: AssetImage("assets/images/Vector.png"),
                      fit: BoxFit.scaleDown)),
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
        decoration: const InputDecoration(labelText: "Enter Item Price "));
  }
  Widget _getQuantity() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Enter Quantity"),
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
              onPressed: () {},
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
    );
  }

  Widget _getDescription() {
    return TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: const InputDecoration(labelText: "Enter Item Description"));
  }

  Widget _getImagePreview() {
    return Container(
        //use image picker and then preview the image on the preview container
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
                      });
                    },
                  );
  }

  Widget _getImagePicker() {
    return TextButton(
       
        onPressed: () async {
          ImagePicker imagePicker = ImagePicker();
          XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
          print("${file?.path}");
        },
        child: Text("Here",style: TextStyle(color:HexColor("FE7C00")),),
    );

  }
}