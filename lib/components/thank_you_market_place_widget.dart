import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'thank_you_market_place_model.dart';
export 'thank_you_market_place_model.dart';

class ThankYouMarketPlaceWidget extends StatefulWidget {
  const ThankYouMarketPlaceWidget({super.key});

  @override
  State<ThankYouMarketPlaceWidget> createState() =>
      _ThankYouMarketPlaceWidgetState();
}

class _ThankYouMarketPlaceWidgetState extends State<ThankYouMarketPlaceWidget> {
  late ThankYouMarketPlaceModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ThankYouMarketPlaceModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.86,
        constraints: const BoxConstraints(maxWidth: 360),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 24.0,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Glowing checkmark badge
              Container(
                width: 76.0,
                height: 76.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF10D4A0), Color(0xFF059669)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10D4A0).withOpacity(0.35),
                      blurRadius: 20.0,
                      spreadRadius: 2.0,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 42.0,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // Title
              Text(
                'Listing Submitted! 🎉',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1E293B),
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 10.0),

              // Subtitle
              Text(
                'Your marketplace item has been submitted and is currently being verified. It will appear live shortly!',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18.0),

              // Status Chip
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: const Color(0xFFFDE68A),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      color: Color(0xFFD97706),
                      size: 15.0,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      'Status: Under Review',
                      style: GoogleFonts.inter(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFD97706),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22.0),

              // Bottom subtle indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 14.0,
                    height: 14.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE66A4E)),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    'Redirecting to My Listings...',
                    style: GoogleFonts.inter(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
