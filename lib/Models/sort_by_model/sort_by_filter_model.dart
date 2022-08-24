class SortByVariables {
  static final items = [
    Item(id: 1, name: "Price: Low to high", ),
    Item(id: 2, name: "Price: High to Low",),
    Item(id: 3, name: "New arrivals",),
  ];
}

class Item {
  final int id;
  final String name;



  Item({required this.id, required this.name,});
}
