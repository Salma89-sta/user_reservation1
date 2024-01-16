import 'package:flutter/material.dart';

class FlutterToast extends StatefulWidget {
  final String message;
  final IconData iconData;
  final Color backgroundColor;
  final Color textColor;
  final Duration duration;

  const FlutterToast({
    Key? key,
    required this.message,
    this.iconData = Icons.info_outline,
    this.backgroundColor = Colors.deepOrange,
    this.textColor = Colors.white,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  @override
  _FlutterToastState createState() => _FlutterToastState();
}

class _FlutterToastState extends State<FlutterToast> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: ToastWidget(
            message: widget.message,
            iconData: widget.iconData,
            backgroundColor: widget.backgroundColor,
            textColor: widget.textColor,
          ),
        );
      },
    );
  }
}

class ToastWidget extends StatelessWidget {
  final String message;
  final IconData iconData;
  final Color backgroundColor;
  final Color textColor;

  const ToastWidget({
    Key? key,
    required this.message,
    required this.iconData,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(iconData, color: textColor),
              SizedBox(width: 8),
              Text(
                message,
                style: TextStyle(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}