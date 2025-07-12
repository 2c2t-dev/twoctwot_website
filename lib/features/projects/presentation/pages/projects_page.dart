import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/presentation/widgets/terminal_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _PageHeader(),
              const SizedBox(height: 64),
              const _ProjectsList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre principal avec style moderne
        Row(
          children: [
            Container(
              width: 4,
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nos Projets',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isDesktop ? 42 : 32,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Outils système et infrastructure réseau',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.textSecondary,
                      fontSize: isDesktop ? 18 : 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).animate()
          .fadeIn(duration: 800.ms)
          .slideX(begin: -0.5),
        
        const SizedBox(height: 32),
        
        // Statistiques des projets
        if (isDesktop) ...[
          Row(
            children: [
              _buildStatCard(context, '3', 'Projets actifs', Icons.rocket_launch),
              const SizedBox(width: 24),
              _buildStatCard(context, 'Open Source', 'Philosophie', Icons.code),
              const SizedBox(width: 24),
              _buildStatCard(context, 'Multi-OS', 'Support', Icons.devices),
            ],
          ).animate()
            .fadeIn(duration: 600.ms, delay: 400.ms)
            .slideY(begin: 0.3),
          
          const SizedBox(height: 32),
        ],
        
        // Note informative épurée
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryColor.withValues(alpha: 0.1),
                AppTheme.primaryColor.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.primaryColor.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.open_in_new,
                color: AppTheme.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Tous nos projets sont open-source et disponibles sur GitHub',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ).animate()
          .fadeIn(duration: 600.ms, delay: 600.ms)
          .slideY(begin: 0.3),
      ],
    );
  }
  
  Widget _buildStatCard(BuildContext context, String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.borderColor,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 28,
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectsList extends StatelessWidget {
  const _ProjectsList();

  @override
  Widget build(BuildContext context) {
    final projects = [
      ProjectData(
        title: 'GetISO',
        description: 'Un site de téléchargement d\'images ISO à très haute vitesse, sans publicité ni restriction. Optimisé avec CDN global et serveurs haute performance.',
        longDescription: 'GetISO révolutionne le téléchargement d\'images ISO en offrant :\n\n'
            '• Téléchargements ultra-rapides via CDN optimisé\n'
            '• Interface minimaliste et intuitive\n'
            '• Aucune publicité, aucune limitation\n'
            '• Vérification automatique d\'intégrité\n'
            '• Support de tous les OS populaires\n'
            '• Miroirs multiples pour garantir la disponibilité',
        icon: Icons.download,
        color: AppTheme.primaryColor,
        technologies: ['Web', '50Gbps', 'Direct Link'],
        status: 'En développement',
        githubUrl: 'https://github.com/2c2t-dev/getiso',
        demoUrl: null,
        features: [
          'Téléchargement haute vitesse',
          'Interface sans publicité',
          'Vérification d\'intégrité',
          'Miroirs multiples',
        ],
      ),
      ProjectData(
        title: 'NetISO',
        description: 'Solution PXE moderne pour déployer, tester, maintenir & réparer des systèmes d\'exploitation via le réseau grâce à une clé de démarrage PXE de 8 Mo. Interface simplifiée pour administrateurs système.',
        longDescription: 'NetISO modernise le déploiement réseau d\'OS :\n\n'
            '• Boot réseau universel (BIOS/UEFI)\n'
            '• Boot d\'OS en LiveCD pour test sans installation\n'
            '• Création de clés de démarrage PXE (4-8 Mo)\n'
            '• Déploiement en masse pour laboratoires/entreprises\n'
            '• Outils de maintenance et diagnostic intégrés\n'
            '• Configuration réseau automatisée (DHCP/Static)',
        icon: Icons.network_check,
        color: AppTheme.secondaryColor,
        technologies: ['Jinja', 'PXE', 'Boot'],
        status: 'À venir',
        githubUrl: '',
        demoUrl: null,
        features: [
          'Boot réseau universel',
          'Boot d\'OS en LiveCD',
          'Clés de démarrage PXE',
          'Outils de diagnostic',
        ],
      ),
      ProjectData(
        title: 'BootISO',
        description: 'Logiciel multiplateforme de téléchargement automatique depuis GetISO et installation sur clé USB bootable. Simple, rapide et efficace.',
        longDescription: 'BootISO automatise l\'installation sur clé USB :\n\n'
            '• Intégration directe avec GetISO\n'
            '• Détection automatique des périphériques USB\n'
            '• Installation sécurisée avec vérification\n'
            '• Interface utilisateur moderne et intuitive\n'
            '• Support Windows, macOS et Linux\n'
            '• Mode batch pour installations multiples',
        icon: Icons.usb,
        color: Colors.orange,
        technologies: ['Flutter', 'Cross-Plateforme'],
        status: 'À venir',
        githubUrl: '',
        demoUrl: null,
        features: [
          'Téléchargement intégré',
          'Installation automatique USB',
          'Interface moderne',
          'Support multiplateforme',
        ],
      ),
    ];

    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    if (isDesktop) {
      // Layout en grille pour desktop
      return Column(
        children: projects.asMap().entries.map((entry) {
          final index = entry.key;
          final project = entry.value;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: _ProjectCard(
              project: project,
              isLarge: true,
            ).animate(delay: (index * 150).ms)
              .fadeIn(duration: 700.ms)
              .slideY(begin: 0.4),
          );
        }).toList(),
      );
    } else {
      // Layout compact pour mobile/tablet
      return Column(
        children: projects.asMap().entries.map((entry) {
          final index = entry.key;
          final project = entry.value;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 24),
            child: _ProjectCard(
              project: project,
              isLarge: false,
            ).animate(delay: (index * 150).ms)
              .fadeIn(duration: 700.ms)
              .slideY(begin: 0.3),
          );
        }).toList(),
      );
    }
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectData project;
  final bool isLarge;

  const _ProjectCard({
    required this.project,
    required this.isLarge,
  });

  @override
  Widget build(BuildContext context) {
    return TerminalCard(
      title: project.title,
      child: isLarge ? _buildLargeLayout(context) : _buildCompactLayout(context),
    );
  }

  Widget _buildLargeLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildProjectInfo(context),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: _buildProjectDetails(context),
        ),
      ],
    );
  }

  Widget _buildCompactLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProjectInfo(context),
        const SizedBox(height: 24),
        _buildProjectDetails(context),
      ],
    );
  }

  Widget _buildProjectInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: project.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: project.color.withValues(alpha: 0.3)),
              ),
              child: Icon(
                project.icon,
                color: project.color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: project.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      project.status,
                      style: TextStyle(
                        fontFamily: 'MuseoModerno',
                        fontSize: 12,
                        color: project.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        Text(
          project.description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        
        const SizedBox(height: 16),
        
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.technologies.map((tech) => Chip(
            label: Text(
              tech,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
              ),
            ),
            backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
            side: BorderSide(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
          )).toList(),
        ),
        
        const SizedBox(height: 24),
        
        Row(
          children: [
            if (project.githubUrl.isNotEmpty) ...[
              OutlinedButton.icon(
                onPressed: () => _launchUrl(project.githubUrl),
                icon: const Icon(Icons.code),
                label: const Text('GitHub'),
              ),
            ],
            if (project.demoUrl != null) ...[
              if (project.githubUrl.isNotEmpty) const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _launchUrl(project.demoUrl!),
                icon: const Icon(Icons.launch),
                label: const Text('Demo'),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildProjectDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fonctionnalités',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...project.features.map((feature) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: AppTheme.primaryColor,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  feature,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class ProjectData {
  final String title;
  final String description;
  final String longDescription;
  final IconData icon;
  final Color color;
  final List<String> technologies;
  final String status;
  final String githubUrl;
  final String? demoUrl;
  final List<String> features;

  const ProjectData({
    required this.title,
    required this.description,
    required this.longDescription,
    required this.icon,
    required this.color,
    required this.technologies,
    required this.status,
    required this.githubUrl,
    this.demoUrl,
    required this.features,
  });
}
