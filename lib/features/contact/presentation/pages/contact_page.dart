import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/presentation/widgets/terminal_card.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendEmail() async {
    const email = 'contact@2c2t.dev';
    const subject = 'Contact depuis 2c2t.dev';
    const body = 'Bonjour,\n\nJe vous contacte depuis votre site web...\n\nCordialement';
    
    final uri = Uri.parse('mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}');
    
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Contactez-nous',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ).animate().fadeIn().slideX(begin: -0.3),
            
            const SizedBox(height: 16),
            
            Text(
              'Prêt à collaborer ? Parlons de votre projet !',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.grey[400],
              ),
            ).animate(delay: 200.ms).fadeIn().slideX(begin: -0.3),
            
            const SizedBox(height: 48),
            
            // Contact Section unifiée
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: TerminalCard(
                  title: '💬 Contactez-nous',
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 600) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 2,
                              child: _buildInfoContent(),
                            ),
                            const SizedBox(width: 48),
                            Flexible(
                              flex: 2,
                              child: _buildContactContent(),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            _buildInfoContent(),
                            const SizedBox(height: 32),
                            _buildContactContent(),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.3),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '💡 Nous sommes là pour vous aider',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        _buildInfoItem(
          '🔧',
          'Expertise technique',
          'Système, développement, DevOps',
        ),
        _buildInfoItem(
          '🤝',
          'Collaboration',
          'Travail en équipe et accompagnement',
        ),
        _buildInfoItem(
          '⚡',
          'Réactivité',
          'Réponse sous 24h en général',
        ),
        _buildInfoItem(
          '🚀',
          'Projets innovants',
          'Développement d\'outils système et applications',
        ),
      ],
    );
  }

  Widget _buildContactContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '📧 Moyens de contact',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        _buildSimpleContactCard(
          icon: Icons.email_outlined,
          title: 'Email',
          subtitle: 'contact@2c2t.dev',
          onTap: _sendEmail,
        ),
        const SizedBox(height: 12),
        _buildSimpleContactCard(
          icon: FontAwesomeIcons.github,
          title: 'GitHub',
          subtitle: 'github.com/2c2t-dev',
          onTap: () => _launchUrl('https://github.com/2c2t-dev'),
        ),
        const SizedBox(height: 12),
        _buildSimpleContactCard(
          icon: FontAwesomeIcons.discord,
          title: 'Discord',
          subtitle: 'discord.2c2t.dev',
          onTap: () => _launchUrl('https://discord.2c2t.dev/'),
        ),
      ],
    );
  }

  Widget _buildSimpleContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.primaryColor.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.primaryColor.withValues(alpha: 0.5),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TerminalCard(
          title: '💡 Nous sommes là pour vous aider',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoItem(
                '�',
                'Expertise technique',
                'Système, développement, DevOps',
              ),
              _buildInfoItem(
                '🤝',
                'Collaboration',
                'Travail en équipe et accompagnement',
              ),
              _buildInfoItem(
                '⚡',
                'Réactivité',
                'Réponse sous 24h en général',
              ),
              _buildInfoItem(
                '�',
                'Projets innovants',
                'Développement d\'outils système et applications',
              ),
            ],
          ),
        ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.3),
      ],
    );
  }

  Widget _buildInfoItem(String emoji, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
