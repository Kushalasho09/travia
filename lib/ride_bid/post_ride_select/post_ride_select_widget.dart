import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'post_ride_select_model.dart';
export 'post_ride_select_model.dart';

class PostRideSelectWidget extends StatefulWidget {
  const PostRideSelectWidget({super.key});

  static String routeName = 'PostRideSelect';
  static String routePath = '/postRideSelect';

  @override
  State<PostRideSelectWidget> createState() => _PostRideSelectWidgetState();
}

class _PostRideSelectWidgetState extends State<PostRideSelectWidget> {
  late PostRideSelectModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostRideSelectModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header / Travia Logo
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                  child: Image.asset(
                    'assets/images/logoTraviaJi.png',
                    height: 52.0,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Text(
                        'Travia',
                        style: GoogleFonts.outfit(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2C3550),
                        ),
                      );
                    },
                  ),
                ).animate().fade(duration: 400.ms).slideY(begin: -0.1, end: 0),
                const SizedBox(height: 10.0),

                // Top Hero Section (Banner & Illustration)
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Text & Description
                        Expanded(
                          flex: 12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Travel ',
                                      style: GoogleFonts.inter(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF111827),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Smarter.',
                                      style: GoogleFonts.inter(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFFEE7B4D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Connect ',
                                      style: GoogleFonts.inter(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF111827),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Better',
                                      style: GoogleFonts.inter(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFFEE7B4D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12.0),
                              Text(
                                'Carry Items, Send Packages\nCarpool or Bikepool-or find\nwhat you need with trusted\ntravellers',
                                style: GoogleFonts.inter(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF4B5563),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ).animate().fade(delay: 100.ms, duration: 500.ms).slideX(begin: -0.05, end: 0),
                        const SizedBox(width: 8.0),
                        // Right Illustration with gentle floating loop animation
                        Expanded(
                          flex: 11,
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Image.asset(
                              'assets/images/hero_carpool_illustration.png',
                              fit: BoxFit.contain,
                              height: 160.0,
                            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                             .moveY(begin: -6.0, end: 6.0, duration: 2400.ms, curve: Curves.easeInOut),
                          ),
                        ),
                      ],
                    ),
                    // Floating Badge with bounce-in animation
                    Positioned(
                      right: 10.0,
                      bottom: -16.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14.0,
                          vertical: 7.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 12.0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFF0E9),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_circle_rounded,
                                color: Color(0xFFEE7B4D),
                                size: 16.0,
                              ),
                            ),
                            const SizedBox(width: 6.0),
                            Text(
                              'Safe • Verified • Reliable',
                              style: GoogleFonts.inter(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1F2937),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fade(delay: 250.ms, duration: 500.ms).scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0), curve: Curves.easeOutBack),
                  ],
                ),

                const SizedBox(height: 50.0),

                // Section Title with fade & scale
                Center(
                  child: Text(
                    'What are you looking for today?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111827),
                    ),
                  ),
                ).animate().fade(delay: 300.ms, duration: 500.ms).scale(begin: const Offset(0.95, 0.95), end: const Offset(1.0, 1.0)),

                const SizedBox(height: 24.0),

                // Post Daily Rides Card with entrance animation & shadow
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      context.pushNamed(RideLocation1Widget.routeName);
                    },
                    borderRadius: BorderRadius.circular(24.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0ECFD),
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(
                          color: const Color(0xFFE2DBFC),
                          width: 1.0,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0C5F46E8),
                            blurRadius: 16.0,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x1A000000),
                                  blurRadius: 8.0,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/daily_rides_icon.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ).animate(onPlay: (c) => c.repeat(reverse: true))
                           .scale(begin: const Offset(0.97, 0.97), end: const Offset(1.03, 1.03), duration: 2000.ms, curve: Curves.easeInOut),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Post Daily Rides',
                                  style: GoogleFonts.inter(
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF2C3550),
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Find or offer ride\nand earn on your journey',
                                  style: GoogleFonts.inter(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF6E7891),
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 44.0,
                            height: 44.0,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x10000000),
                                  blurRadius: 6.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xFFEE7B4D),
                              size: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ).animate().fade(delay: 350.ms, duration: 600.ms).slideY(begin: 0.15, end: 0, curve: Curves.easeOutCubic),

                const SizedBox(height: 18.0),

                // Post Marketplace Card with entrance animation & shadow
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      context.pushNamed(MarketRideWidget.routeName);
                    },
                    borderRadius: BorderRadius.circular(24.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF7F2),
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(
                          color: const Color(0xFFD6EFE1),
                          width: 1.0,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0C10B981),
                            blurRadius: 16.0,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x1A000000),
                                  blurRadius: 8.0,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/marketplace_icon.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ).animate(onPlay: (c) => c.repeat(reverse: true))
                           .scale(begin: const Offset(0.97, 0.97), end: const Offset(1.03, 1.03), duration: 2000.ms, curve: Curves.easeInOut),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Post Marketplace',
                                  style: GoogleFonts.inter(
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF2C3550),
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Find or offer ride\nand earn on your journey',
                                  style: GoogleFonts.inter(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF6E7891),
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 44.0,
                            height: 44.0,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x10000000),
                                  blurRadius: 6.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xFF10B981),
                              size: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ).animate().fade(delay: 450.ms, duration: 600.ms).slideY(begin: 0.15, end: 0, curve: Curves.easeOutCubic),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


