import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/theme/app_theme.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
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
        },
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        border: Border(
          top: BorderSide(color: AppTheme.borderColor, width: 1),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2024 2c2t.dev - Tous droits réservés',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextButton(
                onPressed: () => _showLegalDialog(context),
                child: Text(
                  'Mentions légales',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Développé avec ❤️ en Flutter',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showLegalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Mentions légales',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.primaryColor,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Éditeur du site',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '2c2t.dev\n'
                'Organisation open-source\n'
                'Contact: contact@2c2t.dev',
              ),
              const SizedBox(height: 16),
              Text(
                'Hébergement',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'GitHub Pages\n'
                'GitHub, Inc.\n'
                '88 Colin P Kelly Jr St\n'
                'San Francisco, CA 94107\n'
                'États-Unis',
              ),
              const SizedBox(height: 16),
              Text(
                'Propriété intellectuelle',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Le contenu de ce site est sous licence open-source. '
                'Les marques et logos mentionnés appartiennent à leurs propriétaires respectifs.',
              ),
              const SizedBox(height: 16),
              Text(
                'Données personnelles',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ce site ne collecte aucune donnée personnelle. '
                'Aucun cookie de tracking n\'est utilisé.',
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
}

class _NavItem {
  final String label;
  final String route;
  final IconData icon;

  const _NavItem(this.label, this.route, this.icon);
}
