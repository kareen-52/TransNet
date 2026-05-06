import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double radius;
  final String imageUrl;

  const UserAvatar({
    super.key,
    required this.radius,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return 
    CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.outline,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}