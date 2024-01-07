// ignore_for_file: file_names, non_constant_identifier_names

class UserReview {
  int id;
  int user_id;
  int reviewer_id;
  String review;
  int rating;
  String status;

  UserReview({
    required this.id,
    required this.user_id,
    required this.reviewer_id,
    required this.review,
    required this.rating,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': user_id,
      'reviewer_id': reviewer_id,
      'review': review,
      'rating': rating,
      'status': status,
    };
  }

  factory UserReview.fromJson(Map<String, dynamic> json) {
    return UserReview(
      id: json['id'],
      user_id: json['user_id'],
      reviewer_id: json['reviewer_id'],
      review: json['review'],
      rating: json['rating'],
      status: json['status'],
    );
  }
}
