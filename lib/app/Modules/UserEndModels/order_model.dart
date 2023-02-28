class OrderModel {
  String? id;
  String userPhone;
  String userMail;
  String itemName;
  int totalPrice;
  String imageURL;
  String location;
  String paymentMethod;
  OrderModel({
      this.id,
      required this.userPhone,
      required this.userMail,
      required this.itemName,
      required this.totalPrice,
      required this.imageURL,
      required this.location,
      required this.paymentMethod,
    });
    toJson(){
      return {
        "userPhone": userPhone,
        "userMail": userMail,
        "itemName": itemName,
        "itemPrice": totalPrice,
        "imageURL": imageURL,
        "location": location,
        "paymentMethod": paymentMethod
      };
    }
}
