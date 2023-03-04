//All the event list
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_mealman/app/screens/UserEnd/Events_Option/eventmenulist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 
class EventListForUser extends StatefulWidget {
  const EventListForUser({super.key});
 
  @override
  State<EventListForUser> createState() => _EventListForUserState();
}
 
class _EventListForUserState extends State<EventListForUser> {
  void loader() async {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      await FirebaseFirestore.instance
          .collection("Resturnent Event")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          final map = element.data();
          if (DateTime.now().compareTo(
                  DateTime.fromMillisecondsSinceEpoch(map['endtime'])) >
              0) {
            FirebaseFirestore.instance
                .collection('Resturnent Event')
                .doc(element.id)
                .delete();
          }
        });
      });
    }
  }
 
  @override
  void initState() {
    loader();
    super.initState();
  }
 
  String formatTime(int milisec) =>
      DateTime.fromMillisecondsSinceEpoch(milisec).toString().substring(10, 16);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("FE7C00"),
          title: const Text("Running Events"),
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('Resturnent Event')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  QuerySnapshot querySnapshot = snapshot.data;
                  List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                  List<Map> items =
                      documents.map((e) => e.data() as Map).toList();
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map thisItem = items[index];
                        return Padding(
                          padding: EdgeInsets.all(5.0.sp),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white, //HexColor("FE7C00"),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.r)),
                              boxShadow: const[
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            height: 100.w,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 50.h,
                                      width: 200.w,
                                      decoration: BoxDecoration(
                                          color: HexColor("FE7C00"),
                                          borderRadius: BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(20.r))),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 12.0.w, top: 12.0.h),
                                        child: Text(
                                          "${thisItem['eventtitle']}",
                                          style: TextStyle(
                                              fontSize: 25.sp,
                                              color: Colors.white),
                                        ), //Fetch event name in this text
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0.w),
                                      child: TextButton(
                                        onPressed: (() {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EventUserEnd(
                                                  username:
                                                      '${thisItem['eventtitle']}'),
                                            ),
                                          );
                                        }),
                                        child: Text(
                                          "See Event",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 12.0.w, top: 12.0.h),
                                      child: Text(
                                        "End : ${formatTime(thisItem['endtime'])}",
                                        style: TextStyle(
                                            fontSize: 20.sp, color: Colors.black),
                                      ), //Fetch event name in this text
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 12.0.w, bottom: 12.0.h),
                                      child: Text(
                                        "Delivery : ${thisItem['deliverytime']}",
                                        style: TextStyle(
                                            fontSize: 20.sp, color: Colors.black),
                                      ), //Fetch event delivery in this text
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
 