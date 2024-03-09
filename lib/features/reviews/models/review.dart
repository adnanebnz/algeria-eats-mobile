// ignore_for_file: non_constant_identifier_names

class Review {
  int id;
  int user_id;
  int product_id;
  String title;
  String comment;
  int? rating;

  Review({
    required this.id,
    required this.user_id,
    required this.product_id,
    required this.title,
    required this.comment,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': user_id,
      'product_id': product_id,
      'title': title,
      'comment': comment,
      'rating': rating,
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      user_id: json['user_id'],
      product_id: json['product_id'],
      title: json['title'],
      comment: json['comment'],
      rating: json['rating'],
    );
  }
}
