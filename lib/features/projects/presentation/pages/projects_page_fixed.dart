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
                    style: Theme.of(context).textTheme.headlineLarge,
                  ).animate()
                    .fadeIn(duration: 600.ms)
                    .slideX(begin: -0.3),
                  const SizedBox(height: 8),
                  Text(
                    'Innovation et développement open source',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.primaryColor,
                    ),
                  ).animate()
                    .fadeIn(duration: 600.ms, delay: 200.ms)
                    .slideX(begin: -0.3),
                ],
              ),
            ),
          ],
        ).animate()
          .fadeIn(duration: 600.ms)
          .slideY(begin: -0.3),

        const SizedBox(height: 32),
        
        // Stats rapides
        if (isDesktop) 
          Row(
            children: [
              _buildStatCard('3', 'Projets Actifs', Icons.rocket_launch),
              const SizedBox(width: 24),
              _buildStatCard('Open Source', 'Philosophie', Icons.code),
              const SizedBox(width: 24),
              _buildStatCard('Multi-OS', 'Support', Icons.devices),
            ],
          ).animate()
            .fadeIn(duration: 600.ms, delay: 400.ms)
            .slideY(begin: 0.3),
          
        const SizedBox(height: 32),
        
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
  
  Widget _buildStatCard(String value, String label, IconData icon) {
    return Expanded(
      child: Builder(
        builder: (context) => Container(
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
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectsList extends StatelessWidget {
  const _ProjectsList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Projets en cours',
          style: Theme.of(context).textTheme.headlineSmall,
        ).animate()
          .fadeIn(duration: 600.ms, delay: 800.ms)
          .slideX(begin: -0.3),
        
        const SizedBox(height: 32),
        
        ..._projects.asMap().entries.map((entry) {
          final index = entry.key;
          final project = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: _ProjectCard(project: project),
          ).animate(delay: ((index + 1) * 200).ms)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3);
        }),
      ],
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        child: TerminalCard(
          title: widget.project.name,
          child: ResponsiveRowColumn(
            layout: isDesktop 
              ? ResponsiveRowColumnType.ROW 
              : ResponsiveRowColumnType.COLUMN,
            rowCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveRowColumnItem(
                rowFlex: 2,
                child: _buildProjectInfo(context),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: _buildProjectMeta(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: widget.project.status.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: widget.project.status.color),
              ),
              child: Text(
                widget.project.status.label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: widget.project.status.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            if (widget.project.githubUrl != null)
              _buildActionButton(
                context,
                'GitHub',
                Icons.code,
                () => _launchUrl(widget.project.githubUrl!),
              ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        Text(
          widget.project.description,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        
        const SizedBox(height: 16),
        
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.project.technologies.map((tech) => 
            Chip(
              label: Text(
                tech,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              backgroundColor: AppTheme.backgroundColor,
              side: BorderSide(color: AppTheme.borderColor),
            ),
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildProjectMeta(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Détails',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          _buildMetaItem('Type', widget.project.type),
          _buildMetaItem('Plateforme', widget.project.platform),
          if (widget.project.progress != null)
            _buildProgressItem('Progression', widget.project.progress!),
        ],
      ),
    );
  }

  Widget _buildMetaItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressItem(String label, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppTheme.borderColor,
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.primaryColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

// Models et données
enum ProjectStatus {
  development('En développement', Colors.blue),
  planning('En préparation', Colors.orange),
  released('Publié', Colors.green);

  const ProjectStatus(this.label, this.color);
  final String label;
  final Color color;
}

class Project {
  final String name;
  final String description;
  final List<String> technologies;
  final ProjectStatus status;
  final String type;
  final String platform;
  final String? githubUrl;
  final double? progress;

  const Project({
    required this.name,
    required this.description,
    required this.technologies,
    required this.status,
    required this.type,
    required this.platform,
    this.githubUrl,
    this.progress,
  });
}

final List<Project> _projects = [
  Project(
    name: 'GetISO',
    description: 'Service de téléchargement d\'images ISO sécurisé et optimisé. Interface web moderne avec vérification d\'intégrité automatique et support multi-miroirs pour une expérience de téléchargement optimale.',
    technologies: ['Flutter Web', 'Dart', 'REST API'],
    status: ProjectStatus.development,
    type: 'Application Web',
    platform: 'Web',
    githubUrl: 'https://github.com/2c2t-dev/GetISO',
    progress: 0.75,
  ),
  Project(
    name: 'NetISO',
    description: 'Solution PXE complète pour le déploiement réseau d\'images ISO. Simplifie la gestion des démarrages réseau avec interface d\'administration intuitive et support de multiples distributions.',
    technologies: ['Python', 'Flask', 'PXE', 'Docker'],
    status: ProjectStatus.planning,
    type: 'Service Réseau',
    platform: 'Linux',
    githubUrl: 'https://github.com/2c2t-dev/NetISO',
    progress: 0.2,
  ),
  Project(
    name: 'BootISO',
    description: 'Application desktop multiplateforme pour créer des clés USB bootables. Interface moderne avec support de multiples formats et vérification automatique des médias créés.',
    technologies: ['Flutter Desktop', 'Dart', 'Native APIs'],
    status: ProjectStatus.planning,
    type: 'Application Desktop',
    platform: 'Windows, macOS, Linux',
    progress: 0.1,
  ),
];
