import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Background simple avec points 2c2t réactifs à la souris
class InteractiveDotBackground extends StatefulWidget {
  const InteractiveDotBackground({super.key});

  @override
  State<InteractiveDotBackground> createState() => _InteractiveDotBackgroundState();
}

class _InteractiveDotBackgroundState extends State<InteractiveDotBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Dot> _dots = [];
  Offset _mousePosition = Offset.zero;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _generateDots();
  }

  void _generateDots() {
    _dots.clear();
    
    // Meilleure répartition avec grille déformée pour un aspect naturel
    const gridCols = 6;
    const gridRows = 5;
    
    for (int row = 0; row < gridRows; row++) {
      for (int col = 0; col < gridCols; col++) {
        // Position de base sur la grille
        double baseX = (col + 0.5) / gridCols;
        double baseY = (row + 0.5) / gridRows;
        
        // Ajouter de la variation pour éviter l'effet grille
        double offsetX = (_random.nextDouble() - 0.5) * 0.15; // ±7.5% de variation
        double offsetY = (_random.nextDouble() - 0.5) * 0.15;
        
        _dots.add(Dot(
          baseX: (baseX + offsetX).clamp(0.05, 0.95), // Garder dans les limites
          baseY: (baseY + offsetY).clamp(0.05, 0.95),
          baseSize: 1.5 + _random.nextDouble() * 3.0, // Tailles plus variées
          opacity: 0.2 + _random.nextDouble() * 0.6,
          pulseSpeed: 0.8 + _random.nextDouble() * 0.4, // Vitesse de pulse individuelle
        ));
      }
    }
  }

  void _updateMousePosition(Offset position, Size size) {
    // Vérifier que les dimensions sont valides pour éviter les divisions par zéro
    if (size.width <= 0 || size.height <= 0) {
      return; // Ne pas mettre à jour si les dimensions sont invalides
    }
    
    if (mounted) {
      setState(() {
        _mousePosition = Offset(
          (position.dx / size.width).clamp(0.0, 1.0),
          (position.dy / size.height).clamp(0.0, 1.0),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: AppTheme.backgroundColor,
        child: MouseRegion(
          onHover: (event) {
            final RenderBox? box = context.findRenderObject() as RenderBox?;
            if (box != null && box.hasSize) {
              _updateMousePosition(event.localPosition, box.size);
            }
          },
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => CustomPaint(
              painter: DotPainter(
                dots: _dots,
                mousePosition: _mousePosition,
                animation: _controller.value,
              ),
              size: Size.infinite,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }
}

class Dot {
  final double baseX;
  final double baseY;
  double x;
  double y;
  final double baseSize;
  final double opacity;
  final double pulseSpeed;

  Dot({
    required this.baseX,
    required this.baseY,
    required this.baseSize,
    required this.opacity,
    required this.pulseSpeed,
  }) : x = baseX, y = baseY;
}

class DotPainter extends CustomPainter {
  final List<Dot> dots;
  final Offset mousePosition;
  final double animation;

  DotPainter({
    required this.dots,
    required this.mousePosition,
    required this.animation,
  });

  // Fonction utilitaire pour normaliser un vecteur
  Offset _normalizeOffset(Offset offset) {
    final magnitude = offset.distance;
    if (magnitude == 0) return Offset.zero;
    return Offset(offset.dx / magnitude, offset.dy / magnitude);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Vérifier que les dimensions sont valides pour éviter les NaN
    if (size.width <= 0 || size.height <= 0 || !size.width.isFinite || !size.height.isFinite) {
      return; // Ne pas peindre si les dimensions sont invalides
    }
    
    final mousePos = Offset(mousePosition.dx * size.width, mousePosition.dy * size.height);
    
    for (final dot in dots) {
      // Position de base du point
      final basePosition = Offset(dot.baseX * size.width, dot.baseY * size.height);
      
      // Vérifier que la position est valide
      if (!basePosition.dx.isFinite || !basePosition.dy.isFinite) {
        continue; // Ignorer ce point si sa position est invalide
      }
      
      // Calcul de la distance à la souris
      final distance = (basePosition - mousePos).distance;
      final maxDistance = size.width * 0.12; // Zone d'influence réduite pour plus de subtilité
      
      // Effet de mouvement selon la distance
      Offset targetPosition = basePosition;
      
      if (distance < maxDistance && distance > 0) {
        // Direction depuis la souris vers le point (répulsion)
        final direction = _normalizeOffset(basePosition - mousePos);
        
        // Force de répulsion avec courbe douce (plus forte quand plus proche)
        final normalizedDistance = distance / maxDistance;
        final easeOut = 1.0 - (normalizedDistance * normalizedDistance); // Courbe quadratique
        final force = easeOut * 25.0; // Déplacement max réduit pour plus de subtilité
        
        // Nouvelle position avec effet de répulsion
        targetPosition = basePosition + Offset(direction.dx * force, direction.dy * force);
        
        // Alternative: effet d'attraction douce (décommentez pour tester)
        // targetPosition = basePosition - Offset(direction.dx * force * 0.2, direction.dy * force * 0.2);
      }
      
      // Mise à jour fluide de la position du point avec interpolation douce
      final smoothing = 0.08; // Facteur d'interpolation plus lent pour plus de fluidité
      dot.x = dot.x + (targetPosition.dx / size.width - dot.x) * smoothing;
      dot.y = dot.y + (targetPosition.dy / size.height - dot.y) * smoothing;
      
      final dotPosition = Offset(dot.x * size.width, dot.y * size.height);
      
      // Vérifier que la position finale du point est valide
      if (!dotPosition.dx.isFinite || !dotPosition.dy.isFinite) {
        continue; // Ignorer ce point si sa position finale est invalide
      }
      
      // Pulse individuel avec variation plus subtile
      final individualPulse = sin(animation * 2 * pi * dot.pulseSpeed) * 0.15 + 1.0;
      final finalSize = dot.baseSize * individualPulse;
      
      // Vérifier que la taille est valide
      if (!finalSize.isFinite || finalSize <= 0) {
        continue; // Ignorer ce point si sa taille est invalide
      }
      
      // Intensité de l'effet selon la proximité avec courbe douce
      final effectIntensity = distance < maxDistance ? 
        pow(1.0 - distance / maxDistance, 1.5) : 0.0;
      
      // Couleurs avec gradients selon l'interaction
      final baseColor = AppTheme.primaryColor;
      final highlightColor = AppTheme.secondaryColor;
      final finalColor = Color.lerp(baseColor, highlightColor, effectIntensity * 0.6) ?? baseColor;
      final finalOpacity = dot.opacity * (1.0 + effectIntensity * 0.4);
      
      // Effet de glow et trail si proche de la souris
      if (effectIntensity > 0.05) {
        // Trail effect - ligne subtile vers la position de base si le point s'est déplacé
        final displacement = (dotPosition - basePosition).distance;
        if (displacement > 2.0) {
          final trailPaint = Paint()
            ..color = finalColor.withValues(alpha: effectIntensity * 0.15)
            ..strokeWidth = 0.8
            ..style = PaintingStyle.stroke;
          
          canvas.drawLine(basePosition, dotPosition, trailPaint);
        }
        
        // Glow externe avec intensité variable
        if (effectIntensity > 0.2) {
          final outerGlowPaint = Paint()
            ..color = finalColor.withValues(alpha: effectIntensity * 0.25)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10.0);
          canvas.drawCircle(dotPosition, finalSize * 2.5, outerGlowPaint);
        }
        
        // Glow interne
        final innerGlowPaint = Paint()
          ..color = finalColor.withValues(alpha: effectIntensity * 0.4)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);
        canvas.drawCircle(dotPosition, finalSize * 1.2, innerGlowPaint);
      }
      
      // Point principal avec taille ajustée selon l'interaction
      final interactiveSize = finalSize * (1.0 + effectIntensity * 0.3);
      
      // Vérifier que la taille interactive est valide avant de dessiner
      if (!interactiveSize.isFinite || interactiveSize <= 0) {
        continue; // Ignorer ce point si sa taille interactive est invalide
      }
      
      final paint = Paint()
        ..color = finalColor.withValues(alpha: finalOpacity)
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(dotPosition, interactiveSize, paint);
      
      // Point central lumineux pour la profondeur (seulement sur les points plus grands)
      if (interactiveSize > 2.5) {
        final centerPaint = Paint()
          ..color = const Color(0xFFFFFFFF).withValues(alpha: finalOpacity * 0.3)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(dotPosition, interactiveSize * 0.15, centerPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DotPainter oldDelegate) {
    return oldDelegate.mousePosition != mousePosition || 
           oldDelegate.animation != animation;
  }
}
