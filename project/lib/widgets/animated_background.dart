// widgets/animated_background.dart
import 'package:flutter/material.dart';


class AnimatedBackground extends StatelessWidget {
  final Widget child;
  
  const AnimatedBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // GIF background
        Positioned.fill(
           top: 10.0,    // Distance from the top edge
          bottom: 20.0, // Distance from the bottom edge
          child: Image.asset(
            'lib/assets/loop.gif',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.3), // Adjust opacity as needed
          ),
        ),
        // The main content with SafeArea
        SafeArea(
          child: child,
        )
      ],
    );
  }
}