class CreateProduct {
  final String title;
  final String description;
  final int price;
  final String brand;
  final String category;
  final String thumbnail;

  CreateProduct(
      {required this.title,
      required this.description,
      required this.price,
      required this.brand,
      required this.thumbnail,
      required this.category});

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'price': price,
        'brand': brand,
        'category': category,
        'thumbnail': thumbnail,
        'images': [thumbnail]
      };

  @override
  String toString() {
    return 'CreateProduct{title: $title, description: $description, price: $price, brand: $brand, category: $category, thumbnail: $thumbnail}';
  }
}
