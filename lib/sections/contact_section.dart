import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../utils/links.dart';
import '../widgets/common.dart';
import '../widgets/nav_bar.dart';
import '../widgets/whatsapp_icon.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    return SectionContainer(
      child: Reveal(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(1.2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            gradient: LinearGradient(
              colors: [AppColors.gold, AppColors.gold.withValues(alpha: 0.05), AppColors.gold.withValues(alpha: 0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: mobile ? 26 : 70, vertical: mobile ? 50 : 80),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              gradient: const RadialGradient(
                center: Alignment(0, -1.2),
                radius: 1.4,
                colors: [Color(0xFFFBE6E6), AppColors.surface],
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 30, height: 1.5, color: AppColors.gold),
                    const SizedBox(width: 12),
                    Text('LET\'S TALK', style: AppText.body(12.5, color: AppColors.gold, weight: FontWeight.w600, letterSpacing: 3)),
                    const SizedBox(width: 12),
                    Container(width: 30, height: 1.5, color: AppColors.gold),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Have an idea? Let\'s build\nsomething remarkable together.',
                  textAlign: TextAlign.center,
                  style: AppText.display(mobile ? 30 : 48, height: 1.2),
                ),
                const SizedBox(height: 18),
                Text(
                  'I\'m available for freelance projects and full-time opportunities.',
                  textAlign: TextAlign.center,
                  style: AppText.body(16, color: AppColors.textMuted),
                ),
                const SizedBox(height: 38),
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  alignment: WrapAlignment.center,
                  children: [
                    LuxButton(
                      text: 'Chat on WhatsApp',
                      icon: Icons.chat_rounded,
                      iconBuilder: (c, size) => WhatsAppIcon(size: size, color: c),
                      onTap: () => openLink(PortfolioData.whatsapp),
                    ),
                    LuxButton(
                      text: 'Email Me',
                      icon: Icons.mail_outline_rounded,
                      outlined: true,
                      onTap: () => openLink('mailto:${PortfolioData.email}'),
                    ),
                    LuxButton(
                      text: 'LinkedIn',
                      icon: Icons.arrow_outward_rounded,
                      outlined: true,
                      onTap: () => openLink(PortfolioData.linkedin),
                    ),
                    LuxButton(
                      text: 'GitHub',
                      icon: Icons.arrow_outward_rounded,
                      outlined: true,
                      onTap: () => openLink(PortfolioData.github),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                SelectableText(PortfolioData.email, style: AppText.body(14, color: AppColors.goldLight)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final year = DateTime.now().year;
    final children = [
      const Logo(),
      Text('© $year ${PortfolioData.fullName} · Crafted with Flutter',
          textAlign: TextAlign.center, style: AppText.body(13, color: AppColors.textMuted)),
    ];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: mobile ? 22 : 48, vertical: 30),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.border))),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1140),
          child: mobile
              ? Column(children: [children[0], const SizedBox(height: 14), children[1]])
              : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: children),
        ),
      ),
    );
  }
}
