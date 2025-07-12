import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_theme.dart';

class TerminalCard extends StatefulWidget {
  final Widget child;
  final String? title;
  final bool showHeader;
  final VoidCallback? onTap;

  const TerminalCard({
    super.key,
    required this.child,
    this.title,
    this.showHeader = true,
    this.onTap,
  });

  @override
  State<TerminalCard> createState() => _TerminalCardState();
}

class _TerminalCardState extends State<TerminalCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (mounted) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (mounted) setState(() => _isHovered = false);
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered 
                ? AppTheme.primaryColor.withValues(alpha: 0.5)
                : AppTheme.borderColor,
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.showHeader) _buildHeader(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: widget.child,
              ),
            ],
          ),
        ).animate(target: _isHovered ? 1 : 0)
          .scale(begin: const Offset(1, 1), end: const Offset(1.01, 1.01)),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border(
          bottom: BorderSide(color: AppTheme.borderColor, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Boutons de fenêtre style terminal
          _buildWindowButton(Colors.red),
          const SizedBox(width: 8),
          _buildWindowButton(Colors.yellow),
          const SizedBox(width: 8),
          _buildWindowButton(Colors.green),
          
          if (widget.title != null) ...[
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.title!,
                style: const TextStyle(fontFamily: 'JetBrains Mono, Monaco, Consolas, monospace',
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWindowButton(Color color) {
    return _WindowButton(color: color);
  }
}

class _WindowButton extends StatefulWidget {
  final Color color;
  
  const _WindowButton({required this.color});
  
  @override
  State<_WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<_WindowButton> {
  bool _isHovered = false;
  
  @override
  Widget build(BuildContext context) {
    IconData? icon;
    
    // Déterminer l'icône selon la couleur
    if (widget.color == Colors.red) {
      icon = Icons.close;
    } else if (widget.color == Colors.yellow) {
      icon = Icons.minimize;
    } else if (widget.color == Colors.green) {
      icon = Icons.fullscreen;
    }
    
    return MouseRegion(
      onEnter: (_) {
        if (mounted) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (mounted) setState(() => _isHovered = false);
      },
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: widget.color.withValues(alpha: _isHovered ? 1.0 : 0.8),
          shape: BoxShape.circle,
          boxShadow: _isHovered ? [
            BoxShadow(
              color: widget.color.withValues(alpha: 0.4),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ] : [],
        ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: _isHovered ? 1.0 : 0.0,
          child: Icon(
            icon,
            size: 8,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class TerminalText extends StatelessWidget {
  final String text;
  final Color? color;
  final bool showPrompt;
  final String prompt;

  const TerminalText({
    super.key,
    required this.text,
    this.color,
    this.showPrompt = false,
    this.prompt = '> ',
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          if (showPrompt)
            TextSpan(
              text: prompt,
              style: const TextStyle(fontFamily: 'JetBrains Mono, Monaco, Consolas, monospace',
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          TextSpan(
            text: text,
            style: TextStyle(
              fontFamily: 'JetBrains Mono, Monaco, Consolas, monospace',
              color: color ?? AppTheme.textSecondary,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class BlinkingCursor extends StatefulWidget {
  final Color? color;
  final double? size;

  const BlinkingCursor({
    super.key,
    this.color,
    this.size,
  });

  @override
  State<BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<BlinkingCursor>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _controller.value,
          child: Text(
            '█',
            style: TextStyle(
              fontFamily: 'JetBrains Mono, Monaco, Consolas, monospace',
              color: widget.color ?? AppTheme.primaryColor,
              fontSize: widget.size ?? 14,
            ),
          ),
        );
      },
    );
  }
}
