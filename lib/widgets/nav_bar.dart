import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'common.dart';

class NavItem {
  final String label;
  final GlobalKey key;
  const NavItem(this.label, this.key);
}

/// Frosted-glass navigation bar that floats above the content.
class NavBar extends StatelessWidget {
  final List<NavItem> items;
  final void Function(GlobalKey key) onTap;
  final VoidCallback onHire;
  const NavBar({super.key, required this.items, required this.onTap, required this.onHire});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 76,
          padding: EdgeInsets.symmetric(horizontal: mobile ? 20 : 48),
          decoration: BoxDecoration(
            color: AppColors.background.withValues(alpha: 0.8),
            border: const Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1140),
              child: Row(
                children: [
                  const Logo(),
                  const Spacer(),
                  if (mobile)
                    Builder(
                      builder: (ctx) => IconButton(
                        icon: const Icon(Icons.menu_rounded, color: AppColors.gold),
                        onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                      ),
                    )
                  else ...[
                    ...items.map((i) => _NavLink(label: i.label, onTap: () => onTap(i.key))),
                    const SizedBox(width: 18),
                    LuxButton(text: 'Hire Me', icon: Icons.arrow_outward_rounded, onTap: onHire, small: true),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.gold, width: 1.2),
          ),
          child: Text('M', style: AppText.display(20, color: AppColors.gold, weight: FontWeight.w700, height: 1)),
        ),
        const SizedBox(width: 12),
        Text('Majd', style: AppText.display(22, weight: FontWeight.w600, height: 1)),
        Text('.', style: AppText.display(26, color: AppColors.gold, weight: FontWeight.w700, height: 1)),
      ],
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: AppText.body(14.5,
                    color: _hover ? AppColors.gold : AppColors.textMuted, weight: FontWeight.w500, height: 1.2),
                child: Text(widget.label),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                height: 1.5,
                width: _hover ? 22 : 0,
                color: AppColors.gold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  final List<NavItem> items;
  final void Function(GlobalKey key) onTap;
  const NavDrawer({super.key, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundAlt,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Align(alignment: Alignment.centerLeft, child: Logo()),
            const SizedBox(height: 32),
            ...items.map(
              (i) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(i.label, style: AppText.display(22)),
                trailing: const Icon(Icons.arrow_forward_rounded, color: AppColors.gold, size: 18),
                onTap: () {
                  Navigator.of(context).pop();
                  onTap(i.key);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
