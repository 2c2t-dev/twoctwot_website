import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/presentation/widgets/terminal_card.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PageHeader(),
          const SizedBox(height: 48),
          const _AboutContent(),
          const SizedBox(height: 48),
          const _Philosophy(),
          const SizedBox(height: 48),
          const _Timeline(),
        ],
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'À propos de 2c2t.dev',
          style: Theme.of(context).textTheme.headlineLarge,
        ).animate()
          .fadeIn(duration: 600.ms)
          .slideX(begin: -0.3),
        
        const SizedBox(height: 16),
        
        Text(
          'L\'innovation par l\'expérimentation informatique',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppTheme.primaryColor,
          ),
        ).animate()
          .fadeIn(duration: 600.ms, delay: 200.ms)
          .slideX(begin: -0.3),
      ],
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent();

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    return ResponsiveRowColumn(
      layout: isDesktop 
        ? ResponsiveRowColumnType.ROW 
        : ResponsiveRowColumnType.COLUMN,
      rowCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveRowColumnItem(
          rowFlex: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 24),
            child: _buildMainContent(context),
          ),
        ),
        ResponsiveRowColumnItem(
          rowFlex: 1,
          child: _buildSidebar(context),
        ),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return TerminalCard(
      title: 'Notre Mission',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            context,
            'Qu\'est-ce que 2c2t.dev ?',
            '2c2t.dev est né d\'une passion pour l\'expérimentation et l\'innovation dans le domaine informatique. Nous nous concentrons sur le développement de solutions open-source performantes et accessibles à tous.',
          ),
          
          const SizedBox(height: 24),
          
          _buildSection(
            context,
            'Notre Vision',
            'Nous croyons que les meilleures innovations naissent de l\'expérimentation libre et du partage de connaissances. Chaque projet que nous développons vise à résoudre des problèmes concrets tout en repoussant les limites techniques.',
          ),
          
          const SizedBox(height: 24),
          
          _buildSection(
            context,
            'Nos Valeurs',
            '• Open Source First : Tout notre code est libre et accessible\n'
            '• Innovation Continue : Nous expérimentons constamment\n'
            '• Communauté : Nous développons pour et avec la communauté\n'
            '• Excellence Technique : Qualité et performance avant tout\n'
            '• Simplicité : Des solutions élégantes aux problèmes complexes',
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms, delay: 400.ms)
      .slideY(begin: 0.3);
  }

  Widget _buildSidebar(BuildContext context) {
    return Column(
      children: [
        TerminalCard(
          title: 'Technologies',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTechCategory(context, 'Développement', ['Flutter', 'Dart', 'Python']),
              const SizedBox(height: 16),
              _buildTechCategory(context, 'Infrastructure', ['Docker', 'LXC', 'KVM']),
              const SizedBox(height: 16),
              _buildTechCategory(context, 'Système', ['Linux', 'Git']),
            ],
          ),
        ).animate()
          .fadeIn(duration: 600.ms, delay: 600.ms)
          .slideX(begin: 0.3),
        
        const SizedBox(height: 24),
        
        TerminalCard(
          title: 'Statistiques',
          child: Column(
            children: [
              _buildStat(context, 'Projets actifs', '3'),
              const SizedBox(height: 12),
              _buildStat(context, 'Technologies principales', '8'),
              const SizedBox(height: 12),
              _buildStat(context, 'Tasses de café', '∞'),
            ],
          ),
        ).animate()
          .fadeIn(duration: 600.ms, delay: 800.ms)
          .slideX(begin: 0.3),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildTechCategory(BuildContext context, String category, List<String> technologies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: technologies.map((tech) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Text(
              tech,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildStat(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _Philosophy extends StatelessWidget {
  const _Philosophy();

  @override
  Widget build(BuildContext context) {
    return TerminalCard(
      title: 'Philosophie de Développement',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPhilosophyItem(
            context,
            Icons.lightbulb_outline,
            'Expérimentation',
            'Nous testons de nouvelles approches et technologies pour repousser les limites.',
          ),
          const SizedBox(height: 20),
          _buildPhilosophyItem(
            context,
            Icons.people_outline,
            'Collaboration',
            'Le développement en équipe et l\'open source sont au cœur de notre approche.',
          ),
          const SizedBox(height: 20),
          _buildPhilosophyItem(
            context,
            Icons.speed,
            'Performance',
            'Optimisation constante pour des solutions rapides et efficaces.',
          ),
          const SizedBox(height: 20),
          _buildPhilosophyItem(
            context,
            Icons.security,
            'Sécurité',
            'La sécurité et la fiabilité sont intégrées dès la conception.',
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms, delay: 1000.ms)
      .slideY(begin: 0.3);
  }

  Widget _buildPhilosophyItem(BuildContext context, IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline();

  @override
  Widget build(BuildContext context) {
    return TerminalCard(
      title: 'Notre Parcours',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimelineItem(
            context,
            '2024',
            'Création de 2c2t.dev',
            'Lancement officiel de notre organisation avec nos premiers projets open-source.',
            true,
          ),
          _buildTimelineItem(
            context,
            '2024 Q2',
            'Première version du site',
            'Développement et lancement de notre site vitrine en Flutter Web.',
            false,
          ),
          _buildTimelineItem(
            context,
            '2024 Q3-Q4',
            'Expansion des projets',
            'Développement de nouveaux outils et utilitaires pour la communauté.',
            false,
          ),
          _buildTimelineItem(
            context,
            'À venir...',
            'Nouvelles innovations',
            'Nous préparons de nouveaux projets passionnants pour l\'année prochaine !',
            false,
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms, delay: 1200.ms)
      .slideY(begin: 0.3);
  }

  Widget _buildTimelineItem(BuildContext context, String date, String title, String description, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isActive ? AppTheme.primaryColor : AppTheme.borderColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
