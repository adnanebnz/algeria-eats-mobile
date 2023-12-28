// ignore_for_file: file_names, non_constant_identifier_names

class DeliveryMan {
  int? id;
  String nom;
  String prenom;
  String email;
  String image;
  int rating;
  bool est_disponible;

  DeliveryMan(
      {required this.id,
      required this.nom,
      required this.prenom,
      required this.email,
      required this.rating,
      required this.image,
      required this.est_disponible});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'rating': rating,
      'est_disponible': est_disponible,
      'image': image
    };
  }

  factory DeliveryMan.fromMap(Map<String, dynamic> map) {
    return DeliveryMan(
        id: map['id'],
        nom: map['nom'],
        prenom: map['prenom'],
        email: map['email'],
        rating: map['rating'],
        image: map['image'],
        est_disponible: map['est_disponible']);
  }
}
