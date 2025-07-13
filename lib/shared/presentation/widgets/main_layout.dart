import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../core/theme/app_theme.dart';


import 'package:url_launcher/url_launcher.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    return Scaffold(
      drawer: !isDesktop ? const _MobileDrawer() : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (isDesktop) {
            return Column(
              children: [
                const _AppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: child,
                  ),
                ),
                const _Footer(),
              ],
            );
          } else {
            return Column(
              children: [
                const _AppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          child,
                          const _Footer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer();

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).matchedLocation;
    
    final navItems = [
      _NavItem('Accueil', '/', Icons.home_rounded),
      _NavItem('Projets', '/projects', Icons.code_rounded),
      _NavItem('Équipe', '/team', Icons.people_rounded),
      _NavItem('À propos', '/about', Icons.info_rounded),
      _NavItem('Contact', '/contact', Icons.mail_rounded),
    ];

    return Drawer(
      backgroundColor: AppTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.backgroundColor,
              AppTheme.backgroundColor.withValues(alpha: 0.95),
            ],
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(-5, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header du drawer
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.primaryColor.withValues(alpha: 0.2),
                            AppTheme.primaryColor.withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppTheme.primaryColor.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/logo_2c2t.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.code_rounded,
                              color: AppTheme.primaryColor,
                              size: 28,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '2c2t.dev',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Menu de navigation',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary.withValues(alpha: 0.8),
                        letterSpacing: 0.3,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            // Divider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                height: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        AppTheme.primaryColor.withValues(alpha: 0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Navigation items
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: navItems.map((item) => 
                    _buildMobileNavButton(context, item, currentRoute),
                  ).toList(),
                ),
              ),
            ),
            
            // Footer du drawer supprimé
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavButton(BuildContext context, _NavItem item, String currentRoute) {
    final isActive = currentRoute == item.route;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(        onTap: () {
          if (context.mounted) {
            Navigator.of(context).pop(); // Ferme le drawer
            context.go(item.route);
          }
        },
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: isActive 
                ? LinearGradient(
                    colors: [
                      AppTheme.primaryColor,
                      AppTheme.primaryColor.withValues(alpha: 0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
              borderRadius: BorderRadius.circular(12),
              border: isActive 
                ? Border.all(
                    color: AppTheme.primaryColor, 
                    width: 1.5
                  )
                : Border.all(
                    color: Colors.transparent, 
                    width: 1.5
                  ),
              boxShadow: isActive 
                ? [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isActive 
                      ? Colors.white.withValues(alpha: 0.2)
                      : AppTheme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    item.icon,
                    size: 20,
                    color: isActive 
                      ? Colors.white 
                      : AppTheme.textSecondary.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    item.label,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isActive 
                        ? Colors.white 
                        : AppTheme.textSecondary,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 15,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                if (isActive)
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ...existing code...
}



// ...existing code...

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.backgroundColor,
            AppTheme.backgroundColor.withValues(alpha: 0.95),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: AppTheme.primaryColor.withValues(alpha: 0.1), 
            width: 1.5
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isDesktop ? 24 : 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: _buildLogo(context),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: _buildNavigation(context, isDesktop),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmall = screenWidth < 400;
    final isSmall = screenWidth < 600;
    
    return InkWell(
      onTap: () {
        if (context.mounted) {
          context.go('/');
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: isVerySmall ? 24 : 32,
            height: isVerySmall ? 24 : 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/logo_2c2t.png',
                width: isVerySmall ? 24 : 32,
                height: isVerySmall ? 24 : 32,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppTheme.primaryColor,
                    child: Icon(
                      Icons.code,
                      color: Colors.white,
                      size: isVerySmall ? 16 : 20,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: isVerySmall ? 6 : 12),
          if (!isSmall || screenWidth > 300)
            Flexible(
              child: Text(
                isVerySmall ? '2c2t' : '2c2t.dev',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: isVerySmall ? 16 : null,
                ),
                overflow: TextOverflow.ellipsis,
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
      return Align(
        alignment: Alignment.centerRight,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: navItems.map((item) => 
              _buildNavButton(context, item, currentRoute),
            ).toList(),
          ),
        ),
      );
    } else {
      // Menu drawer pour mobile
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
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
          child: IconButton(
            onPressed: () {
              if (context.mounted) {
                Scaffold.of(context).openDrawer();
              }
            },
            icon: Icon(
              Icons.menu_rounded,
              color: AppTheme.primaryColor,
              size: 20,
            ),
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildNavButton(BuildContext context, _NavItem item, String currentRoute) {
    final isActive = currentRoute == item.route;
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 1200;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isCompact ? 2 : 4),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: InkWell(
            onTap: () {
              if (context.mounted) {
                context.go(item.route);
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isCompact ? 8 : 12, 
                vertical: 10
              ),
              decoration: BoxDecoration(
                gradient: isActive 
                  ? LinearGradient(
                      colors: [
                        AppTheme.primaryColor,
                        AppTheme.primaryColor.withValues(alpha: 0.9),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
                borderRadius: BorderRadius.circular(12),
                border: isActive 
                  ? Border.all(
                      color: AppTheme.primaryColor, 
                      width: 1.5
                    )
                  : Border.all(
                      color: Colors.transparent, 
                      width: 1.5
                    ),
                boxShadow: isActive 
                  ? [
                      BoxShadow(
                        color: AppTheme.primaryColor.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ]
                  : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isActive 
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      item.icon,
                      size: isCompact ? 14 : 16,
                      color: isActive ? Colors.white : AppTheme.textSecondary,
                    ),
                  ),
                  SizedBox(width: isCompact ? 4 : 6),
                  Text(
                    item.label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isActive ? Colors.white : AppTheme.textSecondary,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      fontSize: isCompact ? 12 : 14,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image.asset(
                  'assets/images/logo_2c2t.png',
                  width: 16,
                  height: 16,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.code,
                      color: AppTheme.primaryColor,
                      size: 16,
                    );
                  },
                ),
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
                  '© 2025 - Open Source',
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
        // Brand - Logo et titre centrés
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image.asset(
                  'assets/images/logo_2c2t.png',
                  width: 18,
                  height: 18,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.code,
                      color: AppTheme.primaryColor,
                      size: 18,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '2c2t.dev',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Copyright centré
        Text(
          '© 2025 - Open Source',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary.withValues(alpha: 0.8),
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 16),
        
        // Liens - Réseaux sociaux et mentions légales centrés
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              context,
              Icons.code,
              'GitHub',
              'https://github.com/2c2t-dev',
            ),
            const SizedBox(width: 12),
            _buildSocialButton(
              context,
              Icons.email_outlined,
              'Email',
              'mailto:contact@2c2t.dev',
            ),
            const SizedBox(width: 12),
            Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppTheme.primaryColor.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: InkWell(
                onTap: () => _showLegalDialog(context),
                borderRadius: BorderRadius.circular(6),
                child: Center(
                  child: Text(
                    'Légal',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.primaryColor.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
              _buildLegalItem(context, 'Hébergement', 'Cloudflare Pages'),
              _buildLegalItem(context, 'Licence', 'Open Source (GPL)'),
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
            onPressed: () {
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
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
