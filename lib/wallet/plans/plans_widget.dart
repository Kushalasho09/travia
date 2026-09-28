import 'dart:ui';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/razorpay/razorpay_service.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
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
  late RazorpayService _razorpayService;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedPlan = 0; // Default to ₹29 Day Pass
  bool _isPurchasing = false;

  static const List<_PlanItem> _plans = [
    _PlanItem(
      id: '24_hour_pass',
      tierLevel: 1,
      label: '24-Hour Day Pass',
      duration: '24 Hours VIP Access',
      durationValue: Duration(hours: 24),
      price: '₹29',
      priceInt: 29,
      perMonth: '5 Rides • 5 Parcel Posts',
      savings: null,
      badge: 'HOT IMPULSE PASS',
      ridesLimit: 5,
      marketplaceLimit: 5,
      bgColor: Color(0xFFFFF5ED),
      borderColor: Color(0xFFFED7AA),
      accentColor: Color(0xFFEE7B4D),
      icon: Icons.flash_on_rounded,
    ),
    _PlanItem(
      id: 'monthly_pass',
      tierLevel: 2,
      label: '1-Month Frequent Pass',
      duration: '30 Days Access',
      durationValue: Duration(days: 30),
      price: '₹199',
      priceInt: 199,
      perMonth: 'UNLIMITED Rides • 15 Parcel Posts',
      savings: 'Commuter Choice',
      badge: 'MOST POPULAR',
      ridesLimit: -1,
      marketplaceLimit: 15,
      bgColor: Color(0xFFF0ECFD),
      borderColor: Color(0xFFE2DBFC),
      accentColor: Color(0xFF6C7EE8),
      icon: Icons.workspace_premium_rounded,
    ),
    _PlanItem(
      id: 'vip_3m',
      tierLevel: 3,
      label: '3-Month VIP Pass',
      duration: '90 Days VIP Access',
      durationValue: Duration(days: 90),
      price: '₹499',
      priceInt: 499,
      perMonth: 'UNLIMITED Rides • UNLIMITED Parcels',
      savings: 'Save 40%',
      badge: 'BEST VALUE',
      ridesLimit: -1,
      marketplaceLimit: -1,
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
    _razorpayService = RazorpayService();
    _razorpayService.initialize(
      onSuccess: _handlePaymentSuccess,
      onError: _handlePaymentError,
      onExternalWallet: _handleExternalWallet,
    );
  }

  @override
  void dispose() {
    _razorpayService.dispose();
    _model.dispose();
    super.dispose();
  }

  void _handlePurchase() {
    if (_isPurchasing) return;

    final userRecord = currentUserDocument;
    final bool isSubscribed = userRecord?.isSubscriptionActive ?? false;
    final String activeTier = userRecord?.subscriptionTier ?? '';

    // If user already has an active subscription, purchasing another plan is locked until expiry
    if (isSubscribed) {
      final activePlan = _plans.firstWhere(
        (p) => p.id == activeTier,
        orElse: () => _plans[0],
      );
      _showPassLockedNoticeDialog(activePlanLabel: activePlan.label);
      return;
    }

    setState(() => _isPurchasing = true);

    final blueprintPlan = kTraviaBlueprintPlans[_selectedPlan];

    final bool opened = _razorpayService.openCheckout(
      plan: blueprintPlan,
      userPhone: currentPhoneNumber,
      userEmail: currentUserEmail,
      userName: currentUserDisplayName,
    );

    if (!opened) {
      setState(() => _isPurchasing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Unable to open payment gateway. Please try again.'),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Security check: Payment ID must be non-empty and valid
    if (response.paymentId == null || response.paymentId!.trim().isEmpty) {
      debugPrint('Payment ID is empty or invalid.');
      if (mounted) {
        setState(() => _isPurchasing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Payment verification failed. Invalid payment ID.'),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }

    final selected = _plans[_selectedPlan];
    final now = DateTime.now();

    // When activating or upgrading, calculate new expiry from now
    final expiryDate = now.add(selected.durationValue);

    try {
      if (currentUserReference != null) {
        await currentUserReference!.set({
          'is_premium': true,
          'isPremium': true,
          'isVerifed': true,
          'subscription_tier': selected.id,
          'subscription_status': 'active',
          'subscription_started_at': Timestamp.fromDate(now),
          'subscription_expires_at': Timestamp.fromDate(expiryDate),
          'rides_limit': selected.ridesLimit,
          'marketplace_limit': selected.marketplaceLimit,
          'rides_used_in_period': 0,
          'marketplace_used_in_period': 0,
          'notified_expiring_soon': false,
          'payment_provider': 'razorpay',
          'last_payment_id': response.paymentId,
        }, SetOptions(merge: true));

        // Save transaction history
        await FirebaseFirestore.instance.collection('subscriptions_history').add({
          'user_ref': currentUserReference,
          'user_uid': currentUserUid,
          'plan_id': selected.id,
          'amount_inr': selected.priceInt,
          'rides_limit': selected.ridesLimit,
          'marketplace_limit': selected.marketplaceLimit,
          'payment_id': response.paymentId,
          'order_id': response.orderId ?? '',
          'status': 'success',
          'created_at': FieldValue.serverTimestamp(),
          'expires_at': Timestamp.fromDate(expiryDate),
        });
      }

      if (!mounted) return;
      setState(() {});
      await _showSuccessDialog();
    } catch (e) {
      debugPrint('Error updating user subscription: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error activating plan: $e'),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isPurchasing = false);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if (mounted) {
      setState(() => _isPurchasing = false);
      final errorMsg = response.message ?? 'Payment was cancelled or failed.';
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFFDC2626),
          duration: const Duration(seconds: 4),
          content: Row(
            children: [
              const Icon(Icons.error_outline_rounded, color: Colors.white, size: 20.0),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Payment Cancelled / Failed: $errorMsg\nNo charges were deducted and no plan was activated.',
                  style: GoogleFonts.inter(fontSize: 12.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (mounted) {
      setState(() => _isPurchasing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Redirected to ${response.walletName ?? "external wallet"}'),
        ),
      );
    }
  }

  Future<void> _showSuccessDialog() async {
    final selected = _plans[_selectedPlan];
    final navigator = Navigator.of(context);
    await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.65),
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x35000000),
                    blurRadius: 36.0,
                    offset: Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close Icon at top-right
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () => Navigator.of(ctx).pop(),
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F5F9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close_rounded, size: 18.0, color: Color(0xFF64748B)),
                      ),
                    ),
                  ),

                  // Floating Hero Stage with Ambient Halo & Shimmering Stars
                  SizedBox(
                    height: 160.0,
                    width: 160.0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Pulsing Radial Ambient Glow Aura
                        Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                const Color(0xFF10D4A0).withValues(alpha: 0.35),
                                const Color(0xFF10D4A0).withValues(alpha: 0.0),
                              ],
                            ),
                          ),
                        )
                            .animate(onPlay: (c) => c.repeat(reverse: true))
                            .scale(begin: const Offset(0.85, 0.85), end: const Offset(1.22, 1.22), duration: 2000.ms, curve: Curves.easeInOut),

                        // Orbiting Shimmering Particle Stars
                        Positioned(
                          top: 10,
                          left: 12,
                          child: const Icon(Icons.auto_awesome, color: Color(0xFF10D4A0), size: 22.0)
                              .animate(onPlay: (c) => c.repeat(reverse: true))
                              .scale(begin: const Offset(0.7, 0.7), end: const Offset(1.3, 1.3), duration: 1400.ms)
                              .rotate(begin: -0.1, end: 0.1),
                        ),
                        Positioned(
                          bottom: 12,
                          right: 14,
                          child: const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 24.0)
                              .animate(onPlay: (c) => c.repeat(reverse: true))
                              .scale(begin: const Offset(1.25, 1.25), end: const Offset(0.65, 0.65), duration: 1700.ms),
                        ),

                        // Floating AI Generated 3D VIP Card
                        Container(
                          width: 130.0,
                          height: 130.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0FDF4),
                            borderRadius: BorderRadius.circular(26.0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF10D4A0).withValues(alpha: 0.25),
                                blurRadius: 20.0,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22.0),
                            child: Image.asset(
                              'assets/images/plan_activated.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.check_circle_rounded,
                                color: Color(0xFF10D4A0),
                                size: 54.0,
                              ),
                            ),
                          ),
                        )
                            .animate(onPlay: (c) => c.repeat(reverse: true))
                            .moveY(begin: -6.0, end: 6.0, duration: 2200.ms, curve: Curves.easeInOut)
                            .animate()
                            .scale(begin: const Offset(0.4, 0.4), end: const Offset(1.0, 1.0), curve: Curves.elasticOut, duration: 750.ms),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  // Pulsing VIP Active Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: const Color(0xFF86EFAC)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Live breathing indicator dot
                        Container(
                          width: 8.0,
                          height: 8.0,
                          decoration: const BoxDecoration(
                            color: Color(0xFF16A34A),
                            shape: BoxShape.circle,
                          ),
                        )
                            .animate(onPlay: (c) => c.repeat(reverse: true))
                            .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.4, 1.4), duration: 800.ms),
                        const SizedBox(width: 6.0),
                        Text(
                          'VIP PASS ACTIVATED',
                          style: GoogleFonts.inter(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            color: const Color(0xFF15803D),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fade(delay: 100.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 10.0),

                  // Headline
                  Text(
                    'Welcome to Travia VIP! 🎉',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ).animate().fade(delay: 150.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 4.0),
                  Text(
                    '${selected.label} is now live on your profile!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ).animate().fade(delay: 200.ms).slideY(begin: 0.15, end: 0),
                  const SizedBox(height: 16.0),

                  // Staggered Unlocked Benefits Strip
                  _buildAnimatedBenefitRow(
                    icon: Icons.phone_forwarded_rounded,
                    title: 'Direct Driver Calls',
                    subtitle: 'Call drivers instantly without any gate',
                    delayMs: 220,
                    iconColor: const Color(0xFF10D4A0),
                    bgColor: const Color(0xFFF0FDF4),
                  ),
                  const SizedBox(height: 8.0),
                  _buildAnimatedBenefitRow(
                    icon: Icons.directions_car_rounded,
                    title: 'Instant Ride Privileges',
                    subtitle: 'Priority ride booking and publishing',
                    delayMs: 340,
                    iconColor: const Color(0xFF3B82F6),
                    bgColor: const Color(0xFFEFF6FF),
                  ),
                  const SizedBox(height: 8.0),
                  _buildAnimatedBenefitRow(
                    icon: Icons.local_shipping_rounded,
                    title: 'Parcel Marketplace Access',
                    subtitle: 'Send and bid on verified parcels',
                    delayMs: 460,
                    iconColor: const Color(0xFFF59E0B),
                    bgColor: const Color(0xFFFFFBEB),
                  ),
                  const SizedBox(height: 20.0),

                  // Shimmering High-Conversion CTA Button
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFEE7B4D), Color(0xFFF97316)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFEE7B4D).withValues(alpha: 0.4),
                            blurRadius: 18.0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          if (mounted) navigator.pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Start Exploring Travia',
                              style: GoogleFonts.inter(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18.0),
                          ],
                        ),
                      ),
                    )
                        .animate(onPlay: (c) => c.repeat())
                        .shimmer(duration: 2200.ms, color: Colors.white.withValues(alpha: 0.35)),
                  ).animate().fade(delay: 500.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1.0, 1.0)),
                ],
              ),
            ),
          ).animate().fade(duration: 250.ms).scale(begin: const Offset(0.75, 0.75), curve: Curves.easeOutBack, duration: 420.ms),
        );
      },
    );
  }

  Future<void> _showExpiringSoonDialog({
    required String planTitle,
    required String timeLeft,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.65),
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x35000000),
                    blurRadius: 36.0,
                    offset: Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close Icon at top-right
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () => Navigator.of(ctx).pop(),
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F5F9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close_rounded, size: 18.0, color: Color(0xFF64748B)),
                      ),
                    ),
                  ),

                  // Floating Hero Stage with Ambient Amber Aura
                  SizedBox(
                    height: 160.0,
                    width: 160.0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Pulsing Amber Aura
                        Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                const Color(0xFFF59E0B).withValues(alpha: 0.35),
                                const Color(0xFFF59E0B).withValues(alpha: 0.0),
                              ],
                            ),
                          ),
                        )
                            .animate(onPlay: (c) => c.repeat(reverse: true))
                            .scale(begin: const Offset(0.85, 0.85), end: const Offset(1.22, 1.22), duration: 2000.ms, curve: Curves.easeInOut),

                        // Shimmering Golden Stars
                        Positioned(
                          top: 10,
                          right: 12,
                          child: const Icon(Icons.auto_awesome, color: Color(0xFFF59E0B), size: 22.0)
                              .animate(onPlay: (c) => c.repeat(reverse: true))
                              .scale(begin: const Offset(0.7, 0.7), end: const Offset(1.3, 1.3), duration: 1400.ms),
                        ),
                        Positioned(
                          bottom: 12,
                          left: 14,
                          child: const Icon(Icons.hourglass_top_rounded, color: Color(0xFFD97706), size: 20.0)
                              .animate(onPlay: (c) => c.repeat(reverse: true))
                              .rotate(begin: -0.15, end: 0.15, duration: 1600.ms),
                        ),

                        // Floating AI Generated 3D Glowing Hourglass
                        Container(
                          width: 130.0,
                          height: 130.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFBEB),
                            borderRadius: BorderRadius.circular(26.0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFF59E0B).withValues(alpha: 0.25),
                                blurRadius: 20.0,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22.0),
                            child: Image.asset(
                              'assets/images/plan_expiring.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.timer_outlined,
                                color: Color(0xFFD97706),
                                size: 54.0,
                              ),
                            ),
                          ),
                        )
                            .animate(onPlay: (c) => c.repeat(reverse: true))
                            .moveY(begin: -6.0, end: 6.0, duration: 2200.ms, curve: Curves.easeInOut)
                            .animate()
                            .scale(begin: const Offset(0.4, 0.4), end: const Offset(1.0, 1.0), curve: Curves.elasticOut, duration: 750.ms),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  // Urgent Status Badge with live pulsing timer icon
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: const Color(0xFFFDE68A)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.timer_outlined, color: Color(0xFFD97706), size: 14.0)
                            .animate(onPlay: (c) => c.repeat(reverse: true))
                            .scale(begin: const Offset(0.85, 0.85), end: const Offset(1.25, 1.25), duration: 700.ms),
                        const SizedBox(width: 6.0),
                        Text(
                          'EXPIRES IN $timeLeft'.toUpperCase(),
                          style: GoogleFonts.inter(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            color: const Color(0xFFB45309),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fade(delay: 100.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 10.0),

                  // Headline
                  Text(
                    'Pass Expiring Soon! ⏳',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ).animate().fade(delay: 150.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 4.0),
                  Text(
                    'Your $planTitle will expire in $timeLeft.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ).animate().fade(delay: 200.ms).slideY(begin: 0.15, end: 0),
                  const SizedBox(height: 14.0),

                  // Countdown Warning Card with Animated Progress Indicator
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBEB),
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(color: const Color(0xFFFED7AA)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded, color: Color(0xFFD97706), size: 18.0),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                'Direct driver calling will pause upon expiry',
                                style: GoogleFonts.inter(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF92400E),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: const LinearProgressIndicator(
                            value: 0.25,
                            minHeight: 6.0,
                            backgroundColor: Color(0xFFFED7AA),
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEE7B4D)),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fade(delay: 250.ms).slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 20.0),

                  // Shimmer CTA Button
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFEE7B4D), Color(0xFFF97316)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFEE7B4D).withValues(alpha: 0.4),
                            blurRadius: 18.0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Renew Ahead of Expiry',
                              style: GoogleFonts.inter(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            const Icon(Icons.bolt_rounded, color: Colors.white, size: 18.0),
                          ],
                        ),
                      ),
                    )
                        .animate(onPlay: (c) => c.repeat())
                        .shimmer(duration: 2200.ms, color: Colors.white.withValues(alpha: 0.35)),
                  ).animate().fade(delay: 350.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1.0, 1.0)),
                  const SizedBox(height: 6.0),
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text(
                      'Remind Me Later',
                      style: GoogleFonts.inter(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fade(duration: 250.ms).scale(begin: const Offset(0.75, 0.75), curve: Curves.easeOutBack, duration: 420.ms),
        );
      },
    );
  }

  Future<void> _showExpiredDialog({required String planTitle}) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.65),
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x35000000),
                    blurRadius: 36.0,
                    offset: Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close Icon at top-right
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () => Navigator.of(ctx).pop(),
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F5F9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close_rounded, size: 18.0, color: Color(0xFF64748B)),
                      ),
                    ),
                  ),

                  // Floating Hero Stage with Ambient Crimson Halo
                  SizedBox(
                    height: 160.0,
                    width: 160.0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Pulsing Crimson Aura
                        Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                const Color(0xFFEF4444).withValues(alpha: 0.35),
                                const Color(0xFFEF4444).withValues(alpha: 0.0),
                              ],
                            ),
                          ),
                        )
                            .animate(onPlay: (c) => c.repeat(reverse: true))
                            .scale(begin: const Offset(0.85, 0.85), end: const Offset(1.22, 1.22), duration: 2000.ms, curve: Curves.easeInOut),

                        // Floating warning particles
                        Positioned(
                          top: 10,
                          left: 12,
                          child: const Icon(Icons.lock_rounded, color: Color(0xFFDC2626), size: 20.0)
                              .animate(onPlay: (c) => c.repeat(reverse: true))
                              .rotate(begin: -0.1, end: 0.1, duration: 1500.ms),
                        ),
                        Positioned(
                          bottom: 12,
                          right: 14,
                          child: const Icon(Icons.hourglass_bottom_rounded, color: Color(0xFFEF4444), size: 22.0)
                              .animate(onPlay: (c) => c.repeat(reverse: true))
                              .scale(begin: const Offset(1.2, 1.2), end: const Offset(0.7, 0.7), duration: 1600.ms),
                        ),

                        // Floating AI Generated 3D Locked Membership Card
                        Container(
                          width: 130.0,
                          height: 130.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF2F2),
                            borderRadius: BorderRadius.circular(26.0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFDC2626).withValues(alpha: 0.25),
                                blurRadius: 20.0,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22.0),
                            child: Image.asset(
                              'assets/images/plan_expired.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.lock_clock_rounded,
                                color: Color(0xFFDC2626),
                                size: 54.0,
                              ),
                            ),
                          ),
                        )
                            .animate(onPlay: (c) => c.repeat(reverse: true))
                            .moveY(begin: -6.0, end: 6.0, duration: 2200.ms, curve: Curves.easeInOut)
                            .animate()
                            .scale(begin: const Offset(0.4, 0.4), end: const Offset(1.0, 1.0), curve: Curves.elasticOut, duration: 750.ms),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  // Expired Status Badge with pulsating lock
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: const Color(0xFFFECACA)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.lock_rounded, color: Color(0xFFDC2626), size: 14.0)
                            .animate(onPlay: (c) => c.repeat(reverse: true))
                            .scale(begin: const Offset(0.85, 0.85), end: const Offset(1.25, 1.25), duration: 700.ms),
                        const SizedBox(width: 6.0),
                        Text(
                          'MEMBERSHIP PAUSED',
                          style: GoogleFonts.inter(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            color: const Color(0xFFB91C1C),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fade(delay: 100.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 10.0),

                  // Headline
                  Text(
                    'Your Pass Has Expired! ⚠️',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ).animate().fade(delay: 150.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 4.0),
                  Text(
                    'Your $planTitle has reached its expiration.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ).animate().fade(delay: 200.ms).slideY(begin: 0.15, end: 0),
                  const SizedBox(height: 14.0),

                  // Paused Privileges Notice Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(color: const Color(0xFFFECACA)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFEE2E2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.refresh_rounded, color: Color(0xFFDC2626), size: 18.0),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Text(
                            'Select any pass below to restore direct driver calls & instant bookings immediately.',
                            style: GoogleFonts.inter(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF991B1B),
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fade(delay: 250.ms).slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 20.0),

                  // Shimmer CTA Button
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFEE7B4D), Color(0xFFF97316)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFEE7B4D).withValues(alpha: 0.4),
                            blurRadius: 18.0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Choose a Pass to Reactivate',
                              style: GoogleFonts.inter(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18.0),
                          ],
                        ),
                      ),
                    )
                        .animate(onPlay: (c) => c.repeat())
                        .shimmer(duration: 2200.ms, color: Colors.white.withValues(alpha: 0.35)),
                  ).animate().fade(delay: 350.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1.0, 1.0)),
                ],
              ),
            ),
          ).animate().fade(duration: 250.ms).scale(begin: const Offset(0.75, 0.75), curve: Curves.easeOutBack, duration: 420.ms),
        );
      },
    );
  }

  Future<void> _showPassLockedNoticeDialog({required String activePlanLabel}) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.65),
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x35000000),
                    blurRadius: 32.0,
                    offset: Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 68.0,
                    height: 68.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF5ED),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.lock_clock_rounded,
                        color: Color(0xFFEE7B4D),
                        size: 34.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Pass Currently Active',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Your $activePlanLabel is active right now. Other passes will unlock automatically once your current pass completes.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    height: 46.0,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEE7B4D),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      child: Text(
                        'Got It',
                        style: GoogleFonts.inter(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fade(duration: 200.ms).scale(begin: const Offset(0.85, 0.85), end: const Offset(1.0, 1.0), curve: Curves.easeOutBack),
        );
      },
    );
  }

  Widget _buildAnimatedBenefitRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required int delayMs,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: iconColor, size: 16.0),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle_rounded, color: Color(0xFF10D4A0), size: 16.0),
        ],
      ),
    ).animate().fade(delay: delayMs.ms).slideX(begin: -0.1, end: 0, duration: 300.ms);
  }

  void _showTestingBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(22.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '🧪 Subscription Test Console',
                      style: GoogleFonts.inter(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 22.0),
                      onPressed: () => Navigator.of(ctx).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Tap any state below to instantly preview dialogs or simulate database states:',
                  style: GoogleFonts.inter(fontSize: 12.0, color: const Color(0xFF64748B)),
                ),
                const SizedBox(height: 16.0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(color: Color(0xFFEBF9F5), shape: BoxShape.circle),
                    child: const Icon(Icons.check_circle_rounded, color: Color(0xFF10D4A0), size: 20.0),
                  ),
                  title: Text('1. Preview "Plan Activated" Dialog', style: GoogleFonts.inter(fontSize: 13.5, fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _showSuccessDialog();
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(color: Color(0xFFFEF3C7), shape: BoxShape.circle),
                    child: const Icon(Icons.timer_outlined, color: Color(0xFFD97706), size: 20.0),
                  ),
                  title: Text('2. Preview "Plan Expiring Soon" Dialog', style: GoogleFonts.inter(fontSize: 13.5, fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _showExpiringSoonDialog(
                      planTitle: '24-Hour Day Pass',
                      timeLeft: '2 hours 15 mins',
                    );
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(color: Color(0xFFFEE2E2), shape: BoxShape.circle),
                    child: const Icon(Icons.hourglass_bottom_rounded, color: Color(0xFFDC2626), size: 20.0),
                  ),
                  title: Text('3. Preview "Plan Expired" Dialog', style: GoogleFonts.inter(fontSize: 13.5, fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _showExpiredDialog(planTitle: '24-Hour Day Pass');
                  },
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(color: Color(0xFFFFF5ED), shape: BoxShape.circle),
                    child: const Icon(Icons.cloud_sync_outlined, color: Color(0xFFEE7B4D), size: 20.0),
                  ),
                  title: Text('4. Set Firestore: Expiring in 2 Hours', style: GoogleFonts.inter(fontSize: 13.5, fontWeight: FontWeight.w600)),
                  subtitle: Text('Simulates real active pass expiring in 2h in Firebase', style: GoogleFonts.inter(fontSize: 11.0, color: const Color(0xFF64748B))),
                  onTap: () async {
                    Navigator.of(ctx).pop();
                    if (currentUserReference != null) {
                      await currentUserReference!.set({
                        'is_premium': true,
                        'isPremium': true,
                        'subscription_tier': '24_hour_pass',
                        'subscription_status': 'active',
                        'subscription_expires_at': Timestamp.fromDate(
                          DateTime.now().add(const Duration(hours: 2)),
                        ),
                      }, SetOptions(merge: true));
                      if (mounted) {
                        _showExpiringSoonDialog(
                          planTitle: '24-Hour Day Pass',
                          timeLeft: '2 hours',
                        );
                      }
                    }
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(color: Color(0xFFFEE2E2), shape: BoxShape.circle),
                    child: const Icon(Icons.history_toggle_off_rounded, color: Colors.red, size: 20.0),
                  ),
                  title: Text('5. Set Firestore: Expired 2 Hours Ago', style: GoogleFonts.inter(fontSize: 13.5, fontWeight: FontWeight.w600)),
                  subtitle: Text('Simulates real expired pass in Firebase', style: GoogleFonts.inter(fontSize: 11.0, color: const Color(0xFF64748B))),
                  onTap: () async {
                    Navigator.of(ctx).pop();
                    if (currentUserReference != null) {
                      await currentUserReference!.set({
                        'is_premium': false,
                        'isPremium': false,
                        'subscription_tier': '24_hour_pass',
                        'subscription_status': 'expired',
                        'subscription_expires_at': Timestamp.fromDate(
                          DateTime.now().subtract(const Duration(hours: 2)),
                        ),
                      }, SetOptions(merge: true));
                      if (mounted) {
                        _showExpiredDialog(planTitle: '24-Hour Day Pass');
                      }
                    }
                  },
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
    return StreamBuilder<UsersRecord>(
      stream: currentUserReference != null
          ? UsersRecord.getDocument(currentUserReference!)
          : const Stream.empty(),
      initialData: currentUserDocument,
      builder: (context, snapshot) {
        final userRecord = snapshot.data ?? currentUserDocument;
        final bool isSubscribed = userRecord?.isSubscriptionActive ?? false;
        final String activeTier = userRecord?.subscriptionTier ?? '';
        final activePlan = _plans.firstWhere(
          (p) => p.id == activeTier,
          orElse: () => _plans.first,
        );

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
                      GestureDetector(
                        onTap: () {},
                        onLongPress: kDebugMode ? _showTestingBottomSheet : null,
                        child: Container(
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
                                isSubscribed ? 'VIP Active' : 'Travia VIP',
                                style: GoogleFonts.inter(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFEE7B4D),
                                ),
                              ),
                            ],
                          ),
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

                        // Hero Banner Section (Exact Original UI)
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

                        // Plan Selection Cards
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _plans.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 14.0),
                          itemBuilder: (context, index) {
                            final plan = _plans[index];
                            final isThisPlanActive = isSubscribed && plan.id == activeTier;
                            final isPlanDisabled = isSubscribed && !isThisPlanActive;
                            final isSelected = _selectedPlan == index;

                            return _buildPlanCard(
                              plan: plan,
                              isSelected: isSelected,
                              isThisPlanActive: isThisPlanActive,
                              isPlanDisabled: isPlanDisabled,
                              onTap: () {
                                if (isPlanDisabled) {
                                  _showPassLockedNoticeDialog(activePlanLabel: activePlan.label);
                                  return;
                                }
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
                        gradient: LinearGradient(
                          colors: isSubscribed
                              ? [const Color(0xFF10D4A0), const Color(0xFF059669)]
                              : [const Color(0xFFEE7B4D), const Color(0xFFF26835)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: isSubscribed
                                ? const Color(0x3310D4A0)
                                : const Color(0x33EE7B4D),
                            blurRadius: 12.0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: (_isPurchasing || isSubscribed) ? null : _handlePurchase,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          disabledBackgroundColor: Colors.transparent,
                          disabledForegroundColor: Colors.white,
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
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      isSubscribed
                                          ? 'Plan Active • VIP Access'
                                          : 'Activate ${selected.label} — ${selected.price}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Icon(
                                    isSubscribed
                                        ? Icons.check_circle_rounded
                                        : Icons.arrow_forward_rounded,
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
      },
    );
  }

  Widget _buildPlanCard({
    required _PlanItem plan,
    required bool isSelected,
    required bool isThisPlanActive,
    required bool isPlanDisabled,
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
            color: isPlanDisabled ? const Color(0xFFF8FAFC) : plan.bgColor,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: isThisPlanActive
                  ? const Color(0xFF10D4A0)
                  : (isSelected ? plan.accentColor : plan.borderColor),
              width: (isThisPlanActive || isSelected) ? 2.0 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: isThisPlanActive
                    ? const Color(0x2210D4A0)
                    : (isSelected
                        ? plan.accentColor.withValues(alpha: 0.14)
                        : const Color(0x06000000)),
                blurRadius: isSelected ? 18.0 : 10.0,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Opacity(
            opacity: isPlanDisabled ? 0.6 : 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Ribbon for badges
                if (isThisPlanActive || isPlanDisabled || plan.badge != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (isThisPlanActive)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10D4A0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              '✓ ACTIVE PLAN',
                              style: GoogleFonts.inter(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 0.4,
                              ),
                            ),
                          )
                        else if (isPlanDisabled)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF94A3B8),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              '🔒 UNLOCKS AFTER ACTIVE PASS',
                              style: GoogleFonts.inter(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.3,
                              ),
                            ),
                          )
                        else if (plan.badge != null)
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

                        if (plan.savings != null && !isPlanDisabled)
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
                          color: isPlanDisabled ? const Color(0xFF94A3B8) : plan.accentColor,
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
                              color: isPlanDisabled ? const Color(0xFF94A3B8) : plan.accentColor,
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
                            color: isThisPlanActive
                                ? const Color(0xFF10D4A0)
                                : (isSelected && !isPlanDisabled ? plan.accentColor : Colors.white),
                            border: Border.all(
                              color: isThisPlanActive
                                  ? const Color(0xFF10D4A0)
                                  : (isSelected && !isPlanDisabled
                                      ? plan.accentColor
                                      : const Color(0xFFCBD5E1)),
                              width: 1.5,
                            ),
                          ),
                          child: (isThisPlanActive || (isSelected && !isPlanDisabled))
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
      ),
    );
  }
}

class _PlanItem {
  const _PlanItem({
    required this.id,
    required this.tierLevel,
    required this.label,
    required this.duration,
    required this.durationValue,
    required this.price,
    required this.priceInt,
    required this.perMonth,
    required this.savings,
    required this.badge,
    required this.ridesLimit,
    required this.marketplaceLimit,
    required this.bgColor,
    required this.borderColor,
    required this.accentColor,
    required this.icon,
  });

  final String id;
  final int tierLevel;
  final String label;
  final String duration;
  final Duration durationValue;
  final String price;
  final int priceInt;
  final String perMonth;
  final String? savings;
  final String? badge;
  final int ridesLimit;
  final int marketplaceLimit;
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
