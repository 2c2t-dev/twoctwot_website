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
    const body = 'Bonjour,\n\nJe vous contacte car';
    
    final uri = Uri.parse('mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}');
    
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendWhatsApp() async {
    const phone = '33972114949'; // Remplacez par votre numéro WhatsApp
    const message = 'Bonjour, je vous contacte car ';
    
    final uri = Uri.parse('https://wa.me/$phone?text=${Uri.encodeComponent(message)}');
    
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmall = screenWidth < 600;
    final isSmall = screenWidth < 900;
    
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isVerySmall ? 16.0 : (isSmall ? 24.0 : 32.0),
          vertical: isVerySmall ? 16.0 : 32.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Contactez-nous',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
                fontSize: isVerySmall ? 28 : null,
              ),
            ).animate().fadeIn().slideX(begin: -0.3),
            
            SizedBox(height: isVerySmall ? 12 : 16),
            
            Text(
              'Prêt à collaborer ? Parlons de votre projet !',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.grey[400],
                fontSize: isVerySmall ? 18 : null,
              ),
            ).animate(delay: 200.ms).fadeIn().slideX(begin: -0.3),
            
            SizedBox(height: isVerySmall ? 32 : 48),
            
            // Contact Section unifiée
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: TerminalCard(
                  title: '💬 Restons en contact',
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Adaptation plus fine pour très petits écrans
                      if (constraints.maxWidth > 700) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 2,
                              child: _buildInfoContent(),
                            ),
                            SizedBox(width: isVerySmall ? 24 : 48),
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
                            SizedBox(height: isVerySmall ? 24 : 32),
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
        const SizedBox(height: 12),
        _buildSimpleContactCard(
          icon: FontAwesomeIcons.whatsapp,
          title: 'WhatsApp',
          subtitle: '+33 9 72 11 49 49',
          onTap: _sendWhatsApp,
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
    return _HoverContactCard(
      icon: icon,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
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

class _HoverContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HoverContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  State<_HoverContactCard> createState() => _HoverContactCardState();
}

class _HoverContactCardState extends State<_HoverContactCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.25, // 90 degrés (0.25 * 360)
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onEnter() {
    setState(() {
      _isHovered = true;
    });
    _animationController.forward();
  }

  void _onExit() {
    setState(() {
      _isHovered = false;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _onEnter(),
      onExit: (_) => _onExit(),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isHovered 
              ? AppTheme.primaryColor.withValues(alpha: 0.05)
              : AppTheme.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered 
                ? AppTheme.primaryColor.withValues(alpha: 0.4)
                : AppTheme.primaryColor.withValues(alpha: 0.2),
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: _isHovered ? [
              BoxShadow(
                color: AppTheme.primaryColor.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ] : [
              BoxShadow(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) => Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Icon(
                    widget.icon,
                    color: _isHovered 
                      ? AppTheme.primaryColor
                      : AppTheme.primaryColor.withValues(alpha: 0.8),
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _isHovered 
                          ? AppTheme.primaryColor
                          : AppTheme.primaryColor.withValues(alpha: 0.9),
                      ),
                      child: Text(widget.title),
                    ),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: 12,
                        color: _isHovered 
                          ? Colors.grey[300]
                          : Colors.grey[400],
                      ),
                      child: Text(widget.subtitle),
                    ),
                  ],
                ),
              ),
              AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) => Transform.rotate(
                  angle: _rotationAnimation.value * 2 * 3.14159, // Conversion en radians
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: _isHovered 
                      ? AppTheme.primaryColor
                      : AppTheme.primaryColor.withValues(alpha: 0.5),
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
