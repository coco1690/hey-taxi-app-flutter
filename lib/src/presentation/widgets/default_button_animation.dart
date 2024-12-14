import 'package:flutter/material.dart';

class ScalingButton extends StatefulWidget {
  final String imagePath;
  final String text;
  final VoidCallback? onPressed;
  final Duration duration;
  final double minScale;
  final double maxScale;

  const ScalingButton({
    super.key,
    required this.imagePath,
    required this.text,
    this.onPressed,
    this.duration = const Duration(seconds: 2),
    this.minScale = 0.8,
    this.maxScale = 1.2,
  });

  @override
  _ScalingButtonState createState() => _ScalingButtonState();
}

class _ScalingButtonState extends State<ScalingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,

      child: Row(
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              widget.imagePath,
              width: 20,
              height: 20,
             
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              widget.text, 
              style: const TextStyle(color: Color.fromARGB(255, 254, 214, 78), fontSize: 18, fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }
}
