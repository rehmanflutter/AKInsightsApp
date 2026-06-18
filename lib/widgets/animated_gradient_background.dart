import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A slowly shifting glowing gradient background to give the whole
/// app a premium, alive feel without being distracting.
class AnimatedGradientBackground extends StatefulWidget {
  final Widget child;
  const AnimatedGradientBackground({super.key, required this.child});

  @override
  State<AnimatedGradientBackground> createState() => _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        return Stack(
          children: [
            Container(decoration: const BoxDecoration(gradient: AppColors.backgroundGradient)),
            Positioned(
              top: -150 + (60 * t),
              left: -100 + (40 * t),
              child: _glow(AppColors.violet.withOpacity(0.35), 320),
            ),
            Positioned(
              bottom: -180 + (50 * (1 - t)),
              right: -120 + (30 * t),
              child: _glow(AppColors.magenta.withOpacity(0.28), 360),
            ),
            Positioned(
              top: 200 - (40 * t),
              right: -80,
              child: _glow(AppColors.blue.withOpacity(0.18), 260),
            ),
            widget.child,
          ],
        );
      },
    );
  }

  Widget _glow(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withOpacity(0)]),
      ),
    );
  }
}
