import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
//import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:logger/logger.dart';
//import 'package:project_mealman/app/screens/UserEnd/RestaurantPart/emenue.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_mealman/app/screens/UserEnd/Events_Option/eventmenulist.dart';
 
class EventsList extends StatefulWidget {
  const EventsList({super.key});
 
  @override
  State<EventsList> createState() => _EventsListState();
}
 
class _EventsListState extends State<EventsList> {
  String name = "";
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Here are all the resturent event list"),
        backgroundColor: HexColor("FE7C00"),
      ),
      body: Container(
 
            decoration: (BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/userend_images/rice.jpg"),
                  fit: BoxFit.cover),
              color: Color.fromARGB(255, 219, 210, 207),
              //borderRadius: BorderRadius.circular(15),
            )),
        child: FutureBuilder(
            future:
                FirebaseFirestore.instance.collection("Resturnent Event").get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                CollectionReference _reference =
                    FirebaseFirestore.instance.collection("Resturnent Event");
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
                              return Container(
                                height: 150,
                                width: 100,
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
 
                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(180)),
 
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: HexColor("FE7C00"),
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: 100,
                                                width: 100,
                                                child: Text(
                                                    '${thisItem['eventtitle']}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                height: 100,
                                                width: 100,
                                                child: Text(
                                                    'End:${thisItem['endtime']}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                height: 100,
                                                width: 100,
                                                child: Text(
                                                    'Delivary Time:${thisItem['deliverytime']}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )
                                            ]),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => EventMenuList(
                                                      '${thisItem['eventtitle']}')));
                                          check(
                                              '${thisItem['endtime']}',
                                              '${thisItem['deliverytime']}',
                                              '${thisItem['eventtitle']}');
                                        }),
                                  ),
                                ),
                              );
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
    );
  }
 
  Future remove(title) async {
    FirebaseFirestore.instance
        .collection('Resturnent Event')
        .doc(title)
        .delete();
  }
 
  void check(String endtime, String deleverytime, String eventtitle) {
    var today = DateTime.now();
    int hour = today.hour;
    int minute = today.minute;
    List<String> okstring = endtime.split('.');
    if (okstring.length == 1) {
      okstring.add("0");
    }
    String Hour = okstring[0];
    String Minute = okstring[1];
    int Hourr = int.parse(Hour);
    int Minutee = int.parse(Minute);
    print(okstring);
    if (hour >= Hourr) {
      if (minute >= Minutee) {
        remove(eventtitle);
      }
    }
  }
}