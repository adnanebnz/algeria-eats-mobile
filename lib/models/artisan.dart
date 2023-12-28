// ignore_for_file: non_constant_identifier_names

class Artisan {
  int? id;
  String nom;
  String prenom;
  String email;
  String image;
  int rating;
  String desc_entreprise;
  DateTime heure_ouverture;
  DateTime heure_fermeture;

  Artisan({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.rating,
    required this.image,
    required this.desc_entreprise,
    required this.heure_ouverture,
    required this.heure_fermeture,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'image': image,
      'rating': rating,
      'desc_entreprise': desc_entreprise,
      'heure_ouverture': heure_ouverture,
      'heure_fermeture': heure_fermeture,
    };
  }

  factory Artisan.fromMap(Map<String, dynamic> map) {
    return Artisan(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      image: map['image'],
      email: map['email'],
      rating: map['rating'],
      desc_entreprise: map['desc_entreprise'],
      heure_ouverture: map['heure_ouverture'],
      heure_fermeture: map['heure_fermeture'],
    );
  }
}
