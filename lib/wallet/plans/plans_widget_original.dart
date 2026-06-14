import 'dart:math' as math;
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'plans_model.dart';
export 'plans_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PlansWidget  – Premium "Go Premium" Subscription Screen
//                with rich layered animations
//
// Animations:
//   • Staggered slide-up + fade-in  (entry)
//   • Floating crown icon           (float loop)
//   • Pulsing glow ring             (selected card pulse)
//   • Animated button shimmer sweep (idle loop)
//   • Twinkling starfield           (noise shimmer)
//   • Rising ambient particles      (particle loop)
// ─────────────────────────────────────────────────────────────────────────────

class PlansWidget extends StatefulWidget {
  const PlansWidget({super.key});

  static String routeName = 'Plans';
  static String routePath = '/plans';

  @override
  State<PlansWidget> createState() => _PlansWidgetState();
}

class _PlansWidgetState extends State<PlansWidget>
    with TickerProviderStateMixin {
  late PlansModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // ── Animation controllers ─────────────────────────────────────────────────
  late AnimationController _entryController;    // staggered slide-in
  late AnimationController _floatController;    // crown float
  late AnimationController _pulseController;    // card glow pulse
  late AnimationController _shimmerController;  // starfield + button shimmer
  late AnimationController _particleController; // rising particles

  // ── Entry animations (staggered) ──────────────────────────────────────────
  late Animation<double> _heroFade;
  late Animation<Offset> _heroSlide;
  late Animation<double> _cardsFade;
  late Animation<Offset> _cardsSlide;
  late Animation<double> _featuresFade;
  late Animation<Offset> _featuresSlide;

  int _selectedPlan = 1;
  bool _isPurchasing = false;

  // ── Static data ───────────────────────────────────────────────────────────

  static final List<_Star> _stars = List.generate(60, (i) {
    final rng = math.Random(i * 7 + 3);
    return _Star(
      x: rng.nextDouble(),
      y: rng.nextDouble(),
      r: rng.nextDouble() * 1.8 + 0.4,
      opacity: rng.nextDouble() * 0.6 + 0.2,
    );
  });

  static final List<_Particle> _particles = List.generate(18, (i) {
    final rng = math.Random(i * 13 + 7);
    return _Particle(
      x: rng.nextDouble(),
      startY: 0.6 + rng.nextDouble() * 0.4,
      speed: 0.12 + rng.nextDouble() * 0.2,
      r: rng.nextDouble() * 3.0 + 1.0,
      opacity: rng.nextDouble() * 0.35 + 0.05,
      phase: rng.nextDouble(),
    );
  });

  static const List<_PlanData> _plans = [
    _PlanData(
      label: '1 Month',
      duration: '30 days',
      price: '₹299',
      perMonth: '₹299 / mo',
      savings: null,
      badge: null,
      accentColor: Color(0xFF6C7EE8),
    ),
    _PlanData(
      label: '3 Months',
      duration: '90 days',
      price: '₹749',
      perMonth: '₹250 / mo',
      savings: 'Save 16%',
      badge: 'POPULAR',
      accentColor: Color(0xFFFF7A2F),
    ),
    _PlanData(
      label: '12 Months',
      duration: '365 days',
      price: '₹2,399',
      perMonth: '₹200 / mo',
      savings: 'Save 33%',
      badge: 'BEST VALUE',
      accentColor: Color(0xFF10D4A0),
    ),
  ];

  static const List<_Feature> _features = [
    _Feature(Icons.verified_rounded, 'Verified Profile Badge',
        'Stand out with a premium verification tick'),
    _Feature(Icons.directions_car_rounded, 'Unlimited Ride Bookings',
        'Book rides with no restrictions, anytime'),
    _Feature(Icons.storefront_rounded, 'Marketplace Access',
        'Buy & sell with fellow travellers'),
    _Feature(Icons.call_rounded, 'Direct Driver Calls',
        'Connect instantly without sharing numbers'),
    _Feature(Icons.block_rounded, 'Ad-Free Experience',
        'Enjoy Travia with zero interruptions'),
    _Feature(Icons.support_agent_rounded, 'Priority Support',
        'Get help faster with dedicated support'),
  ];

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlansModel());
    _initAnimations();
    _entryController.forward();
  }

  void _initAnimations() {
    // 1. Entry – staggered slide-up fade
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _heroFade = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );
    _heroSlide = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
    ));

    _cardsFade = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.25, 0.7, curve: Curves.easeOut),
    );
    _cardsSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.25, 0.72, curve: Curves.easeOut),
    ));

    _featuresFade = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.50, 1.0, curve: Curves.easeOut),
    );
    _featuresSlide = Tween<Offset>(
      begin: const Offset(0, 0.22),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.50, 1.0, curve: Curves.easeOut),
    ));

    // 2. Float – crown gently bobs up and down
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    // 3. Pulse – selected card glow breathes
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    // 4. Shimmer – starfield twinkle + button sweep
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // 5. Particles – continuous upward drift
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _entryController.dispose();
    _floatController.dispose();
    _pulseController.dispose();
    _shimmerController.dispose();
    _particleController.dispose();
    _model.dispose();
    super.dispose();
  }

  // ── Purchase handler ──────────────────────────────────────────────────────

  Future<void> _handlePurchase() async {
    if (_isPurchasing) return;
    setState(() => _isPurchasing = true);
    try {
      await Future.delayed(const Duration(milliseconds: 1400));
      if (currentUserReference != null) {
        await currentUserReference!
            .update(createUsersRecordData(isVerifed: true));
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
    final plan = _plans[_selectedPlan];
    final navigator = Navigator.of(context);
    await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (ctx) {
        Future.delayed(const Duration(seconds: 3), () {
          if (ctx.mounted) Navigator.of(ctx).pop();
          if (mounted) navigator.pop();
        });
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0D1B2A), Color(0xFF1A2E44)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF10D4A0), Color(0xFF00B887)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color(0xFF10D4A0).withValues(alpha: 0.45),
                        blurRadius: 28,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.check_rounded,
                      color: Colors.white, size: 40),
                ),
                const SizedBox(height: 20),
                Text(
                  "You're Premium! 🎉",
                  style: GoogleFonts.interTight(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${plan.label} plan activated.\nEnjoy the full Travia experience!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.65),
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF0D1B2A),
      body: Stack(
        children: [
          // Layer 1: Animated starfield
          AnimatedBuilder(
            animation: _shimmerController,
            builder: (_, __) => LayoutBuilder(
              builder: (ctx, constraints) => CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: _StarfieldPainter(_stars, _shimmerController.value),
              ),
            ),
          ),

          // Layer 2: Rising particles
          AnimatedBuilder(
            animation: _particleController,
            builder: (_, __) => LayoutBuilder(
              builder: (ctx, constraints) => CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: _ParticlePainter(
                    _particles, _particleController.value),
              ),
            ),
          ),

          // Layer 3: Ambient glow orbs
          _buildGlowOrbs(),

          // Layer 4: Main content
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 140),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Hero – staggered fade+slide
                        FadeTransition(
                          opacity: _heroFade,
                          child: SlideTransition(
                            position: _heroSlide,
                            child: _buildHero(context),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Plan cards
                        FadeTransition(
                          opacity: _cardsFade,
                          child: SlideTransition(
                            position: _cardsSlide,
                            child: _buildPlanSelector(context),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Features
                        FadeTransition(
                          opacity: _featuresFade,
                          child: SlideTransition(
                            position: _featuresSlide,
                            child: _buildFeaturesList(context),
                          ),
                        ),

                        const SizedBox(height: 16),

                        FadeTransition(
                          opacity: _featuresFade,
                          child: _buildFooterNote(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Layer 5: Floating CTA
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomCTA(context),
          ),
        ],
      ),
    );
  }

  // ── Glow orbs ─────────────────────────────────────────────────────────────

  Widget _buildGlowOrbs() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (_, __) {
        final pulse = _pulseController.value;
        return Stack(children: [
          Positioned(
            top: -80,
            left: -80,
            child: Opacity(
              opacity: 0.8 + pulse * 0.2,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF39D2C0)
                          .withValues(alpha: 0.14 + pulse * 0.06),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -60,
            child: Opacity(
              opacity: 0.7 + pulse * 0.3,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFFF7A2F)
                          .withValues(alpha: 0.10 + pulse * 0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]);
      },
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          InkWell(
            onTap: () => context.pop(),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.12), width: 1),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 16, color: Colors.white),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.12), width: 1),
            ),
            child: Row(
              children: [
                const Icon(Icons.lock_rounded,
                    size: 12, color: Color(0xFF39D2C0)),
                const SizedBox(width: 5),
                Text(
                  'Secure Checkout',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Hero with floating crown ───────────────────────────────────────────────

  Widget _buildHero(BuildContext context) {
    return Column(
      children: [
        // Floating crown – bobs up/down
        AnimatedBuilder(
          animation: _floatController,
          builder: (_, child) {
            final offset = Tween<double>(begin: -6.0, end: 6.0)
                .evaluate(CurvedAnimation(
                    parent: _floatController, curve: Curves.easeInOut));
            return Transform.translate(
              offset: Offset(0, offset),
              child: child,
            );
          },
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (_, child) {
              final glow = 0.35 + _pulseController.value * 0.25;
              final spread = 2.0 + _pulseController.value * 6.0;
              return Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF7A2F), Color(0xFFEE8B60)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF7A2F).withValues(alpha: glow),
                      blurRadius: 32 + spread,
                      spreadRadius: spread,
                    ),
                  ],
                ),
                child: const Icon(Icons.workspace_premium_rounded,
                    color: Colors.white, size: 42),
              );
            },
          ),
        ),

        const SizedBox(height: 18),

        // Animated shimmer on title
        _ShimmerText(
          text: 'Go Premium',
          shimmerController: _shimmerController,
          baseStyle: GoogleFonts.interTight(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),

        const SizedBox(height: 8),
        Text(
          'Unlock the full Travia experience.\nRide more, explore more, save more.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.55),
            height: 1.55,
          ),
        ),
      ],
    );
  }

  // ── Plan selector ─────────────────────────────────────────────────────────

  Widget _buildPlanSelector(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 210,
          child: PageView.builder(
            controller: _model.pageViewController ??=
                PageController(initialPage: 1, viewportFraction: 0.72),
            itemCount: _plans.length,
            onPageChanged: (i) => safeSetState(() => _selectedPlan = i),
            itemBuilder: (context, i) => _buildPlanCard(context, i),
          ),
        ),
        const SizedBox(height: 18),

        // Animated dot indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _plans.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _selectedPlan == i ? 28 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: _selectedPlan == i
                    ? _plans[i].accentColor
                    : Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Selected plan summary
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) => FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(0, 0.15), end: Offset.zero)
                    .animate(anim),
                child: child,
              ),
            ),
            child: _buildSelectedPlanSummary(
                context,
                key: ValueKey(_selectedPlan)),
          ),
        ),
      ],
    );
  }

  Widget _buildPlanCard(BuildContext context, int index) {
    final plan = _plans[index];
    final isSelected = _selectedPlan == index;

    return GestureDetector(
      onTap: () {
        _model.pageViewController?.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
        setState(() => _selectedPlan = index);
      },
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (_, child) {
          final pulse = _pulseController.value;
          final extraBlur = isSelected ? pulse * 14.0 : 0.0;
          final extraSpread = isSelected ? pulse * 3.0 : 0.0;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            margin: EdgeInsets.symmetric(
                horizontal: 8, vertical: isSelected ? 2 : 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: isSelected
                    ? [
                        plan.accentColor.withValues(alpha: 0.28),
                        plan.accentColor.withValues(alpha: 0.10),
                      ]
                    : [
                        const Color(0xFF1E3A5F).withValues(alpha: 0.6),
                        const Color(0xFF0D2035).withValues(alpha: 0.6),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: isSelected
                    ? plan.accentColor
                    : Colors.white.withValues(alpha: 0.10),
                width: isSelected ? 2.0 : 1.0,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color:
                            plan.accentColor.withValues(alpha: 0.25 + pulse * 0.15),
                        blurRadius: 24 + extraBlur,
                        spreadRadius: extraSpread,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [],
            ),
            child: child,
          );
        },
        child: Stack(children: [
          if (plan.badge != null)
            Positioned(
              top: 14,
              right: 14,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      plan.accentColor,
                      plan.accentColor.withValues(alpha: 0.7)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  plan.badge!,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.label,
                  style: GoogleFonts.interTight(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
                Text(
                  plan.duration,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.40),
                  ),
                ),
                const Spacer(),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: GoogleFonts.interTight(
                    fontSize: isSelected ? 38 : 34,
                    fontWeight: FontWeight.w800,
                    color: isSelected ? plan.accentColor : Colors.white,
                    height: 1,
                  ),
                  child: Text(plan.price),
                ),
                const SizedBox(height: 4),
                Text(
                  plan.perMonth,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: isSelected
                        ? plan.accentColor.withValues(alpha: 0.8)
                        : Colors.white.withValues(alpha: 0.40),
                  ),
                ),
                if (plan.savings != null) ...[
                  const SizedBox(height: 6),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isSelected ? 1.0 : 0.6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: plan.accentColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        plan.savings!,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: plan.accentColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildSelectedPlanSummary(BuildContext context, {Key? key}) {
    final plan = _plans[_selectedPlan];
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: plan.accentColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: plan.accentColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline_rounded,
              color: plan.accentColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'You selected: ${plan.label} – ${plan.price}',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.white.withValues(alpha: 0.85),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (plan.savings != null)
            Text(
              plan.savings!,
              style: GoogleFonts.interTight(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: plan.accentColor,
              ),
            ),
        ],
      ),
    );
  }

  // ── Features list ─────────────────────────────────────────────────────────

  Widget _buildFeaturesList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What's Included",
            style: GoogleFonts.interTight(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(_features.length, (i) {
            final f = _features[i];
            // Staggered feature rows
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: _entryController,
                curve: Interval(
                  0.45 + i * 0.06,
                  math.min(0.45 + i * 0.06 + 0.35, 1.0),
                  curve: Curves.easeOut,
                ),
              ),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.15, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _entryController,
                  curve: Interval(
                    0.45 + i * 0.06,
                    math.min(0.45 + i * 0.06 + 0.35, 1.0),
                    curve: Curves.easeOut,
                  ),
                )),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10D4A0)
                              .withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(f.icon,
                            color: const Color(0xFF10D4A0), size: 18),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              f.title,
                              style: GoogleFonts.interTight(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              f.subtitle,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color:
                                    Colors.white.withValues(alpha: 0.45),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ── Footer ────────────────────────────────────────────────────────────────

  Widget _buildFooterNote(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        '🔒  Cancel anytime · No hidden charges · Secure payment',
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: 12,
          color: Colors.white.withValues(alpha: 0.35),
          height: 1.5,
        ),
      ),
    );
  }

  // ── Bottom CTA with shimmer sweep ─────────────────────────────────────────

  Widget _buildBottomCTA(BuildContext context) {
    final plan = _plans[_selectedPlan];

    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20,
          MediaQuery.of(context).padding.bottom + 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF0D1B2A).withValues(alpha: 0),
            const Color(0xFF0D1B2A).withValues(alpha: 0.97),
            const Color(0xFF0D1B2A),
          ],
          stops: const [0, 0.35, 1],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _isPurchasing ? null : _handlePurchase,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: double.infinity,
              height: 58,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _isPurchasing
                      ? [
                          Colors.white.withValues(alpha: 0.08),
                          Colors.white.withValues(alpha: 0.08),
                        ]
                      : [plan.accentColor, plan.accentColor.withValues(alpha: 0.7)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: _isPurchasing
                    ? []
                    : [
                        BoxShadow(
                          color: plan.accentColor.withValues(alpha: 0.45),
                          blurRadius: 24,
                          offset: const Offset(0, 6),
                        ),
                      ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  children: [
                    // Shimmer sweep on the button
                    if (!_isPurchasing)
                      AnimatedBuilder(
                        animation: _shimmerController,
                        builder: (_, __) {
                          return Positioned.fill(
                            child: FractionallySizedBox(
                              alignment: Alignment(
                                -1.5 + _shimmerController.value * 3.5,
                                0,
                              ),
                              widthFactor: 0.35,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.white.withValues(alpha: 0.18),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    // Button label
                    Center(
                      child: _isPurchasing
                          ? const SpinKitThreeBounce(
                              color: Colors.white, size: 22)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                    Icons.workspace_premium_rounded,
                                    color: Colors.white,
                                    size: 20),
                                const SizedBox(width: 10),
                                Text(
                                  'Subscribe · ${plan.price}',
                                  style: GoogleFonts.interTight(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Starfield painter  (twinkling)
// ─────────────────────────────────────────────────────────────────────────────

class _StarfieldPainter extends CustomPainter {
  final List<_Star> stars;
  final double t;

  _StarfieldPainter(this.stars, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (final s in stars) {
      final flicker = (math.sin(t * math.pi * 2 + s.x * 10) + 1) / 2;
      paint.color =
          Colors.white.withValues(alpha: s.opacity * (0.45 + 0.55 * flicker));
      canvas.drawCircle(
          Offset(s.x * size.width, s.y * size.height), s.r, paint);
    }
  }

  @override
  bool shouldRepaint(_StarfieldPainter old) => old.t != t;
}

// ─────────────────────────────────────────────────────────────────────────────
// Rising particle painter
// ─────────────────────────────────────────────────────────────────────────────

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double t;

  _ParticlePainter(this.particles, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (final p in particles) {
      // Each particle rises at its own speed; loop with phase offset
      final progress = ((t * p.speed + p.phase) % 1.0);
      final y = (p.startY - progress * p.startY) * size.height;
      final x = p.x * size.width +
          math.sin(progress * math.pi * 4 + p.phase * 6) * 18;
      final opacity = p.opacity *
          (progress < 0.15
              ? progress / 0.15
              : progress > 0.75
                  ? (1.0 - progress) / 0.25
                  : 1.0);
      paint.color = Colors.white.withValues(alpha: opacity.clamp(0.0, 1.0));
      canvas.drawCircle(Offset(x, y), p.r, paint);
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.t != t;
}

// ─────────────────────────────────────────────────────────────────────────────
// Shimmer text widget
// ─────────────────────────────────────────────────────────────────────────────

class _ShimmerText extends StatelessWidget {
  final String text;
  final Animation<double> shimmerController;
  final TextStyle baseStyle;

  const _ShimmerText({
    required this.text,
    required this.shimmerController,
    required this.baseStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shimmerController,
      builder: (_, __) {
        final sweep = shimmerController.value;
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: const [
              Colors.white,
              Color(0xFFFFE0C8),
              Colors.white,
              Color(0xFFD0E8FF),
              Colors.white,
            ],
            stops: [
              0.0,
              (sweep - 0.15).clamp(0.0, 1.0),
              sweep.clamp(0.0, 1.0),
              (sweep + 0.15).clamp(0.0, 1.0),
              1.0,
            ],
          ).createShader(bounds),
          child: Text(text, style: baseStyle),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Data classes
// ─────────────────────────────────────────────────────────────────────────────

class _PlanData {
  final String label;
  final String duration;
  final String price;
  final String perMonth;
  final String? savings;
  final String? badge;
  final Color accentColor;

  const _PlanData({
    required this.label,
    required this.duration,
    required this.price,
    required this.perMonth,
    this.savings,
    this.badge,
    required this.accentColor,
  });
}

class _Star {
  final double x, y, r, opacity;
  const _Star(
      {required this.x,
      required this.y,
      required this.r,
      required this.opacity});
}

class _Particle {
  final double x, startY, speed, r, opacity, phase;
  const _Particle({
    required this.x,
    required this.startY,
    required this.speed,
    required this.r,
    required this.opacity,
    required this.phase,
  });
}

class _Feature {
  final IconData icon;
  final String title;
  final String subtitle;
  const _Feature(this.icon, this.title, this.subtitle);
}
