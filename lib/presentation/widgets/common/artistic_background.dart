import 'package:flutter/material.dart';
import 'dart:math' as math;

class ArtisticBackground extends StatefulWidget {
  final Widget child;
  final bool isHeroSection;

  const ArtisticBackground({
    super.key,
    required this.child,
    this.isHeroSection = false,
  });

  @override
  State<ArtisticBackground> createState() => _ArtisticBackgroundState();
}

class _ArtisticBackgroundState extends State<ArtisticBackground>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _particleController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    
    _particleController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Animated circuit patterns
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return CustomPaint(
                painter: ArtisticPatternPainter(
                  animationValue: _animationController.value,
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  isDark: Theme.of(context).brightness == Brightness.dark,
                ),
              );
            },
          ),
        ),
        
        // Floating particles for hero section
        if (widget.isHeroSection)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _particleController,
              builder: (context, child) {
                return CustomPaint(
                  painter: FloatingParticlesPainter(
                    animationValue: _particleController.value,
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                  ),
                );
              },
            ),
          ),
        
        // Content
        widget.child,
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _particleController.dispose();
    super.dispose();
  }
}

class ArtisticPatternPainter extends CustomPainter {
  final double animationValue;
  final Color color;
  final bool isDark;

  ArtisticPatternPainter({
    required this.animationValue,
    required this.color,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    // Circuit board traces with animation
    _drawAnimatedCircuits(canvas, size, paint);
    
    // Guitar wave patterns
    _drawSoundWaves(canvas, size, paint);
    
    // Beer hop shapes (subtle)
    _drawHopPatterns(canvas, size, fillPaint);
    
    // Code-like grid patterns
    _drawCodeGrid(canvas, size, paint);
  }

  void _drawAnimatedCircuits(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    
    // Main horizontal traces
    for (int i = 0; i < 8; i++) {
      final y = (size.height / 8) * i;
      final animatedX = (animationValue * 200) % 300;
      
      path.moveTo(0, y);
      path.lineTo(size.width * 0.3 + animatedX, y);
      path.moveTo(size.width * 0.7 + animatedX, y);
      path.lineTo(size.width, y);
      
      // Connection nodes
      canvas.drawCircle(
        Offset(size.width * 0.3 + animatedX, y),
        3,
        paint..style = PaintingStyle.fill,
      );
      canvas.drawCircle(
        Offset(size.width * 0.7 + animatedX, y),
        3,
        paint..style = PaintingStyle.fill,
      );
      paint.style = PaintingStyle.stroke;
    }
    
    canvas.drawPath(path, paint);
  }

  void _drawSoundWaves(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    final waveHeight = 30.0;
    final frequency = 4.0;
    
    // Guitar-inspired sound waves
    for (int wave = 0; wave < 3; wave++) {
      final baseY = size.height * 0.2 + (wave * size.height * 0.3);
      path.reset();
      
      for (double x = 0; x < size.width; x += 2) {
        final animatedFreq = frequency + (animationValue * 2);
        final y = baseY + 
            waveHeight * math.sin((x / size.width * 2 * math.pi * animatedFreq) + 
            (animationValue * 2 * math.pi));
        
        if (x == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      
      canvas.drawPath(path, paint..color = color.withValues(alpha: 0.4));
    }
  }

  void _drawHopPatterns(Canvas canvas, Size size, Paint paint) {
    // Subtle hop/leaf shapes scattered around
    for (int i = 0; i < 15; i++) {
      final x = (size.width / 15) * i + (animationValue * 50) % 100;
      final y = (size.height / 3) + 
          30 * math.sin(animationValue * 2 * math.pi + i);
      
      _drawHopShape(canvas, Offset(x, y), 8, paint);
    }
  }

  void _drawHopShape(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    
    // Simple hop/leaf shape
    path.moveTo(center.dx, center.dy - size);
    path.quadraticBezierTo(
      center.dx + size * 0.7, center.dy - size * 0.3,
      center.dx, center.dy + size,
    );
    path.quadraticBezierTo(
      center.dx - size * 0.7, center.dy - size * 0.3,
      center.dx, center.dy - size,
    );
    
    canvas.drawPath(path, paint);
  }

  void _drawCodeGrid(Canvas canvas, Size size, Paint paint) {
    // Subtle grid pattern reminiscent of code structure
    paint.color = color.withValues();
    
    final spacing = 80.0;
    final animatedOffset = (animationValue * spacing) % spacing;
    
    // Vertical lines
    for (double x = animatedOffset; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    
    // Horizontal lines
    for (double y = animatedOffset; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class FloatingParticlesPainter extends CustomPainter {
  final double animationValue;
  final Color color;

  FloatingParticlesPainter({
    required this.animationValue,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Create floating particles representing different interests
    final particles = [
      // Tech particles (squares and circles)
      for (int i = 0; i < 20; i++)
        _createTechParticle(size, i, animationValue),
      
      // Music notes
      for (int i = 0; i < 8; i++)
        _createMusicParticle(size, i, animationValue),
    ];

    for (final particle in particles) {
      canvas.save();
      canvas.translate(particle.offset.dx, particle.offset.dy);
      canvas.rotate(particle.rotation);
      
      if (particle.type == ParticleType.circle) {
        canvas.drawCircle(Offset.zero, particle.size, paint..color = particle.color);
      } else if (particle.type == ParticleType.square) {
        canvas.drawRect(
          Rect.fromCenter(center: Offset.zero, width: particle.size * 2, height: particle.size * 2),
          paint..color = particle.color,
        );
      } else if (particle.type == ParticleType.musicNote) {
        _drawMusicNote(canvas, particle.size, paint..color = particle.color);
      }
      
      canvas.restore();
    }
  }

  FloatingParticle _createTechParticle(Size size, int index, double time) {
    final baseX = (size.width / 20) * index;
    final baseY = size.height * 0.3 + (index % 3) * size.height * 0.2;
    
    return FloatingParticle(
      offset: Offset(
        baseX + 50 * math.sin(time * 2 * math.pi + index),
        baseY + 30 * math.cos(time * 1.5 * math.pi + index),
      ),
      size: 2 + (index % 3),
      rotation: time * 2 * math.pi + index,
      color: color.withValues(alpha: 0.3 + 0.4 * math.sin(time * math.pi + index)),
      type: index % 2 == 0 ? ParticleType.circle : ParticleType.square,
    );
  }

  FloatingParticle _createMusicParticle(Size size, int index, double time) {
    return FloatingParticle(
      offset: Offset(
        size.width * 0.8 + 40 * math.sin(time * 1.5 * math.pi + index),
        size.height * 0.2 + index * 60 + 20 * math.cos(time * 2 * math.pi + index),
      ),
      size: 6,
      rotation: 0,
      color: color.withValues(alpha: 0.4),
      type: ParticleType.musicNote,
    );
  }

  void _drawMusicNote(Canvas canvas, double size, Paint paint) {
//    final path = Path();
    
    // Simple music note shape
    canvas.drawCircle(Offset(0, size), size * 0.4, paint);
    canvas.drawRect(
      Rect.fromLTWH(size * 0.35, -size, size * 0.15, size * 1.8),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

enum ParticleType { circle, square, musicNote }

class FloatingParticle {
  final Offset offset;
  final double size;
  final double rotation;
  final Color color;
  final ParticleType type;

  FloatingParticle({
    required this.offset,
    required this.size,
    required this.rotation,
    required this.color,
    required this.type,
  });
}
