class Product {
  int id;
  String nom;
  String description;
  double prix;
  int? rating;
  String categorie;
  List<String> images;

  Product({
    required this.id,
    required this.nom,
    required this.description,
    required this.prix,
    required this.rating,
    required this.categorie,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nom: json['nom'],
      description: json['description'],
      prix: json['prix'].toDouble(),
      rating: json['rating'],
      categorie: json['categorie'],
      images: List<String>.from(json['images']),
    );
  }
}
