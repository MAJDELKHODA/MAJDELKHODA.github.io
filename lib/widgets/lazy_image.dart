import 'package:flutter/material.dart';

/// Loads an asset image only when it gets close to the screen,
/// then fades it in. Until then (or if it fails) it shows [placeholder].
class LazyAssetImage extends StatefulWidget {
  final String path;
  final BoxFit fit;
  final Alignment alignment;
  final Widget placeholder;
  final Widget? errorWidget;

  const LazyAssetImage({
    super.key,
    required this.path,
    required this.placeholder,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.errorWidget,
  });

  @override
  State<LazyAssetImage> createState() => _LazyAssetImageState();
}

class _LazyAssetImageState extends State<LazyAssetImage> {
  bool _load = false;
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
    if (_load || !mounted) return;
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.attached || !box.hasSize) return;
    final top = box.localToGlobal(Offset.zero).dy;
    final screenH = MediaQuery.sizeOf(context).height;
    // Start loading a bit before it becomes visible.
    if (top < screenH * 1.8) {
      _position?.removeListener(_check);
      setState(() => _load = true);
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_check);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        widget.placeholder,
        if (_load)
          Image.asset(
            widget.path,
            fit: widget.fit,
            alignment: widget.alignment,
            frameBuilder: (context, child, frame, wasSyncLoaded) {
              if (wasSyncLoaded) return child;
              return AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                child: child,
              );
            },
            errorBuilder: (_, __, ___) => widget.errorWidget ?? widget.placeholder,
          ),
      ],
    );
  }
}
