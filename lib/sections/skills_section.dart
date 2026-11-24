import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../widgets/common.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(label: 'Expertise', title: 'What I work with'),
          LayoutBuilder(
            builder: (context, c) {
              final cols = c.maxWidth > 980 ? 4 : (c.maxWidth > 580 ? 2 : 1);
              const gap = 22.0;
              final w = (c.maxWidth - gap * (cols - 1)) / cols;
              final groups = PortfolioData.skills;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (var i = 0; i < groups.length; i++)
                    SizedBox(width: w, child: Reveal(delayMs: i * 120, child: _SkillCard(group: groups[i], index: i))),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final SkillGroup group;
  final int index;
  const _SkillCard({required this.group, required this.index});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppColors.goldGradient),
                child: Icon(group.icon, color: AppColors.background, size: 24),
              ),
              const Spacer(),
              Text('0${index + 1}', style: AppText.display(28, color: AppColors.gold.withValues(alpha: 0.35))),
            ],
          ),
          const SizedBox(height: 22),
          Text(group.title, style: AppText.display(22)),
          const SizedBox(height: 16),
          Wrap(spacing: 8, runSpacing: 8, children: group.skills.map((s) => Tag(s)).toList()),
        ],
      ),
    );
  }
}
