import 'package:flutter/material.dart';

enum AvatarGradientType { blue, purple }

class AvatarCircle extends StatelessWidget {
  final String? url;
  final double radius;
  final String initials;
  final AvatarGradientType gradientType;

  const AvatarCircle({
    super.key,
    this.url,
    this.radius = 24,
    required this.initials,
    this.gradientType = AvatarGradientType.blue,
  });

  List<Color> _gradientColors() {
    switch (gradientType) {
      case AvatarGradientType.purple:
        return [Colors.purple, Colors.purpleAccent, Colors.purpleAccent];
      case AvatarGradientType.blue:
        return [
          Colors.blueAccent,
          Colors.deepPurpleAccent,
          Colors.deepPurpleAccent,
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.transparent,
      backgroundImage: url != null ? NetworkImage(url!) : null,
      child: url == null
          ? Container(
              width: radius * 2,
              height: radius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _gradientColors(),
                  stops: const [0.1, 0.6, 0.9],
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                initials,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: radius * 0.7,
                ),
              ),
            )
          : null,
    );
  }
}
