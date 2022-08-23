class TypeAddressModel {
  static final items = [
    Item(id: 1, name: "Home", image: "assets/image/ic_home_outline.svg"),
    Item(id: 2, name: "Work", image: "assets/image/ic_work_outline.svg"),
    Item(id: 3, name: "Other", image: "assets/image/ic_location_outline.svg"),
  ];
}

class Item {
  final int id;
  final String name;

  final String image;

  Item({required this.id, required this.name, required this.image});
}
