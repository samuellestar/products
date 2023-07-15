class Product {
  final String title;
  final int stock;
  final double price;

  const Product({
    required this.title,
    required this.stock,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        title: json['title'] ?? "",
        stock: json['stock'] ?? 0,
        price: json['price'] == null
            ? 0.0
            : double.parse(json['price'].toString()),
      );

  set quantity(int quantity) {}
}
