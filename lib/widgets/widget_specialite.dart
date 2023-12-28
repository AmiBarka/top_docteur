import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  final String categoryName;
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const CategoryWidget({
    Key? key,
    required this.categoryName,
    required this.color,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: widget.color,
        elevation: 4.0,
        child: InkWell(
          onTap: () {
            _animationController.forward(from: 0.0);
            widget.onPressed();
          },
          onTapCancel: () {
            _animationController.reverse();
          },
          onTapUp: (_) {
            _animationController.reverse();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 48.0,
                color: Colors.white,
              ),
              SizedBox(height: 8.0),
              Text(
                widget.categoryName,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
