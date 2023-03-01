class OrderModel {
  String? id;
  String userName;
  String userPhone;
  String userMail;
  List<Map<String, dynamic>>allItems;
  int totalPrice;
  //String imageURL;
  String location;
  String paymentMethod;
  String timeNow;
  String date;
  OrderModel({
      this.id,
      required this.userName,
      required this.userPhone,
      required this.userMail,
      required this.allItems,
      required this.totalPrice,
      //required this.imageURL,
      required this.location,
      required this.paymentMethod,
      required this.timeNow,
      required this.date
    });
    toJson(){
      return {
        "userName": userName,
        "userPhone": userPhone,
        "userMail": userMail,
        "allItems": allItems,
        "itemPrice": totalPrice,
        //"imageURL": imageURL,
        "location": location,
        "paymentMethod": paymentMethod,
        "timeNow": timeNow,
        "date": date
      };
    }
}
