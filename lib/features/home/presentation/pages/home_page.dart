import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/presentation/widgets/terminal_card.dart';
import '../../../../shared/presentation/widgets/interactive_dot_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          const InteractiveDotBackground(),
          Column(
            children: [
              const _HeroSection(),
              const SizedBox(height: 80),
              const _ProjectsPreview(),
              const SizedBox(height: 80),
              const _TechStack(),
              const SizedBox(height: 80),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
            // Logo
            SizedBox(
              width: isDesktop ? 120 : 80,
              height: isDesktop ? 120 : 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/logo_2c2t.png',
                  fit: BoxFit.contain,
                ),
              ),
            ).animate()
              .scale(duration: 800.ms, delay: 100.ms)
              .fadeIn(duration: 600.ms),

            const SizedBox(height: 32),
            
            // Titre principal
            Text(
              '2c2t.dev',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: isDesktop ? 56 : 40,
                height: 1.1,
              ),
            ).animate()
              .fadeIn(duration: 800.ms, delay: 300.ms)
              .slideY(begin: 0.3),

            const SizedBox(height: 12),
            
            // Proposition de valeur claire
            Text(
              "L'innovation par l'expérimentation informatique",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: isDesktop ? 24 : 18,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ).animate()
              .fadeIn(duration: 600.ms, delay: 500.ms)
              .slideY(begin: 0.2),

            const SizedBox(height: 8),
            
            // Sous-titre avec effet de typing
            SizedBox(
              height: isDesktop ? 50 : 45,
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: isDesktop ? 16 : 14,
                  height: 1.3,
                ) ?? const TextStyle(),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Téléchargez vos ISOs 10x plus vite avec GetISO',
                      speed: const Duration(milliseconds: 80),
                    ),
                    TypewriterAnimatedText(
                      'Déployez via PXE en 30 secondes avec NetISO',
                      speed: const Duration(milliseconds: 80),
                    ),
                    TypewriterAnimatedText(
                      'Flashez vos USB en 1 clic avec BootISO',
                      speed: const Duration(milliseconds: 80),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 48),
            
            // Boutons d'action plus engageants
            ResponsiveRowColumn(
              layout: isDesktop 
                ? ResponsiveRowColumnType.ROW 
                : ResponsiveRowColumnType.COLUMN,
              rowMainAxisAlignment: MainAxisAlignment.center,
              columnMainAxisAlignment: MainAxisAlignment.center,
              children: [
                ResponsiveRowColumnItem(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (context.mounted) {
                          context.go('/projects');
                        }
                      },
                      icon: const Icon(Icons.rocket_launch),
                      label: const Text('Essayer nos outils'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                ResponsiveRowColumnItem(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: OutlinedButton.icon(
                      onPressed: () {
                        if (context.mounted) {
                          context.go('/about');
                        }
                      },
                      icon: const Icon(Icons.trending_up),
                      label: const Text('Voir les performances'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.primaryColor,
                        side: BorderSide(color: AppTheme.primaryColor, width: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ).animate()
              .fadeIn(duration: 600.ms, delay: 1000.ms)
              .slideY(begin: 0.3),
          ],
          ),
        ),
      ),
    );
  }
}

class _ProjectsPreview extends StatelessWidget {
  const _ProjectsPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            'Nos Projets Phares',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ).animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3),
          
          const SizedBox(height: 16),
          
          Text(
            'Des solutions innovantes développées avec passion',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ).animate()
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .slideY(begin: 0.3),
          
          const SizedBox(height: 48),
          
          Center(
            child: Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: _ProjectCard(
                    title: 'GetISO',
                    description: 'Site de téléchargement d\'images ISO à très haute vitesse',
                    icon: Icons.download,
                    technologies: ['Web', '50Gbps', 'Direct'],
                  ).animate()
                    .fadeIn(duration: 600.ms, delay: 400.ms)
                    .slideX(begin: -0.3),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: _ProjectCard(
                    title: 'NetISO',
                    description: 'Service PXE moderne pour installation d\'OS via réseau',
                    icon: Icons.network_check,
                    technologies: ['PXE', 'Boot', 'Network'],
                  ).animate()
                    .fadeIn(duration: 600.ms, delay: 600.ms)
                    .slideY(begin: 0.3),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: _ProjectCard(
                    title: 'BootISO',
                    description: 'Logiciel multiplateforme de téléchargement et flash USB',
                    icon: Icons.usb,
                    technologies: ['Flutter', 'USB', 'Cross-OS'],
                  ).animate()
                    .fadeIn(duration: 600.ms, delay: 800.ms)
                    .slideX(begin: 0.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final List<String> technologies;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.technologies,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: TerminalCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppTheme.primaryColor, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 4,
              runSpacing: 0,
              children: technologies.map((tech) => Chip(
                label: Text(
                  tech,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
                backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.15),
                side: BorderSide(color: AppTheme.primaryColor.withValues(alpha: 0.4), width: 1.2),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechStack extends StatelessWidget {
  const _TechStack();

  @override
  Widget build(BuildContext context) {
    final technologies = [
      'Flutter', 'Dart', 'Python', 'Docker',
      'LXC', 'KVM', 'Linux', 'Git'
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            'Technologies Utilisées',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ).animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3),
          
          const SizedBox(height: 32),
          
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: technologies.asMap().entries.map((entry) {
              final index = entry.key;
              final tech = entry.value;
              
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.cardColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                child: Text(
                  tech,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ).animate(delay: (index * 100).ms)
                .fadeIn(duration: 400.ms)
                .scale(begin: const Offset(0.8, 0.8));
            }).toList(),
          ),
        ],
      ),
    );
  }
}