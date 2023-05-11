import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/home/info_cars/info_car_controller.dart';
import 'package:provider/provider.dart';

class LikeButton extends StatelessWidget {
  final String id;
  final String email;
  const LikeButton({Key? key, required this.id, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InfoCarController controller = context.watch<InfoCarController>();

    return IconButton(
      onPressed: () {
        controller.isLiked = !controller.isLiked;
        controller.favoriteCar(id,email);
        },
      icon: Icon(
        Icons.favorite,
        color: controller.isLiked ? Colors.red : Colors.grey,
        size: 40,
      ),
    );
  }
}
