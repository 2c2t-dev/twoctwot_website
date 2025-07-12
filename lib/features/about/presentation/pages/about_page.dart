import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/presentation/widgets/terminal_card.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PageHeader(),
          SizedBox(height: isMobile ? 32 : 48),
          const _AboutContent(),
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
    final isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);
    
    if (isMobile) {
      return Column(
        children: [
          _buildUnifiedContent(context),
        ],
      );
    }
    
    // Pour desktop, on utilise aussi le contenu unifié mais dans une layout différente
    return ResponsiveRowColumn(
      layout: isDesktop 
        ? ResponsiveRowColumnType.ROW 
        : ResponsiveRowColumnType.COLUMN,
      rowCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveRowColumnItem(
          rowFlex: 1,
          child: _buildUnifiedContent(context),
        ),
      ],
    );
  }

  Widget _buildUnifiedContent(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    if (isDesktop) {
      // Layout en grille pour desktop
      return ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        children: [
          ResponsiveRowColumnItem(
            child: _buildMissionCard(context),
          ),
          ResponsiveRowColumnItem(
            child: SizedBox(height: isMobile ? 16 : 24),
          ),
          ResponsiveRowColumnItem(
            child: ResponsiveRowColumn(
              layout: ResponsiveRowColumnType.ROW,
              children: [
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _buildTechnologiesCard(context),
                  ),
                ),
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: _buildPhilosophyCard(context),
                  ),
                ),
              ],
            ),
          ),
          ResponsiveRowColumnItem(
            child: SizedBox(height: isMobile ? 16 : 24),
          ),
          ResponsiveRowColumnItem(
            child: _buildStatsCard(context),
          ),
        ],
      );
    } else {
      // Layout empilé pour mobile/tablet
      return Column(
        children: [
          _buildMissionCard(context),
          SizedBox(height: isMobile ? 16 : 24),
          _buildTechnologiesCard(context),
          SizedBox(height: isMobile ? 16 : 24),
          _buildStatsCard(context),
          SizedBox(height: isMobile ? 16 : 24),
          _buildPhilosophyCard(context),
        ],
      );
    }
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) ...[
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
        ],
        if (content.isNotEmpty)
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
      ],
    );
  }

  Widget _buildTechCategory(BuildContext context, String category, List<String> technologies) {
    final isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppTheme.primaryColor,
            fontSize: isMobile ? 14 : null,
          ),
        ),
        SizedBox(height: isMobile ? 6 : 8),
        Wrap(
          spacing: isMobile ? 4 : 6,
          runSpacing: isMobile ? 4 : 6,
          children: technologies.map((tech) => Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 6 : 8, 
              vertical: isMobile ? 3 : 4
            ),
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Text(
              tech,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: isMobile ? 11 : null,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value) {
    final isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);
    
    return Container(
      padding: EdgeInsets.all(isMobile ? 8 : 12),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.primaryColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 16 : 20,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 2 : 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
              fontSize: isMobile ? 9 : 11,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPhilosophyItem(BuildContext context, IconData? icon, String title, String description, {bool useLogo = false}) {
    final isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(isMobile ? 8 : 10),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: useLogo 
            ? ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  'assets/images/logo_2c2t.png',
                  width: isMobile ? 16 : 20,
                  height: isMobile ? 16 : 20,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.code,
                      color: AppTheme.primaryColor,
                      size: isMobile ? 16 : 20,
                    );
                  },
                ),
              )
            : Icon(
                icon!,
                color: AppTheme.primaryColor,
                size: isMobile ? 16 : 20,
              ),
        ),
        SizedBox(width: isMobile ? 10 : 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppTheme.primaryColor,
                  fontSize: isMobile ? 13 : 14,
                ),
              ),
              SizedBox(height: isMobile ? 2 : 3),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: isMobile ? 12 : 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMissionCard(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);
    
    return TerminalCard(
      title: 'Notre Mission',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            context,
            'Qu\'est-ce que 2c2t.dev ?',
            '2c2.dev est né d\'une passion pour l\'expérimentation et l\'innovation dans le domaine informatique. Nous nous concentrons sur le développement de solutions open-source performantes et accessibles à tous.',
          ),
          
          SizedBox(height: isMobile ? 16 : 20),
          
          _buildSection(
            context,
            'Notre Vision',
            'Nous croyons que les meilleures innovations naissent de l\'expérimentation libre et du partage de connaissances. Chaque projet que nous développons vise à résoudre des problèmes concrets tout en repoussant les limites techniques.',
          ),
          
          SizedBox(height: isMobile ? 16 : 20),
          
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
      .fadeIn(duration: 600.ms, delay: 200.ms)
      .slideY(begin: 0.3);
  }

  Widget _buildTechnologiesCard(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);
    
    return TerminalCard(
      title: 'Technologies',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTechCategory(context, 'Développement', ['Flutter', 'Dart', 'Python']),
          SizedBox(height: isMobile ? 12 : 16),
          _buildTechCategory(context, 'Infrastructure', ['Docker', 'LXC', 'KVM']),
          SizedBox(height: isMobile ? 12 : 16),
          _buildTechCategory(context, 'Système', ['Linux', 'Git']),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms, delay: 400.ms)
      .slideX(begin: -0.3);
  }

  Widget _buildStatsCard(BuildContext context) {
    return TerminalCard(
      title: 'En Chiffres',
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(context, 'Projets', '3'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(context, 'Membres', '4'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(context, 'Café', '∞'),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms, delay: 600.ms)
      .slideY(begin: 0.3);
  }

  Widget _buildPhilosophyCard(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);
    
    return TerminalCard(
      title: 'Philosophie',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPhilosophyItem(
            context,
            null,
            'Expérimentation',
            'Nous testons de nouvelles approches et technologies pour repousser les limites.',
            useLogo: true,
          ),
          SizedBox(height: isMobile ? 12 : 16),
          _buildPhilosophyItem(
            context,
            Icons.people_outline,
            'Collaboration',
            'Le développement en équipe et l\'open source sont au cœur de notre approche.',
          ),
          SizedBox(height: isMobile ? 12 : 16),
          _buildPhilosophyItem(
            context,
            Icons.speed,
            'Performance',
            'Optimisation constante pour des solutions rapides et efficaces.',
          ),
          SizedBox(height: isMobile ? 12 : 16),
          _buildPhilosophyItem(
            context,
            Icons.security,
            'Sécurité',
            'La sécurité et la fiabilité sont intégrées dès la conception.',
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms, delay: 800.ms)
      .slideX(begin: 0.3);
  }
}
