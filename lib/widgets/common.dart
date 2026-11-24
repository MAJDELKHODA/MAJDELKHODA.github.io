import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

bool isMobile(BuildContext context) => MediaQuery.sizeOf(context).width < 820;

/// Centers content with a max width and generous, consistent padding.
class SectionContainer extends StatelessWidget {
  final Widget child;
  final bool alt;
  const SectionContainer({super.key, required this.child, this.alt = false});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    return Container(
      width: double.infinity,
      color: alt ? AppColors.backgroundAlt : null,
      padding: EdgeInsets.symmetric(horizontal: mobile ? 22 : 48, vertical: mobile ? 72 : 110),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1140),
          child: child,
        ),
      ),
    );
  }
}

/// Gold eyebrow + elegant serif title.
class SectionTitle extends StatelessWidget {
  final String label;
  final String title;
  final bool center;
  const SectionTitle({super.key, required this.label, required this.title, this.center = false});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    return Reveal(
      child: Column(
        crossAxisAlignment: center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 36, height: 1.5, color: AppColors.gold),
              const SizedBox(width: 12),
              Text(label.toUpperCase(),
                  style: AppText.body(12.5, color: AppColors.gold, weight: FontWeight.w600, letterSpacing: 3)),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            textAlign: center ? TextAlign.center : TextAlign.start,
            style: AppText.display(mobile ? 32 : 46),
          ),
          SizedBox(height: mobile ? 40 : 56),
        ],
      ),
    );
  }
}

/// Fades + slides its child in the first time it scrolls into view.
class Reveal extends StatefulWidget {
  final Widget child;
  final int delayMs;
  final Offset offset;
  const Reveal({super.key, required this.child, this.delayMs = 0, this.offset = const Offset(0, 0.12)});

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> {
  bool _visible = false;
  bool _triggered = false;
  ScrollPosition? _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _position?.removeListener(_check);
    _position = Scrollable.maybeOf(context)?.position;
    _position?.addListener(_check);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (_triggered || !mounted) return;
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.attached || !box.hasSize) return;
    final top = box.localToGlobal(Offset.zero).dy;
    final screenH = MediaQuery.sizeOf(context).height;
    if (top < screenH * 0.92) {
      _triggered = true;
      _position?.removeListener(_check);
      Future.delayed(Duration(milliseconds: widget.delayMs), () {
        if (mounted) setState(() => _visible = true);
      });
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_check);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : widget.offset,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}

/// Gold-outlined chip.
class Tag extends StatelessWidget {
  final String text;
  const Tag(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.28)),
      ),
      child: Text(text, style: AppText.body(12, color: AppColors.goldLight, weight: FontWeight.w500, height: 1.2)),
    );
  }
}

/// Primary gold button with hover lift + glow. Set [outlined] for the secondary style.
class LuxButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final bool outlined;
  final bool small;
  /// Optional custom icon (e.g. a drawn logo) instead of [icon].
  final Widget Function(Color color, double size)? iconBuilder;
  const LuxButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.outlined = false,
    this.small = false,
    this.iconBuilder,
  });

  @override
  State<LuxButton> createState() => _LuxButtonState();
}

class _LuxButtonState extends State<LuxButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final fg = widget.outlined ? (_hover ? AppColors.background : AppColors.gold) : AppColors.background;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hover ? -3 : 0, 0),
          padding: EdgeInsets.symmetric(horizontal: widget.small ? 20 : 28, vertical: widget.small ? 12 : 18),
          decoration: BoxDecoration(
            gradient: (!widget.outlined || _hover) ? AppColors.goldGradient : null,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: AppColors.gold, width: 1.2),
            boxShadow: [
              if (!widget.outlined || _hover)
                BoxShadow(
                  color: AppColors.gold.withValues(alpha: _hover ? 0.45 : 0.25),
                  blurRadius: _hover ? 30 : 18,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.text,
                  style: AppText.body(widget.small ? 13.5 : 15, color: fg, weight: FontWeight.w600, height: 1.2)),
              const SizedBox(width: 10),
              widget.iconBuilder != null
                  ? widget.iconBuilder!(fg, widget.small ? 17 : 20)
                  : Icon(widget.icon, size: widget.small ? 16 : 18, color: fg),
            ],
          ),
        ),
      ),
    );
  }
}

/// Subtle glass card with hover glow.
class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;
  const GlassCard({super.key, required this.child, this.padding = const EdgeInsets.all(28)});

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hover ? -6 : 0, 0),
        padding: widget.padding,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.surfaceLight.withValues(alpha: 0.9), AppColors.surface.withValues(alpha: 0.6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: _hover ? AppColors.gold.withValues(alpha: 0.5) : AppColors.border),
          boxShadow: [
            BoxShadow(
              color: _hover ? AppColors.gold.withValues(alpha: 0.12) : AppColors.shadow,
              blurRadius: _hover ? 40 : 20,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
