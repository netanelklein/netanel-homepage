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
  late AnimationController _terminalController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    
    _terminalController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Subtle circuit patterns (static)
        Positioned.fill(
          child: CustomPaint(
            painter: SubtlePatternPainter(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.03),
              isDark: Theme.of(context).brightness == Brightness.dark,
            ),
          ),
        ),
        
        // Terminal-style data for hero section
        if (widget.isHeroSection)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _terminalController,
              builder: (context, child) {
                return CustomPaint(
                  painter: TerminalDataPainter(
                    animationValue: _terminalController.value,
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
                    isDark: Theme.of(context).brightness == Brightness.dark,
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
    _terminalController.dispose();
    super.dispose();
  }
}

class SubtlePatternPainter extends CustomPainter {
  final Color color;
  final bool isDark;

  SubtlePatternPainter({
    required this.color,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Subtle grid pattern
    final spacing = 100.0;
    
    // Vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    
    // Horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // Small connection nodes at intersections
    paint.style = PaintingStyle.fill;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class TerminalDataPainter extends CustomPainter {
  final double animationValue;
  final Color color;
  final bool isDark;

  TerminalDataPainter({
    required this.animationValue,
    required this.color,
    required this.isDark,
  });

  final List<String> terminalLines = [
    '\$ netanel@system:~\\\$ whoami',
    'Electrical Engineering Student',
    '\$ cat /proc/skills',
    'DevOps: Docker, CI/CD, Cloud Infrastructure',
    'Development: Flutter, React Native, PHP',
    'Engineering: IoT, PCB Design, Circuit Analysis',
    'Hobbies: Guitar, Brewing, Mixology',
    '\$ ps aux | grep passion',
    'brewing_automation  PID:1337  CPU:100%  ⚡',
    'guitar_practice     PID:2024  CPU:85%   🎸',
    'code_crafting       PID:2025  CPU:95%   💻',
    'cocktail_mixing     PID:1969  CPU:75%   🍸',
    '\$ uptime',
    'Learning since: boot time',
    'Projects completed: 15+',
    '\$ tail -f /var/log/interests.log',
    '[INFO] IoT brewing system: pH monitoring active',
    '[INFO] Guitar pickup winder: design phase',
    '[INFO] Smart home sensors: deployment ready',
    '\$ echo "Crafting solutions from circuits to cocktails" ✨',
    'Crafting solutions from circuits to cocktails ✨',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );

    final lineHeight = 18.0;
    final startY = size.height * 0.15;
    final visibleLines = (animationValue * terminalLines.length).floor();

    for (int i = 0; i < math.min(visibleLines + 1, terminalLines.length); i++) {
      final opacity = i == visibleLines 
          ? (animationValue * terminalLines.length) % 1.0
          : math.max(0.1, 0.7 - (i * 0.03)); // Fade older lines gradually
      
      if (opacity <= 0) continue;

      final isCommand = terminalLines[i].startsWith('\$');
      final isOutput = !isCommand && !terminalLines[i].contains(':') && !terminalLines[i].contains('[');
      
      textPainter.text = TextSpan(
        text: terminalLines[i],
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: color.withValues(alpha: opacity * (isCommand ? 1.2 : isOutput ? 0.8 : 0.9)),
          fontWeight: isCommand ? FontWeight.w600 : FontWeight.w400,
        ),
      );

      textPainter.layout();
      
      // Position lines in different columns to avoid content overlap
      final column = (i ~/ 7) % 3; // 3 columns
      final x = size.width * (0.05 + column * 0.32);
      final y = startY + (i % 7) * lineHeight + (i ~/ 21) * (size.height * 0.25);
      
      if (y < size.height - 100 && x + textPainter.width < size.width * 0.95) {
        textPainter.paint(canvas, Offset(x, y));
      }
    }

    // Blinking cursor effect
    if (visibleLines < terminalLines.length) {
      final cursorOpacity = (math.sin(animationValue * 4 * math.pi) + 1) / 2;
      final cursorPaint = Paint()
        ..color = color.withValues(alpha: cursorOpacity * 0.8)
        ..style = PaintingStyle.fill;

      final lastLineIndex = math.min(visibleLines, terminalLines.length - 1);
      final column = (lastLineIndex ~/ 7) % 3;
      final cursorX = size.width * (0.05 + column * 0.32) + 
          (terminalLines[lastLineIndex].length * 6.5);
      final cursorY = startY + (lastLineIndex % 7) * lineHeight + 
          (lastLineIndex ~/ 21) * (size.height * 0.25);
      
      if (cursorY < size.height - 100) {
        canvas.drawRect(
          Rect.fromLTWH(cursorX, cursorY, 7, 12),
          cursorPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
