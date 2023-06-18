import 'package:flutter/material.dart';

class RoundLoadingButton extends StatefulWidget {
  final VoidCallback onPressed;

  const RoundLoadingButton({super.key, required this.onPressed});

  @override
  _RoundLoadingButtonState createState() => _RoundLoadingButtonState();
}

class _RoundLoadingButtonState extends State<RoundLoadingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startLoading() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_isLoading) {
          _startLoading();
          widget.onPressed();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: _isLoading ? double.infinity : 100.0,
        height: _isLoading ? double.infinity : 50.0,
        decoration: BoxDecoration(
          color: _isLoading ? Colors.green : Colors.blue,
          shape: _isLoading ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: _isLoading
            ? const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
            : ScaleTransition(
          scale: _scaleAnimation,
          child: const Center(
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
