class SelectedProductsModel {
  final String title;
  final int stock;
  double price;
  final double originalPrice;
  int qty;

  SelectedProductsModel({
    required this.title,
    required this.stock,
    required this.price,
    required this.qty,
    required this.originalPrice,
  });

  where(bool Function(dynamic product) param0) {}

  void add(SelectedProductsModel copiedProduct) {}
}
