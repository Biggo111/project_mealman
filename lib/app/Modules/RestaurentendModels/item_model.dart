
class ItemModel {
  String? id;
  String itemName;
  String itemDespriction;
  String itemPrice;
  String imageURL;
  String category;
  ItemModel({
      this.id,
      required this.itemName,
      required this.itemDespriction,
      required this.itemPrice,
      required this.imageURL,
      required this.category
    });
    toJson(){
      return {
        "itemName": itemName,
        "itemDescription": itemDespriction,
        "itemPrice": itemPrice,
        "imageURL": imageURL,
        "category": category,
      };
    }
}
