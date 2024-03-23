import 'package:flutter/material.dart';

class UserProfilePic extends StatelessWidget {
  const UserProfilePic({
    Key? key,
    this.image = "assets/images/profile-pic.png",
    this.radius = 25,
  }) : super(key: key);

  final String? image;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (image == null ||
          image!.isEmpty ||
          image == "assets/images/profile-pic.png") {
        return CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: radius,
          backgroundImage: const AssetImage(
            "assets/images/profile-pic.png",
          ),
        );
      } else {
        return CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(
            image!,
          ),
        );
      }
    });
  }
}
