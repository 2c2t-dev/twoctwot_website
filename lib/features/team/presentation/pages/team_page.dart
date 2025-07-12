import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/presentation/widgets/terminal_card.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

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
              const _TeamGrid(),
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
                    'Notre Équipe',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ).animate()
                    .fadeIn(duration: 600.ms)
                    .slideX(begin: -0.3),
                  const SizedBox(height: 8),
                  Text(
                    'Les personnes derrière 2c2t.dev',
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
              _buildStatCard('Multi-expertise', 'Compétences', Icons.build),
              const SizedBox(width: 24),
              _buildStatCard('4', 'Membres', Icons.people),
              const SizedBox(width: 24),
              _buildStatCard('Open Source', 'Philosophie', Icons.favorite),
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
                Icons.group,
                color: AppTheme.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Une équipe passionnée et complémentaire au service de l\'innovation',
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

class _TeamGrid extends StatelessWidget {
  const _TeamGrid();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Si l'écran est très large (plus de 1600px), on affiche en ligne
    if (screenWidth > 1600) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _teamMembers.asMap().entries.map((entry) {
          final index = entry.key;
          final member = entry.value;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _TeamMemberCard(member: member),
            ),
          ).animate(delay: ((index + 1) * 200).ms)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3);
        }).toList(),
      );
    } else {
      // Sinon affichage en grille pour tous les autres écrans
      return Center(
        child: Wrap(
          spacing: 32,
          runSpacing: 32,
          alignment: WrapAlignment.center,
          children: _teamMembers.asMap().entries.map((entry) {
            final index = entry.key;
            final member = entry.value;
            return SizedBox(
              width: 300,
              child: _TeamMemberCard(member: member),
            ).animate(delay: ((index + 1) * 200).ms)
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.3);
          }).toList(),
        ),
      );
    }
  }
}

class _TeamMemberCard extends StatelessWidget {
  final TeamMember member;

  const _TeamMemberCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return TerminalCard(
      title: member.name,
      child: _buildMemberContent(context),
    );
  }

  Widget _buildMemberContent(BuildContext context) {
    return Column(
      children: [
        // Photo de profil
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.primaryColor,
              width: 3,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              member.avatar,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppTheme.backgroundColor,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: AppTheme.primaryColor,
                  ),
                );
              },
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Nom et username
        Text(
          member.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 4),
        
        Text(
          member.username,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.primaryColor.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 8),
        
        // Rôle
        Text(
          member.role,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 16),
        
        // Réseaux sociaux
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: member.socialLinks.entries.take(3).map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _buildSocialButton(entry.key, entry.value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSocialButton(String platform, String url) {
    Widget iconWidget;
    Color color;
    
    switch (platform.toLowerCase()) {
      case 'github':
        color = const Color(0xFF333333);
        iconWidget = FaIcon(
          FontAwesomeIcons.github,
          size: 14,
          color: Colors.white,
        );
        break;
      case 'linkedin':
        color = const Color(0xFF0077B5);
        iconWidget = FaIcon(
          FontAwesomeIcons.linkedinIn,
          size: 14,
          color: Colors.white,
        );
        break;
      case 'portfolio':
        color = AppTheme.primaryColor;
        iconWidget = Icon(
          Icons.web,
          size: 14,
          color: Colors.white,
        );
        break;
      default:
        color = AppTheme.primaryColor;
        iconWidget = Icon(
          Icons.link,
          size: 14,
          color: Colors.white,
        );
    }

    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(child: iconWidget),
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

// Modèles de données
class TeamMember {
  final String name;
  final String username;
  final String role;
  final String bio;
  final String avatar;
  final List<String> technologies;
  final Map<String, String> socialLinks;
  final List<String> achievements;

  const TeamMember({
    required this.name,
    required this.username,
    required this.role,
    required this.bio,
    required this.avatar,
    required this.technologies,
    required this.socialLinks,
    required this.achievements,
  });
}

final List<TeamMember> _teamMembers = [
  TeamMember(
    name: 'Fabien MILLET',
    username: '@zipname',
    role: 'Administrateur',
    bio: 'Développeur passionné avec une expertise en Flutter et Python. Spécialisé dans le développement d\'applications modernes et performantes.',
    avatar: 'assets/profile/fabien.jpg',
    technologies: ['Flutter', 'Dart', 'Python', 'Docker'],
    socialLinks: {
      'GitHub': 'https://github.com/fabienmillet',
      'LinkedIn': 'https://www.linkedin.com/in/fmillet/',
      'Portfolio': 'https://fabien-millet.fr/',
    },
    achievements: [
      'Expert Flutter & Dart',
      'Architecte logiciel',
      'Open source contributor',
    ],
  ),
  TeamMember(
    name: 'Maël L.',
    username: '@lexdrane',
    role: 'Administrateur',
    bio: 'Administrateur système expert en virtualisation et infrastructure. Passionné par les technologies de conteneurisation et l\'automatisation.',
    avatar: 'assets/profile/mael.png',
    technologies: ['Docker', 'LXC', 'KVM', 'Linux'],
    socialLinks: {
      'Portfolio': 'https://lexdrane.fr/',
    },
    achievements: [
      'Expert en administration système',
      'Spécialiste virtualisation',
      'Architecte infrastructure',
    ],
  ),
  TeamMember(
    name: 'Nathan MANNESSIER',
    username: '@hulkhogan6262',
    role: 'Administrateur',
    bio: 'Administrateur réseau et développeur. Expert en solutions de déploiement et automatisation des systèmes.',
    avatar: 'assets/profile/nathan.png',
    technologies: ['Network', 'PXE', 'Git', 'Automation'],
    socialLinks: {
      'GitHub': 'https://github.com/HulkHogan6262',
      'LinkedIn': 'https://www.linkedin.com/in/nathan-mannessier-salembien-048252315/',
      'Portfolio': 'https://nathan-mannessier.fr/',
    },
    achievements: [
      'Expert en réseau et PXE',
      'Spécialiste déploiement',
      'Automatisation système',
    ],
  ),
  TeamMember(
    name: 'Lorenzo N.',
    username: '@lorelix.fr',
    role: 'Administrateur',
    bio: 'Administrateur système passionné par les technologies web et l\'innovation numérique.',
    avatar: 'assets/profile/lorenzo.png',
    technologies: ['Web', 'System', 'Innovation', 'Tech'],
    socialLinks: {
      'Portfolio': 'https://lorelix.fr/',
    },
    achievements: [
      'Expert en administration système',
      'Spécialiste technologies web',
      'Innovation numérique',
    ],
  ),
];
