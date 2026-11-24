import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Endless, slow-scrolling strip of tech keywords.
class MarqueeStrip extends StatefulWidget {
  const MarqueeStrip({super.key});

  @override
  State<MarqueeStrip> createState() => _MarqueeStripState();
}

class _MarqueeStripState extends State<MarqueeStrip> with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(seconds: 40))..repeat();

  static const _words = [
    'Flutter',
    'Dart',
    'GetX',
    'REST APIs',
    'Firebase',
    'Clean Architecture',
    'Responsive UI',
    'AI Features',
  ];

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];
    for (var copy = 0; copy < 3; copy++) {
      for (final w in _words) {
        items.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Text(w, style: AppText.display(26, color: AppColors.text.withValues(alpha: 0.85), weight: FontWeight.w500)),
        ));
        items.add(const Icon(Icons.auto_awesome, size: 16, color: AppColors.gold));
      }
    }
    return Container(
      width: double.infinity,
      height: 86,
      decoration: const BoxDecoration(
        color: AppColors.backgroundAlt,
        border: Border(top: BorderSide(color: AppColors.border), bottom: BorderSide(color: AppColors.border)),
      ),
      child: ClipRect(
        child: OverflowBox(
          maxWidth: double.infinity,
          alignment: Alignment.centerLeft,
          child: AnimatedBuilder(
            animation: _c,
            builder: (_, child) => FractionalTranslation(translation: Offset(-_c.value / 3, 0), child: child),
            child: Row(mainAxisSize: MainAxisSize.min, children: items),
          ),
        ),
      ),
    );
  }
}
