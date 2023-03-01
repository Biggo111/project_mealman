import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
 import 'package:hexcolor/hexcolor.dart';
 
class CreditApproval extends StatefulWidget {
  @override
  State<CreditApproval> createState() => _CreditApprovalState();
}
 
class _CreditApprovalState extends State<CreditApproval> {
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(title: Text("Credit Approval"), backgroundColor: HexColor("FE7C00")),
        body: Container(
           decoration: (BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/userend_images/crdit.jpg"),
                fit: BoxFit.cover),
            color: Colors.brown,
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
                  CollectionReference _reference = FirebaseFirestore.instance.collection("$_resName Credit Request");
                  return StreamBuilder<QuerySnapshot>(
                      stream: _reference.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          QuerySnapshot querySnapshot = snapshot.data;
                          List<QueryDocumentSnapshot> documents =  querySnapshot.docs;
                          List<Map> items =documents.map((e) => e.data() as Map).toList();
                          return ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map thisItem = items[index];
                                if ('${thisItem['CreditStatus']}' == "False") {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                        Text('${thisItem['UserName']}'),
                                        Text('${thisItem['Credit']} Coin',),
                                        ElevatedButton(
                                            onPressed: () {
                                              ApproveCreditt(
                                                  _resName,
                                                  '${thisItem['UserName']}',
                                                  '${thisItem['Credit']}',
                                                  '${thisItem['RequestNumber']}', 
                                                  );
                                            },
                                            child: Text("Aprove")),
                                        ElevatedButton(
                                            onPressed: () {
                                              remove(_resName,
                                                  '${thisItem['RequestNumber']}');
                                            },
                                            child: Text("Decline")),
                                      ]),
                                    ),
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
        ));
  }
 
  Future ApproveCreditt(
      String _resName, String UserName, String NewCredit,String RequestNumber) async {
    final docuser = FirebaseFirestore.instance
        .collection('$_resName Credit Request')
        .doc(RequestNumber);
         Logger().i("Hello");
    final jsona = {
      'UserName': UserName,
      'Credit': NewCredit,
      'CreditStatus': 'True',
      "RequestNumber":RequestNumber,
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