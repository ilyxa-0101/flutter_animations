import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> animation;

  final Tween<double> opacityTween = Tween<double>(begin: 0.0, end: 1.0);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    )..addListener(() {
        setState(() {});
      });
    animation = opacityTween
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.translate(
              offset: Offset(0, (animation.value * 300 - 300)),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.yellow,
                child: Center(
                  child: Text(
                    "Animated square."
                    " Press button to return to start position",
                    style: TextStyle(
                        color: Colors.black.withValues(alpha: animation.value)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                if (_controller.isCompleted) {
                  _controller.reset();
                } else {
                  _controller.forward();
                }
              },
              child: const Text("Animate"),
            ),
          ],
        ),
      ),
    );
  }
}
