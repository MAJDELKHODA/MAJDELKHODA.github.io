import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../widgets/common.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);

    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          child: Text(
            '“I turn real-life problems into apps that feel effortless.”',
            style: AppText.display(mobile ? 24 : 30, weight: FontWeight.w400, height: 1.4)
                .copyWith(fontStyle: FontStyle.italic, color: AppColors.goldLight),
          ),
        ),
        const SizedBox(height: 26),
        Reveal(
          delayMs: 120,
          child: Text(PortfolioData.about, style: AppText.body(16, color: AppColors.textMuted, height: 1.9)),
        ),
        const SizedBox(height: 40),
        Reveal(delayMs: 200, child: Text('Training & Courses', style: AppText.display(24))),
        const SizedBox(height: 20),
        ...PortfolioData.training.asMap().entries.map(
              (e) => Reveal(delayMs: 250 + e.key * 90, child: _TimelineItem(text: e.value, last: e.key == PortfolioData.training.length - 1)),
            ),
      ],
    );

    final right = Reveal(
      delayMs: 150,
      child: GlassCard(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _InfoRow(icon: Icons.location_on_outlined, label: 'Based in', text: PortfolioData.location),
            const _InfoRow(icon: Icons.work_outline_rounded, label: 'Role', text: PortfolioData.role),
            ...PortfolioData.education.map((e) => _InfoRow(icon: Icons.school_outlined, label: 'Education', text: e)),
            const _InfoRow(icon: Icons.translate_rounded, label: 'Languages', text: PortfolioData.languages),
            const _InfoRow(icon: Icons.mail_outline_rounded, label: 'Email', text: PortfolioData.email, last: true),
          ],
        ),
      ),
    );

    return SectionContainer(
      alt: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(label: 'About me', title: 'Crafting apps with care\nand clean code'),
          if (mobile) ...[left, const SizedBox(height: 40), right]
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 6, child: left),
                const SizedBox(width: 64),
                Expanded(flex: 5, child: right),
              ],
            ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String text;
  final bool last;
  const _InfoRow({required this.icon, required this.label, required this.text, this.last = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: last ? null : const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
            ),
            child: Icon(icon, size: 18, color: AppColors.gold),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label.toUpperCase(),
                    style: AppText.body(11, color: AppColors.textMuted, letterSpacing: 1.6, weight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(text, style: AppText.body(15, weight: FontWeight.w500, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String text;
  final bool last;
  const _TimelineItem({required this.text, required this.last});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 20,
            child: Column(
              children: [
                const SizedBox(height: 6),
                Container(
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.gold,
                    boxShadow: [BoxShadow(color: AppColors.gold.withValues(alpha: 0.5), blurRadius: 10)],
                  ),
                ),
                if (!last)
                  Expanded(
                    child: Container(width: 1, margin: const EdgeInsets.only(top: 4), color: AppColors.gold.withValues(alpha: 0.3)),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: Text(text, style: AppText.body(15, color: AppColors.text.withValues(alpha: 0.9), height: 1.5)),
            ),
          ),
        ],
      ),
    );
  }
}
