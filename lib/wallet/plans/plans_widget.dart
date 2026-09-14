import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'plans_model.dart';
export 'plans_model.dart';

class PlansWidget extends StatefulWidget {
  const PlansWidget({super.key});

  static String routeName = 'Plans';
  static String routePath = '/plans';

  @override
  State<PlansWidget> createState() => _PlansWidgetState();
}

class _PlansWidgetState extends State<PlansWidget> {
  late PlansModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedPlan = 1; // Default to 3 Months (Most Popular)
  bool _isPurchasing = false;

  static const List<_PlanItem> _plans = [
    _PlanItem(
      label: '1 Month Pass',
      duration: '30 Days VIP Access',
      price: '₹299',
      priceInt: 299,
      perMonth: '₹299 / month',
      savings: null,
      badge: null,
      bgColor: Color(0xFFF0ECFD),
      borderColor: Color(0xFFE2DBFC),
      accentColor: Color(0xFF6C7EE8),
      icon: Icons.rocket_launch_rounded,
    ),
    _PlanItem(
      label: '3 Months Pass',
      duration: '90 Days VIP Access',
      price: '₹749',
      priceInt: 749,
      perMonth: '₹250 / month',
      savings: 'Save 16%',
      badge: 'MOST POPULAR',
      bgColor: Color(0xFFFFF5ED),
      borderColor: Color(0xFFFED7AA),
      accentColor: Color(0xFFEE7B4D),
      icon: Icons.workspace_premium_rounded,
    ),
    _PlanItem(
      label: '12 Months Pass',
      duration: '365 Days VIP Access',
      price: '₹2,399',
      priceInt: 2399,
      perMonth: '₹200 / month',
      savings: 'Save 33%',
      badge: 'BEST VALUE',
      bgColor: Color(0xFFEBF9F5),
      borderColor: Color(0xFFB9F0E1),
      accentColor: Color(0xFF10D4A0),
      icon: Icons.diamond_rounded,
    ),
  ];

  static const List<_FeatureItem> _features = [
    _FeatureItem(
      icon: Icons.verified_rounded,
      color: Color(0xFF10D4A0),
      bgColor: Color(0xFFEBF9F5),
      title: 'Verified Profile Badge',
      description: 'Stand out with an official trust tick on your profile',
    ),
    _FeatureItem(
      icon: Icons.directions_car_rounded,
      color: Color(0xFFEE7B4D),
      bgColor: Color(0xFFFFF5ED),
      title: 'Unlimited Ride Bookings',
      description: 'Book and offer rides anytime with zero platform caps',
    ),
    _FeatureItem(
      icon: Icons.storefront_rounded,
      color: Color(0xFF6C7EE8),
      bgColor: Color(0xFFF0ECFD),
      title: 'Full Marketplace Access',
      description: 'Send parcels and discover trusted luggage shares',
    ),
    _FeatureItem(
      icon: Icons.phone_in_talk_rounded,
      color: Color(0xFF3B82F6),
      bgColor: Color(0xFFEFF6FF),
      title: 'Direct Driver Calls',
      description: 'Instant secure calling without exchanging private numbers',
    ),
    _FeatureItem(
      icon: Icons.shield_rounded,
      color: Color(0xFFF59E0B),
      bgColor: Color(0xFFFEF3C7),
      title: 'Zero Cancellation Fees',
      description: 'Flexible travel changes with no sudden penalties',
    ),
    _FeatureItem(
      icon: Icons.support_agent_rounded,
      color: Color(0xFFEC4899),
      bgColor: Color(0xFFFDF2F8),
      title: 'Priority 24/7 Support',
      description: 'Fast-track assistance from our dedicated team',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlansModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _handlePurchase() async {
    if (_isPurchasing) return;
    setState(() => _isPurchasing = true);
    try {
      await Future.delayed(const Duration(milliseconds: 1200));
      if (currentUserReference != null) {
        await currentUserReference!.update({
          'is_premium': true,
          'isPremium': true,
          'isVerifed': true,
        });
      }
      if (!mounted) return;
      await _showSuccessDialog();
    } catch (e) {
      debugPrint('Purchase error: $e');
    } finally {
      if (mounted) setState(() => _isPurchasing = false);
    }
  }

  Future<void> _showSuccessDialog() async {
    final selected = _plans[_selectedPlan];
    final navigator = Navigator.of(context);
    await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      builder: (ctx) {
        Future.delayed(const Duration(milliseconds: 2500), () {
          if (ctx.mounted) Navigator.of(ctx).pop();
          if (mounted) navigator.pop();
        });
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            padding: const EdgeInsets.all(28.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28.0),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 24.0,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72.0,
                  height: 72.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEBF9F5),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF10D4A0),
                      size: 46.0,
                    ),
                  ),
                ).animate().scale(begin: const Offset(0.5, 0.5), end: const Offset(1.0, 1.0), curve: Curves.elasticOut),
                const SizedBox(height: 18.0),
                Text(
                  'Welcome to Travia Club! 🎉',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '${selected.label} activated successfully.\nEnjoy all your premium VIP benefits!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13.5,
                    color: const Color(0xFF64748B),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selected = _plans[_selectedPlan];

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            // Top App Bar / Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => context.safePop(),
                      borderRadius: BorderRadius.circular(14.0),
                      child: Container(
                        width: 42.0,
                        height: 42.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFF1E293B),
                          size: 20.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        'assets/images/logoTraviaJi.png',
                        height: 28.0,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Text(
                            'Travia',
                            style: GoogleFonts.outfit(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2C3550),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF5ED),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: const Color(0xFFFED7AA)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.workspace_premium_rounded, color: Color(0xFFEE7B4D), size: 14.0),
                        const SizedBox(width: 4.0),
                        Text(
                          'Travia VIP',
                          style: GoogleFonts.inter(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFEE7B4D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fade(duration: 350.ms).slideY(begin: -0.1, end: 0),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),

                    // Hero Banner Section (styled like postRideSelect)
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Headline & Copy
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
                                          text: 'Limitless.',
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
                                          text: 'Join ',
                                          style: GoogleFonts.inter(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF111827),
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Travia Club.',
                                          style: GoogleFonts.inter(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFFEE7B4D),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    'Verified profile badge, unlimited ride bookings, marketplace access & direct connections.',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF4B5563),
                                      height: 1.45,
                                    ),
                                  ),
                                ],
                              ),
                            ).animate().fade(delay: 100.ms, duration: 400.ms).slideX(begin: -0.05, end: 0),
                            const SizedBox(width: 8.0),

                            // Right Illustration with gentle floating loop animation
                            Expanded(
                              flex: 11,
                              child: Container(
                                alignment: Alignment.topRight,
                                child: Image.asset(
                                  'assets/images/hero_carpool_illustration.png',
                                  fit: BoxFit.contain,
                                  height: 150.0,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 130.0,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFFF5ED),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.workspace_premium_rounded,
                                          color: Color(0xFFEE7B4D),
                                          size: 64.0,
                                        ),
                                      ),
                                    );
                                  },
                                ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                                 .moveY(begin: -5.0, end: 5.0, duration: 2400.ms, curve: Curves.easeInOut),
                              ),
                            ),
                          ],
                        ),

                        // Floating Pill Badge
                        Positioned(
                          left: 0.0,
                          bottom: -14.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x14000000),
                                  blurRadius: 10.0,
                                  offset: Offset(0, 3),
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
                                    size: 14.0,
                                  ),
                                ),
                                const SizedBox(width: 6.0),
                                Text(
                                  'Safe • 100% Verified • VIP Support',
                                  style: GoogleFonts.inter(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1F2937),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).animate().fade(delay: 200.ms, duration: 400.ms).scale(begin: const Offset(0.85, 0.85), end: const Offset(1.0, 1.0), curve: Curves.easeOutBack),
                      ],
                    ),

                    const SizedBox(height: 42.0),

                    // Section Title
                    Text(
                      'Choose Your Travia Pass',
                      style: GoogleFonts.inter(
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ).animate().fade(delay: 250.ms, duration: 350.ms),
                    const SizedBox(height: 4.0),
                    Text(
                      'Select the plan that fits your travel routine best',
                      style: GoogleFonts.inter(
                        fontSize: 12.5,
                        color: const Color(0xFF64748B),
                      ),
                    ).animate().fade(delay: 280.ms, duration: 350.ms),

                    const SizedBox(height: 18.0),

                    // Plan Selection Cards (styled like postRideSelect cards)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _plans.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14.0),
                      itemBuilder: (context, index) {
                        final plan = _plans[index];
                        final isSelected = _selectedPlan == index;

                        return _buildPlanCard(
                          plan: plan,
                          isSelected: isSelected,
                          onTap: () {
                            setState(() => _selectedPlan = index);
                          },
                        ).animate().fade(delay: (300 + index * 80).ms, duration: 400.ms).slideY(begin: 0.08, end: 0);
                      },
                    ),

                    const SizedBox(height: 32.0),

                    // Features Section
                    Text(
                      'Everything Included in VIP',
                      style: GoogleFonts.inter(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ).animate().fade(delay: 500.ms, duration: 350.ms),
                    const SizedBox(height: 4.0),
                    Text(
                      'Active across all plans with no hidden charges',
                      style: GoogleFonts.inter(
                        fontSize: 12.5,
                        color: const Color(0xFF64748B),
                      ),
                    ).animate().fade(delay: 520.ms, duration: 350.ms),

                    const SizedBox(height: 16.0),

                    // Features List
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _features.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10.0),
                      itemBuilder: (context, index) {
                        final feat = _features[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: feat.bgColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(feat.icon, color: feat.color, size: 20.0),
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      feat.title,
                                      style: GoogleFonts.inter(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF1E293B),
                                      ),
                                    ),
                                    const SizedBox(height: 2.0),
                                    Text(
                                      feat.description,
                                      style: GoogleFonts.inter(
                                        fontSize: 11.5,
                                        color: const Color(0xFF64748B),
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ).animate().fade(delay: (550 + index * 40).ms, duration: 350.ms);
                      },
                    ),

                    const SizedBox(height: 120.0), // Padding for floating CTA
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Floating Bottom CTA
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 16.0,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 52.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEE7B4D), Color(0xFFF26835)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33EE7B4D),
                        blurRadius: 12.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _isPurchasing ? null : _handlePurchase,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: _isPurchasing
                        ? const SizedBox(
                            width: 22.0,
                            height: 22.0,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Activate ${selected.label} — ${selected.price}',
                                style: GoogleFonts.inter(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 18.0,
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_outline_rounded, size: 13.0, color: Color(0xFF94A3B8)),
                  const SizedBox(width: 5.0),
                  Text(
                    'Cancel anytime • Instant activation • 100% Secure',
                    style: GoogleFonts.inter(
                      fontSize: 11.0,
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

  Widget _buildPlanCard({
    required _PlanItem plan,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: double.infinity,
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: plan.bgColor,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: isSelected ? plan.accentColor : plan.borderColor,
              width: isSelected ? 2.0 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected ? plan.accentColor.withValues(alpha: 0.14) : const Color(0x06000000),
                blurRadius: isSelected ? 18.0 : 10.0,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Ribbon for badges like MOST POPULAR / BEST VALUE
              if (plan.badge != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: plan.accentColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          plan.badge!,
                          style: GoogleFonts.inter(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                      if (plan.savings != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: plan.accentColor.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            plan.savings!,
                            style: GoogleFonts.inter(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: plan.accentColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

              // Main Row
              Row(
                children: [
                  // Circular Icon Container (like postRideSelect)
                  Container(
                    width: 54.0,
                    height: 54.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 8.0,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        plan.icon,
                        color: plan.accentColor,
                        size: 26.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14.0),

                  // Plan Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan.label,
                          style: GoogleFonts.inter(
                            fontSize: 16.5,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          plan.duration,
                          style: GoogleFonts.inter(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          plan.perMonth,
                          style: GoogleFonts.inter(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: plan.accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Pricing & Radio Selection
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        plan.price,
                        style: GoogleFonts.inter(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        width: 22.0,
                        height: 22.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? plan.accentColor : Colors.white,
                          border: Border.all(
                            color: isSelected ? plan.accentColor : const Color(0xFFCBD5E1),
                            width: 1.5,
                          ),
                        ),
                        child: isSelected
                            ? const Center(
                                child: Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 14.0,
                                ),
                              )
                            : null,
                      ),
                    ],
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

class _PlanItem {
  const _PlanItem({
    required this.label,
    required this.duration,
    required this.price,
    required this.priceInt,
    required this.perMonth,
    required this.savings,
    required this.badge,
    required this.bgColor,
    required this.borderColor,
    required this.accentColor,
    required this.icon,
  });

  final String label;
  final String duration;
  final String price;
  final int priceInt;
  final String perMonth;
  final String? savings;
  final String? badge;
  final Color bgColor;
  final Color borderColor;
  final Color accentColor;
  final IconData icon;
}

class _FeatureItem {
  const _FeatureItem({
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final Color color;
  final Color bgColor;
  final String title;
  final String description;
}
