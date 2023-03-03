import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_mealman/app/core/app_colors.dart';
 
class CreditApproval extends StatefulWidget {
  @override
  State<CreditApproval> createState() => _CreditApprovalState();
}
 
class _CreditApprovalState extends State<CreditApproval> {
  Widget build(context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              title: Text("Pending Requests"),
              backgroundColor: HexColor("FE7C00")),
          body: Container(
            decoration: (BoxDecoration(
              // image: DecorationImage(
              //     image: AssetImage("assets/userend_images/crdit.jpg"),
              //     fit: BoxFit.cover),
              color: HexColor("EDDFDF"),
              //borderRadius: BorderRadius.circular(15),
            )),
            child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("Authenticated_User_Info")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String _resName = snapshot.data!.data()!['name'];
                    CollectionReference _reference = FirebaseFirestore.instance
                        .collection("$_resName Credit Request");
                    return StreamBuilder<QuerySnapshot>(
                        stream: _reference.snapshots(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            QuerySnapshot querySnapshot = snapshot.data;
                            List<QueryDocumentSnapshot> documents =
                                querySnapshot.docs;
                            List<Map> items =
                                documents.map((e) => e.data() as Map).toList();
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                  itemCount: items.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    Map thisItem = items[index];
                                    if ('${thisItem['CreditStatus']}' == "False") {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 120,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     
                                                children: [
     
     
                                                  Container(
                                                    height: 30,
                                                    width: double.infinity,
     
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('${thisItem['UserName']}',style: TextStyle(fontSize: 20,color: HexColor("FF7E00")),),
                                                        Text(" requested ",style: TextStyle(fontSize: 20)),
     
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                            '${thisItem['Credit']} MealCoin',style: TextStyle(fontSize: 20))
     
     
                                                      ],
                                                    ),
     
     
     
                                                  ),
     
                                                   SizedBox(
                                                    height: 5,
     
                                                  ),
                                                  //Text('${thisItem['UserName']}'),
                                                  // Text('${thisItem['Credit']} Coin',),
     
     
                                                  SizedBox(
                                                    height: 5,
     
                                                  ),
     
                                                  Row(
                                                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                20)),
                                                            backgroundColor:
                                                                Colors.green,
                                                          ),
                                                          onPressed: () {
                                                            ApproveCreditt(
                                                              _resName,
                                                              '${thisItem['UserName']}',
                                                              '${thisItem['Credit']}',
                                                              '${thisItem['RequestNumber']}',
                                                            );
                                                          },
                                                          child: Text("Approve")),
     
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                20)),
                                                            backgroundColor:
                                                                Colors.red,
                                                          ),
                                                          onPressed: () {
                                                            remove(_resName,
                                                                '${thisItem['RequestNumber']}');
                                                          },
                                                          child: Text("Decline")),
                                                    ],
                                                  )
                                                ]),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                            );
                          } else {
                            return Container();
                          }
                        });
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          )),
    );
  }
 
  Future ApproveCreditt(String _resName, String UserName, String NewCredit,
      String RequestNumber) async {
    final docuser = FirebaseFirestore.instance
        .collection('$_resName Credit Request')
        .doc(RequestNumber);
    Logger().i("Hello");
    final jsona = {
      'UserName': UserName,
      'Credit': NewCredit,
      'CreditStatus': 'True',
      "RequestNumber": RequestNumber,
    };
    docuser.set(jsona);
    var a = await FirebaseFirestore.instance
        .collection('$_resName User Credit list')
        .doc(UserName)
        .get();
    if (a.exists) {
      UpdateCredit(_resName, UserName, NewCredit);
    } else {
      AddUserAndUpdateCredit(_resName, UserName, NewCredit);
    }
  }
 
  Future AddUserAndUpdateCredit(
      String _resName, String UserName, String NewCreditt) async {
    final docuser = FirebaseFirestore.instance
        .collection('$_resName User Credit list')
        .doc(UserName);
    Logger().i("$UserName");
    final jsona = {
      'UserName': UserName,
      'Credit': NewCreditt,
    };
    docuser.set(jsona);
  }
 
  Future UpdateCredit(
      String _resName, String UserName, String NewCredit) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('$_resName User Credit list')
        .where('UserName', isEqualTo: UserName)
        .get();
    String OldCredit = querySnapshot.docs[0].get('Credit');
    //Logger().i(a);
    int oldCreditt = int.parse(OldCredit);
    int newCreditt = int.parse(NewCredit);
    newCreditt = newCreditt + oldCreditt;
    String stringValue = newCreditt.toString();
    final doc = querySnapshot.docs[0];
    final jsona = {
      'UserName': UserName,
      'Credit': stringValue,
    };
    await FirebaseFirestore.instance
        .collection('$_resName User Credit list')
        .doc(doc.id)
        .set(jsona);
  }
 
  Future remove(String _resName, String RequestNumber) async {
    FirebaseFirestore.instance
        .collection('$_resName Credit Request')
        .doc(RequestNumber)
        .delete();
  }
}