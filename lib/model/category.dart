

class Category {
  final String name;
  final String imageUrl;

  const Category({required this.name, required this.imageUrl});

  List<Object?> get props => [name, imageUrl];

  static List<Category> categories = [
    const Category(
        name: "Filipino Cuisine ",
        imageUrl:
            "https://upload.wikimedia.org/wikipedia/commons/8/88/Philippine_Food.jpg"),
    const Category(
        name: "Chinese Cuisine",
        imageUrl:
            "https://foodnerdy.com/blog/wp-content/uploads/2021/05/Chinese-Cuisine.jpg"),
  ];
}
