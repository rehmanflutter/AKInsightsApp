import 'package:flutter/material.dart';
import '../models/person.dart';
import '../theme/app_theme.dart';

/// A single row representing a person, used inside [UserListSection].
/// Includes a staggered fade+slide-in animation driven by [index].
class PersonTile extends StatefulWidget {
  final Person person;
  final int index;
  final IconData trailingIcon;
  final Color trailingColor;

  const PersonTile({
    super.key,
    required this.person,
    required this.index,
    this.trailingIcon = Icons.chevron_right_rounded,
    this.trailingColor = AppColors.textFaint,
  });

  @override
  State<PersonTile> createState() => _PersonTileState();
}

class _PersonTileState extends State<PersonTile> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 420));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    Future.delayed(Duration(milliseconds: 35 * widget.index), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.person;
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _hovering ? Colors.white.withOpacity(0.05) : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: p.avatarColor,
                  child: Text(
                    p.initials,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(p.username,
                              style: const TextStyle(
                                  color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 14)),
                          if (p.isVerified) ...[
                            const SizedBox(width: 4),
                            const Icon(Icons.verified_rounded, size: 14, color: AppColors.blue),
                          ]
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(p.meta, style: const TextStyle(color: AppColors.textFaint, fontSize: 12)),
                    ],
                  ),
                ),
                Icon(widget.trailingIcon, color: widget.trailingColor, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
