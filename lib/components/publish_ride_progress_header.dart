import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class PublishRideProgressHeader extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String title;
  final String subtitle;
  final String? badgeText;

  const PublishRideProgressHeader({
    super.key,
    required this.currentStep,
    this.totalSteps = 8,
    required this.title,
    required this.subtitle,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (currentStep / totalSteps).clamp(0.0, 1.0);
    final String stepBadge = badgeText ?? 'STEP $currentStep OF $totalSteps';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step pill badge & Percentage row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0ECFD),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: const Color(0xFFE2DBFC),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.0,
                      height: 6.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFF6C4DF6),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      stepBadge,
                      style: GoogleFonts.inter(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF6C4DF6),
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${(progress * 100).round()}% Completed',
                style: GoogleFonts.inter(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10.0),

          // Sleek Linear Progress Bar
          Container(
            width: double.infinity,
            height: 6.0,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFEE7B4D),
                      Color(0xFFF59E0B),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33EE7B4D),
                      blurRadius: 4.0,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16.0),

          // Title
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF111827),
              letterSpacing: -0.4,
            ),
          ),

          const SizedBox(height: 4.0),

          // Subtitle
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 13.5,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6B7280),
              height: 1.35,
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 350.ms).slideY(begin: -0.05, end: 0);
  }
}
