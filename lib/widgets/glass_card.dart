import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A frosted "glass" card with a subtle hover lift + glow effect.
/// Works on both web (mouse hover) and touch (tap scale) devices.
class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Gradient? borderGlow;
  final VoidCallback? onTap;
  final BorderRadius? radius;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.borderGlow,
    this.onTap,
    this.radius,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.radius ?? BorderRadius.circular(20);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovering ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: widget.borderGlow,
              boxShadow: _hovering
                  ? [
                      BoxShadow(
                        color: (widget.borderGlow != null
                                ? AppColors.purple
                                : AppColors.violet)
                            .withOpacity(0.35),
                        blurRadius: 28,
                        spreadRadius: -4,
                        offset: const Offset(0, 10),
                      )
                    ]
                  : [],
            ),
            padding: const EdgeInsets.all(1.4),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  padding: widget.padding,
                  decoration: BoxDecoration(
                    color: AppColors.surface.withOpacity(0.6),
                    borderRadius: borderRadius,
                    border: Border.all(color: Colors.white.withOpacity(0.06)),
                  ),
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
