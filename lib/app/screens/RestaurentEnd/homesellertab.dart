import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/Data/RestaurantEnd%20Repositories/resownerrepository.dart';
import 'package:project_mealman/app/Utils/diamensions.dart';
import 'package:project_mealman/app/core/app_colors.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/Controllers/resend_controller.dart';
//import 'package:project_mealman/app/screens/RestaurentEnd/eventordersRestaurantEnd.dart';
 
import 'addevent.dart';
import 'eventorderslistRestaurantEnd.dart';
 
class HomeSellerTab extends StatefulWidget {
const HomeSellerTab({super.key});
 
@override
State<HomeSellerTab> createState() => _HomeSellerTabState();
}
 
class _HomeSellerTabState extends State<HomeSellerTab> {
final _firestore = FirebaseFirestore.instance;
String _resName = "";
 
Future<QuerySnapshot?> fetchResName() async {
try {
User? user = FirebaseAuth.instance.currentUser;
//Logger().i("Inside the try ${user!.uid}");
if (user == null) {
_resName = "You are not logged in";
} else {
DocumentSnapshot snapshot = await FirebaseFirestore.instance
.collection("Authenticated_User_Info")
.doc(user.uid)
.get();
if (snapshot.exists) {
Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
// Logger().i(snapshot.data());
 
_resName = data['name'];
} else {
_resName = "No data found for the user";
}
 
ResEndController controller = Get.put(ResEndController());
controller.setResName(_resName);
final menuList =
await _firestore.collection("$_resName Menu").get().then((value) {
List<Map<String, dynamic>> items = [];
value.docs.forEach((element) {
items.add(element.data());
});
return items;
});
//List<QueryDocumentSnapshot> menuList = (await _firestore.collection("$_resName Menu").get()).docs;
controller.setMenuList(menuList);
return _firestore.collection("$_resName Menu").get();
}
} catch (e) {
Logger().i(_resName);
}
return null;
}
// void getResName() async {
// final resOwnerRepository = Get.put(ResOwnerRepository());
// resName = await resOwnerRepository.fetchResName().toString();
// //Logger().i(resName);
// }
 
@override
Widget build(BuildContext context) {
return FutureBuilder(
future: fetchResName(),
builder: (context, snapshot) {
// if (snapshot.connectionState == ConnectionState.done) {
// return const Center(child: Text("check your internet connection"));
// }
if (snapshot.connectionState == ConnectionState.waiting) {
return const Center(
child: CircularProgressIndicator(
color: AppColors.mainColor,
));
}
if (!snapshot.hasData) {
return const Center(child: Text("Your menu is empty"));
}
final documents = snapshot.data!.docs;
return SingleChildScrollView(
child: Container(
//height: 500,
// color: Colors.green,
width: double.infinity,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Padding(
padding: EdgeInsets.only(left: 16.0),
child: Text(
"Running Events",
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: AppColors.mainColor),
),
),
Padding(
padding: const EdgeInsets.all(8.0),
child: Container(
height: 500,
child: FutureBuilder(
future: FirebaseFirestore.instance
.collection("Authenticated_User_Info")
.doc(FirebaseAuth.instance.currentUser!.uid)
.get(),
builder: (context, snapshot) {
if (snapshot.hasData) {
String _resName = snapshot.data!.data()!['name'];
CollectionReference _reference = FirebaseFirestore.instance.collection("Resturnent Event");
print(_resName);
return StreamBuilder<QuerySnapshot>(
stream: _reference.snapshots(),
builder: (BuildContext context, AsyncSnapshot snapshot) {
if (snapshot.hasData) {
QuerySnapshot querySnapshot = snapshot.data;
List<QueryDocumentSnapshot> documents =
querySnapshot.docs;
List<Map> items =
documents.map((e) => e.data() as Map).toList();
return ListView.builder(
itemCount: items.length,
itemBuilder: (BuildContext context, int index) {
Map thisItem = items[index];
if ('${thisItem['returentname']}' == _resName) {
return Padding(
padding: const EdgeInsets.all(0.0),
child: Container(
decoration: BoxDecoration(
color: Colors.white, //HexColor("FE7C00"),
borderRadius: BorderRadius.circular(15),
boxShadow: [
BoxShadow(
color: Colors.grey,
offset: Offset(0.0, 1.0), //(x,y)
blurRadius: 6.0,
),
],
),
height: 80,
child: Row(
mainAxisAlignment:
MainAxisAlignment.spaceBetween,
children: [
Container(
height: 50,
width: 220,
decoration: BoxDecoration(
color: AppColors.mainColor,
borderRadius: BorderRadius.only(
bottomRight: Radius.circular(15),
topRight: Radius.circular(15)),
),
 
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Text(
'${thisItem['eventtitle']} ',
style: TextStyle(
fontSize: 20, color: Colors.white),
),
), //fetch event name here
),
ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: AppColors.mainColor,
shape: RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(15))),
onPressed: (() {
Get.to(() => EventOrdersRestaurant(('${thisItem['eventtitle']}')));// navigate to all order list of an event
}),
child: Text("See orders")),
],
)),
);
} else {
return Container();
}
});
} else {
return Container();
}
});
} else {
return const CircularProgressIndicator();
}
}),
),
),
SizedBox(
height: 20,
),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Container(
width: 300,
child: ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: AppColors.mainColor,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15))),
onPressed: (() {
Get.to(() =>
const AddEvent()); // navigate to all order list of an event
}),
child: Text(
"Add new Event",
style: TextStyle(fontSize: 25),
)),
),
],
),
],
),
),
);
 
//
 
// return Padding(
// padding: EdgeInsets.only(
// left: Diamensions.paddingOnly, right: Diamensions.paddingOnly),
// child: ListView.builder(
// itemCount: documents.length,
// itemBuilder: (_, index) {
// return Container(
// padding: EdgeInsets.all(Diamensions.paddingAll20),
// margin: EdgeInsets.all(Diamensions.paddingAll10),
// height:
// MediaQuery.of(context).size.height / 4.818604651162792,
// width: double.infinity,
// decoration: BoxDecoration(
// borderRadius:
// BorderRadius.circular(Diamensions.borderRadius30),
// color: Colors.white,
// //border: Border.all(),
// boxShadow: const [
// BoxShadow(
// color: Colors.black12,
// blurRadius: 5.0,
// offset: Offset(0, 5),
// ),
// BoxShadow(
// color: Colors.white,
// offset: Offset(-5, 0),
// ),
// ]),
// child: Row(
// children: [
// Image.network(
// documents[index]['imageURL'],
// width: Diamensions.containerWidth60,
// height: Diamensions.containerHeight150,
// fit: BoxFit.cover,
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Padding(
// padding: EdgeInsets.only(
// left: Diamensions.paddingOnly20,
// ),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceEvenly,
// children: [
// Text(
// documents[index]['itemName'],
// style: TextStyle(
// fontFamily: 'Ubuntu',
// fontSize: Diamensions.fontSize30,
// fontWeight: FontWeight.bold,
// color: AppColors.mainColor,
// ),
// ),
// // SizedBox(
// // width: Diamensions.sizedBoxWidth95,
// // ),
// // Text(
// // documents[index]["itemPrice"].toString(),
// // style: TextStyle(
// // fontFamily: 'Jua',
// // fontSize: Diamensions.fontSize16,
// // fontWeight: FontWeight.bold,
// // ),
// // ),
// ],
// ),
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Container(
// //color: Colors.amber,
// padding: EdgeInsets.only(
// top: Diamensions.paddingOnly10,
// ),
// margin: EdgeInsets.only(
// left: Diamensions.paddingOnly20),
// height: Diamensions.containerHeight95,
// width: Diamensions.containerWidth250 - 50,
// child: SingleChildScrollView(
// child: Text(
// documents[index]["itemDescription"],
// ),
// ),
// ),
// Text(
// documents[index]["itemPrice"].toString(),
// style: TextStyle(
// fontFamily: 'Jua',
// fontSize: Diamensions.fontSize16,
// fontWeight: FontWeight.bold,
// ),
// ),
// ],
// ),
// ],
// ),
// ],
// ),
// );
// }),
// );
});
}
}