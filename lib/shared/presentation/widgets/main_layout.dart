import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_theme.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const _AppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: child,
            ),
          ),
          const _Footer(),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        border: Border(
          bottom: BorderSide(color: AppTheme.borderColor, width: 1),
        ),
      ),
      child: ResponsiveRowColumn(
        layout: isDesktop 
          ? ResponsiveRowColumnType.ROW 
          : ResponsiveRowColumnType.COLUMN,
        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
        columnMainAxisAlignment: MainAxisAlignment.center,
        rowCrossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ResponsiveRowColumnItem(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildLogo(context),
            ),
          ),
          ResponsiveRowColumnItem(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildNavigation(context, isDesktop),
            ),
          ),
        ],
      ),
    ).animate().slideY(
      begin: -1,
      duration: 600.ms,
      curve: Curves.easeOutCubic,
    );
  }

  Widget _buildLogo(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/'),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/logo_2c2t.png',
                width: 32,
                height: 32,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppTheme.primaryColor,
                    child: const Icon(
                      Icons.code,
                      color: Colors.white,
                      size: 20,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '2c2t.dev',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigation(BuildContext context, bool isDesktop) {
    final currentRoute = GoRouterState.of(context).matchedLocation;
    
    final navItems = [
      _NavItem('Accueil', '/', Icons.home),
      _NavItem('Projets', '/projects', Icons.code),
      _NavItem('Équipe', '/team', Icons.people),
      _NavItem('À propos', '/about', Icons.info),
      _NavItem('Contact', '/contact', Icons.mail),
    ];

    if (isDesktop) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: navItems.map((item) => 
          _buildNavButton(context, item, currentRoute),
        ).toList(),
      );
    } else {
      return PopupMenuButton<String>(
        icon: Icon(
          Icons.menu,
          color: AppTheme.primaryColor,
        ),
        onSelected: (route) => context.go(route),
        itemBuilder: (context) => navItems.map((item) => 
          PopupMenuItem<String>(
            value: item.route,
            child: Row(
              children: [
                Icon(item.icon, size: 16),
                const SizedBox(width: 8),
                Text(item.label),
              ],
            ),
          ),
        ).toList(),
      );
    }
  }

  Widget _buildNavButton(BuildContext context, _NavItem item, String currentRoute) {
    final isActive = currentRoute == item.route;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () => context.go(item.route),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isActive 
              ? AppTheme.primaryColor.withValues(alpha: 0.1)
              : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isActive 
              ? Border.all(color: AppTheme.primaryColor, width: 1)
              : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                item.icon,
                size: 16,
                color: isActive ? AppTheme.primaryColor : AppTheme.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                item.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isActive ? AppTheme.primaryColor : AppTheme.textSecondary,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        border: Border(
          top: BorderSide(color: AppTheme.primaryColor.withValues(alpha: 0.15), width: 1),
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: EdgeInsets.symmetric(
            vertical: isDesktop ? 24 : 20,
            horizontal: 24,
          ),
          child: isDesktop ? _buildDesktopFooter(context) : _buildMobileFooter(context),
        ),
      ),
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side - Brand & Copyright
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.code,
                color: AppTheme.primaryColor,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2c2t.dev',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '© 2024 - Open Source',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
        
        // Right side - Social & Legal
        Row(
          children: [
            _buildSocialButton(
              context,
              Icons.code,
              'GitHub',
              'https://github.com/2c2t-dev',
            ),
            const SizedBox(width: 8),
            _buildSocialButton(
              context,
              Icons.email_outlined,
              'Email',
              'mailto:contact@2c2t.dev',
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: () => _showLegalDialog(context),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                'Mentions légales',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.primaryColor.withValues(alpha: 0.8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      children: [
        // Brand
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.code,
                color: AppTheme.primaryColor,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '2c2t.dev',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Social & Copyright
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildSocialButton(
                  context,
                  Icons.code,
                  'GitHub',
                  'https://github.com/2c2t-dev',
                ),
                const SizedBox(width: 8),
                _buildSocialButton(
                  context,
                  Icons.email_outlined,
                  'Email',
                  'mailto:contact@2c2t.dev',
                ),
              ],
            ),
            TextButton(
              onPressed: () => _showLegalDialog(context),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
              child: Text(
                'Mentions légales',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.primaryColor.withValues(alpha: 0.8),
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        Text(
          '© 2024 - Open Source',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(BuildContext context, IconData icon, String tooltip, String url) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        onPressed: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        icon: Icon(
          icon,
          color: AppTheme.primaryColor.withValues(alpha: 0.8),
          size: 18,
        ),
        style: IconButton.styleFrom(
          backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.all(8),
        ),
      ),
    );
  }

  void _showLegalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
        ),
        title: Row(
          children: [
            Icon(
              Icons.gavel,
              color: AppTheme.primaryColor,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Mentions légales',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLegalItem(context, 'Éditeur', '2c2t.dev - Organisation open-source'),
              _buildLegalItem(context, 'Contact', 'contact@2c2t.dev'),
              _buildLegalItem(context, 'Hébergement', 'GitHub Pages'),
              _buildLegalItem(context, 'Licence', 'Open Source (MIT)'),
              _buildLegalItem(context, 'Données', 'Aucune collecte de données personnelles'),
              
              const SizedBox(height: 16),
              
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppTheme.primaryColor,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Site 100% transparent et open-source',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Fermer',
              style: TextStyle(color: AppTheme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalItem(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String route;
  final IconData icon;

  const _NavItem(this.label, this.route, this.icon);
}
