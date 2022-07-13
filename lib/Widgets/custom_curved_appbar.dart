import 'package:flutter/material.dart';

// Custom Curved Container On Discover Screen

class CustomCurvedAppbar extends StatelessWidget {
  const CustomCurvedAppbar({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        width: double.infinity,
        height: 110, //screenHeight * 0.25,
        decoration: const BoxDecoration(
          color: Colors.amber,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(231, 65, 98, 1),
              Color.fromRGBO(245, 171, 96, 1)
            ],
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 50);
    var controller = Offset(size.width / 2, 85);
    var end = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(
      controller.dx,
      controller.dy,
      end.dx,
      end.dy,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
