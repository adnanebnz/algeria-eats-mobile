// ignore_for_file: non_constant_identifier_names, file_names

import 'package:algeria_eats/features/auth/models/user.dart';

class DeliveryMan {
  int? user_id;
  int rating;
  User user;
  bool est_disponible;
  DateTime created_at;
  DateTime updated_at;

  DeliveryMan({
    required this.user_id,
    required this.rating,
    required this.est_disponible,
    required this.created_at,
    required this.updated_at,
    required this.user,
  });
  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'rating': rating,
      'est_disponible': est_disponible,
      'created_at': created_at,
      'updated_at': updated_at,
      'user': user.toMap(),
    };
  }

  factory DeliveryMan.fromJson(Map<String, dynamic> map) {
    return DeliveryMan(
      user_id: map['user_id'],
      rating: map['rating'],
      est_disponible: map['est_disponible'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
      user: User.fromJson(map['user']),
    );
  }
}
