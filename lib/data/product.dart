class ProductEntity {
  final int id;
  final String title;
  final String description;
  final int price;
  final double rating;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  ProductEntity(this.id, this.title, this.description, this.price, this.rating,
      this.brand, this.category, this.thumbnail, this.images);

  ProductEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        price = json['price'],
        rating = (json['rating'] ?? 0) + 0.0, // to convert int to double
        brand = json['brand'],
        category = json['category'],
        thumbnail = json['thumbnail'] ?? '',
        images =
            ((json['images'] ?? []) as List).map((item) => item as String).toList();

  @override
  String toString() {
    return 'ProductEntity{id: $id, title: $title, description: $description, price: $price, brand: $brand, category: $category, thumbnail: $thumbnail, images: $images}';
  }
}
