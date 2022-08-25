class SortByVariables {
  static final items = [
    Item(
      id: 1,
      name: "Price: Low to high",
    ),
    Item(
      id: 2,
      name: "Price: High to Low",
    ),
    Item(
      id: 3,
      name: "New arrivals",
    ),
  ];
}

class Item {
  final int id;
  final String name;

  Item({
    required this.id,
    required this.name,
  });
}

class SortByPriceVariables {
  static final priceitemsitems = [
    PriceItem(id: 1, price1: "\$300", price2: "\$500"),
    PriceItem(id: 2, price1: "\$300", price2: "\$2000"),
    PriceItem(id: 3, price1: "\$5000", price2: "\$7000"),
    PriceItem(id: 3, price1: "\$300", price2: "\$5000"),
    PriceItem(id: 3, price1: "\$3000", price2: "\$2000"),
    PriceItem(id: 3, price1: "\$5000", price2: "\$7000")
  ];
}

class PriceItem {
  final int id;
  final String price1;
  final String price2;

  PriceItem({required this.id, required this.price1, required this.price2});
}
