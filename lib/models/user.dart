class User {
  int? id;
  String nom;
  String prenom;
  String email;
  String? image;

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'image': image,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'],
        nom: map['nom'],
        prenom: map['prenom'],
        email: map['email'],
        image: map['image']);
  }
}
