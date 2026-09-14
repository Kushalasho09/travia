import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'no_ride_to_show_user_model.dart';
export 'no_ride_to_show_user_model.dart';

class NoRideToShowUserWidget extends StatefulWidget {
  final Function(DateTime)? onDateChanged;
  final String? title;
  final String? description;
  final String? imageAsset;

  const NoRideToShowUserWidget({
    super.key,
    this.onDateChanged,
    this.title,
    this.description,
    this.imageAsset,
  });

  @override
  State<NoRideToShowUserWidget> createState() => _NoRideToShowUserWidgetState();
}

class _NoRideToShowUserWidgetState extends State<NoRideToShowUserWidget> {
  late NoRideToShowUserModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoRideToShowUserModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleText = widget.title ?? 'No Listings Available';
    final descText = widget.description ??
        'Sorry! There are currently no listings available for your selected location or date.';
    final assetPath = widget.imageAsset ?? 'assets/images/daily_rides_icon.png';

    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 28.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: const Color(0xFFEAECEF),
            width: 1.0,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 20.0,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 3D Illustration Container with float animation
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Soft background glow ring
                Container(
                  width: 128.0,
                  height: 128.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3ED),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFFE0D1),
                      width: 1.5,
                    ),
                  ),
                ),
                // Main Circular 3D Artwork
                Container(
                  width: 114.0,
                  height: 114.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x18000000),
                        blurRadius: 14.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      assetPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFFFF0E9),
                          child: const Center(
                            child: Icon(
                              Icons.directions_car_filled_rounded,
                              color: Color(0xFFEE7B4D),
                              size: 48.0,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                 .moveY(begin: -4.0, end: 4.0, duration: 2200.ms, curve: Curves.easeInOut),

                // Decorative floating badge
                Positioned(
                  bottom: -4.0,
                  right: -2.0,
                  child: Container(
                    padding: const EdgeInsets.all(7.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEE7B4D),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.5,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x28EE7B4D),
                          blurRadius: 8.0,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.search_off_rounded,
                      color: Colors.white,
                      size: 16.0,
                    ),
                  ),
                ).animate().scale(delay: 200.ms, duration: 400.ms, curve: Curves.easeOutBack),
              ],
            ),

            const SizedBox(height: 22.0),

            // Title
            Text(
              titleText,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 19.0,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF111827),
                letterSpacing: -0.2,
              ),
            ),

            const SizedBox(height: 8.0),

            // Subtitle / Description
            Text(
              descText,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6B7280),
                height: 1.4,
              ),
            ),

            const SizedBox(height: 24.0),

            // Primary Button: Change Date
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 7)),
                    lastDate: DateTime.now().add(const Duration(days: 60)),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xFFEE7B4D),
                            onPrimary: Colors.white,
                            onSurface: Color(0xFF111827),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {
                    final normalizedDate = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                      0,
                      0,
                      0,
                    );

                    widget.onDateChanged?.call(normalizedDate);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('📅 Date set to ${dateTimeFormat("dd MMM yyyy", normalizedDate)}'),
                          backgroundColor: const Color(0xFF2C3550),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                  }
                },
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  width: double.infinity,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEE7B4D),
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33EE7B4D),
                        blurRadius: 10.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.white,
                        size: 18.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Change Date',
                        style: GoogleFonts.inter(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10.0),

            // Secondary Button: Try Again / Refresh
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  final currentDate = DateTime.now();
                  final normalizedToday = DateTime(
                    currentDate.year,
                    currentDate.month,
                    currentDate.day,
                    0,
                    0,
                    0,
                  );

                  widget.onDateChanged?.call(normalizedToday);

                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('🔄 Searching rides for today...'),
                        backgroundColor: const Color(0xFF10B981),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  width: double.infinity,
                  height: 46.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF6EE),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: const Color(0xFFFFD9C2),
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.refresh_rounded,
                        color: Color(0xFFEE7B4D),
                        size: 18.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Search Today\'s Rides',
                        style: GoogleFonts.inter(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFEE7B4D),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fade(duration: 400.ms).scale(begin: const Offset(0.95, 0.95), end: const Offset(1.0, 1.0), curve: Curves.easeOutCubic);
  }
}
