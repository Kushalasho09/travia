import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'sidebar_menu_model.dart';
export 'sidebar_menu_model.dart';

class SidebarMenuWidget extends StatefulWidget {
  const SidebarMenuWidget({super.key});

  @override
  State<SidebarMenuWidget> createState() => _SidebarMenuWidgetState();
}

class _SidebarMenuWidgetState extends State<SidebarMenuWidget> {
  late SidebarMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SidebarMenuModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  void _closeDrawerIfPossible() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _handleSignOut() async {
    final shouldSignOut = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(Icons.logout_rounded, color: Color(0xFFDC2626), size: 22.0),
            ),
            const SizedBox(width: 12.0),
            Text(
              'Sign Out',
              style: GoogleFonts.interTight(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to sign out of your Travia account?',
          style: GoogleFonts.inter(
            fontSize: 14.0,
            color: const Color(0xFF64748B),
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              'Sign Out',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );

    if (shouldSignOut == true && mounted) {
      GoRouter.of(context).prepareAuthEvent();
      await authManager.signOut();
      if (!mounted) return;
      GoRouter.of(context).clearRedirectLocation();
      context.goNamedAuth(PhoneNumberLoginWidget.routeName, context.mounted);
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0, top: 4.0),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
          color: const Color(0xFF94A3B8),
        ),
      ),
    );
  }

  Widget _buildSectionCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required Widget iconWidget,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailingBadge,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _closeDrawerIfPossible();
          onTap();
        },
        splashColor: const Color(0xFFE66A4E).withOpacity(0.08),
        highlightColor: const Color(0xFFE66A4E).withOpacity(0.04),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          child: Row(
            children: [
              // Icon Badge
              Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                alignment: Alignment.center,
                child: iconWidget,
              ),
              const SizedBox(width: 14.0),
              // Text column (Fully responsive, no truncated 180px fixed width)
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: GoogleFonts.interTight(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F172A),
                              letterSpacing: -0.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (trailingBadge != null) ...[
                          const SizedBox(width: 6.0),
                          trailingBadge,
                        ],
                      ],
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              // Chevron
              const Icon(
                Icons.chevron_right_rounded,
                size: 20.0,
                color: Color(0xFFCBD5E1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1.0,
      thickness: 1.0,
      indent: 68.0,
      endIndent: 14.0,
      color: Color(0xFFF1F5F9),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAFC),
      child: SingleChildScrollView(
        primary: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // MODERN HERO PROFILE HEADER
            // ==========================================
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: topInset + 16.0,
                bottom: 24.0,
                left: 20.0,
                right: 20.0,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0F172A),
                    Color(0xFF1E293B),
                    Color(0xFF1A1A2E),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 12.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Navigation Bar inside Header (Logo & Dismiss Button)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE66A4E).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: const Color(0xFFE66A4E).withOpacity(0.5),
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.near_me_rounded,
                                  color: Color(0xFFFF8A65),
                                  size: 13.0,
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  'TRAVIA',
                                  style: GoogleFonts.inter(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.2,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Close button
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),

                  // Avatar & User Info Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // User Avatar with Ring
                      GestureDetector(
                        onTap: () {
                          _closeDrawerIfPossible();
                          context.pushNamed(DriveProfileWidget.routeName);
                        },
                        child: Container(
                          width: 66.0,
                          height: 66.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFE66A4E),
                              width: 2.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFE66A4E).withOpacity(0.35),
                                blurRadius: 10.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(33.0),
                            child: currentUserPhoto.isNotEmpty
                                ? Image.network(
                                    currentUserPhoto,
                                    width: 66.0,
                                    height: 66.0,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Image.asset(
                                      'assets/images/userIconTravia.png',
                                      width: 66.0,
                                      height: 66.0,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image.asset(
                                    'assets/images/userIconTravia.png',
                                    width: 66.0,
                                    height: 66.0,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),

                      // User Name, Phone & Role Badge
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AuthUserStreamWidget(
                              builder: (context) {
                                final displayName = currentUserDisplayName.isNotEmpty
                                    ? currentUserDisplayName
                                    : 'Travia Traveler';
                                return Text(
                                  displayName,
                                  style: GoogleFonts.interTight(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: -0.3,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                );
                              },
                            ),
                            const SizedBox(height: 3.0),
                            AuthUserStreamWidget(
                              builder: (context) {
                                final contact = currentPhoneNumber.isNotEmpty
                                    ? currentPhoneNumber
                                    : (currentUserEmail.isNotEmpty
                                        ? currentUserEmail
                                        : 'Welcome to Travia');
                                return Text(
                                  contact,
                                  style: GoogleFonts.inter(
                                    fontSize: 13.0,
                                    color: const Color(0xFF94A3B8),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                );
                              },
                            ),
                            const SizedBox(height: 8.0),
                            // Role / Status Badge
                            AuthUserStreamWidget(
                              builder: (context) {
                                final role = valueOrDefault(currentUserDocument?.role, '').isNotEmpty
                                    ? currentUserDocument!.role
                                    : 'Member';
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.verified_user_rounded,
                                        color: Color(0xFF38BDF8),
                                        size: 12.0,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        role,
                                        style: GoogleFonts.inter(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFF1F5F9),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ==========================================
            // MENU ITEMS (GROUPED SECTIONS)
            // ==========================================
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- SECTION 1: RIDES & TRIPS ---
                  _buildSectionTitle('Rides & Journeys'),
                  _buildSectionCard(
                    children: [
                      _buildMenuItem(
                        iconWidget: const Icon(Icons.directions_car_rounded, color: Color(0xFF2563EB), size: 22.0),
                        iconBgColor: const Color(0xFFEFF6FF),
                        title: 'All Rides',
                        subtitle: 'Check and book rides matching your schedule',
                        onTap: () {
                          context.goNamed(
                            HomeWidget.routeName,
                            queryParameters: {
                              'tabNumberRef': serializeParam(0, ParamType.int),
                            }.withoutNulls,
                          );
                        },
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        iconWidget: const FaIcon(FontAwesomeIcons.carSide, color: Color(0xFF0D9488), size: 18.0),
                        iconBgColor: const Color(0xFFF0FDFA),
                        title: 'My Booking Requests',
                        subtitle: 'View active and upcoming ride bookings',
                        onTap: () {
                          context.pushNamed(
                            HomeWidget.routeName,
                            queryParameters: {
                              'tabNumberRef': serializeParam(1, ParamType.int),
                            }.withoutNulls,
                          );
                        },
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        iconWidget: const Icon(Icons.alt_route_rounded, color: Color(0xFFEA580C), size: 22.0),
                        iconBgColor: const Color(0xFFFFF7ED),
                        title: 'My Ride Listings',
                        subtitle: 'Manage offered rides and passenger requests',
                        onTap: () {
                          context.pushNamed(
                            HomeWidget.routeName,
                            queryParameters: {
                              'tabNumberRef': serializeParam(2, ParamType.int),
                            }.withoutNulls,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),

                  // --- SECTION 2: MARKETPLACE & PARCELS ---
                  _buildSectionTitle('Marketplace & Delivery'),
                  _buildSectionCard(
                    children: [
                      _buildMenuItem(
                        iconWidget: const Icon(Icons.storefront_rounded, color: Color(0xFF7C3AED), size: 22.0),
                        iconBgColor: const Color(0xFFF5F3FF),
                        title: 'Marketplace',
                        subtitle: 'Browse all products and deliveries listed',
                        onTap: () {
                          context.pushNamed(
                            MarketPlaceCustomerWidget.routeName,
                            queryParameters: {
                              'tabNumberRef': serializeParam(0, ParamType.int),
                            }.withoutNulls,
                          );
                        },
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        iconWidget: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF0284C7), size: 22.0),
                        iconBgColor: const Color(0xFFF0F9FF),
                        title: 'My Marketplace Bookings',
                        subtitle: 'View and manage all your parcel orders',
                        onTap: () {
                          context.pushNamed(
                            MarketPlaceCustomerWidget.routeName,
                            queryParameters: {
                              'tabNumberRef': serializeParam(1, ParamType.int),
                            }.withoutNulls,
                          );
                        },
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        iconWidget: const Icon(Icons.inventory_2_outlined, color: Color(0xFF9333EA), size: 22.0),
                        iconBgColor: const Color(0xFFFAF5FF),
                        title: 'My Marketplace Listings',
                        subtitle: 'View, update and manage your items easily',
                        onTap: () {
                          context.pushNamed(
                            MarketPlaceCustomerWidget.routeName,
                            queryParameters: {
                              'tabNumberRef': serializeParam(2, ParamType.int),
                            }.withoutNulls,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),

                  // --- SECTION 3: MEMBERSHIP & REWARDS ---
                  _buildSectionTitle('Privileges & Account'),
                  _buildSectionCard(
                    children: [
                      _buildMenuItem(
                        iconWidget: const Icon(Icons.workspace_premium_rounded, color: Color(0xFFE11D48), size: 22.0),
                        iconBgColor: const Color(0xFFFFF1F2),
                        title: 'Subscription',
                        subtitle: 'Manage your plan, perks & renewals',
                        trailingBadge: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF1F2),
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(color: const Color(0xFFFECDD3)),
                          ),
                          child: Text(
                            'PRO',
                            style: GoogleFonts.inter(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFE11D48),
                            ),
                          ),
                        ),
                        onTap: () {
                          context.pushNamed(PlansWidget.routeName);
                        },
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        iconWidget: const Icon(Icons.person_outline_rounded, color: Color(0xFF4F46E5), size: 22.0),
                        iconBgColor: const Color(0xFFEEF2FF),
                        title: 'Driver / User Profile',
                        subtitle: 'Edit details, vehicle & verifications',
                        onTap: () {
                          context.pushNamed(DriveProfileWidget.routeName);
                        },
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        iconWidget: const Icon(Icons.bookmark_border_rounded, color: Color(0xFF059669), size: 22.0),
                        iconBgColor: const Color(0xFFECFDF5),
                        title: 'Saved Rides',
                        subtitle: 'View your bookmarked and favorite routes',
                        onTap: () {
                          context.pushNamed(SavedRidesWidget.routeName);
                        },
                      ),
                      _buildDivider(),
                      Builder(
                        builder: (itemContext) => _buildMenuItem(
                          iconWidget: const Icon(Icons.card_giftcard_rounded, color: Color(0xFFD97706), size: 22.0),
                          iconBgColor: const Color(0xFFFEF3C7),
                          title: 'Refer & Earn',
                          subtitle: 'Earn ride points and redeem free benefits',
                          trailingBadge: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Text(
                              'GIFT',
                              style: GoogleFonts.inter(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFB45309),
                              ),
                            ),
                          ),
                          onTap: () async {
                            await Share.share(
                              'https://play.google.com/store/apps/details?id=com.travia',
                              sharePositionOrigin: getWidgetBoundingBox(itemContext),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),

                  // --- SECTION 4: SUPPORT & FEEDBACK ---
                  _buildSectionTitle('Help & Feedback'),
                  _buildSectionCard(
                    children: [
                      _buildMenuItem(
                        iconWidget: const Icon(Icons.help_outline_rounded, color: Color(0xFF475569), size: 22.0),
                        iconBgColor: const Color(0xFFF1F5F9),
                        title: 'Help & Support',
                        subtitle: 'Get 24/7 assistance and read guides',
                        onTap: () {
                          context.pushNamed(SupportPageWidget.routeName);
                        },
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        iconWidget: const Icon(Icons.report_problem_outlined, color: Color(0xFFDC2626), size: 22.0),
                        iconBgColor: const Color(0xFFFEF2F2),
                        title: 'Report an Issue',
                        subtitle: 'Submit account feedback or technical bugs',
                        onTap: () {
                          context.pushNamed(SupportPageWidget.routeName);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),

                  // --- SIGN OUT BUTTON ---
                  InkWell(
                    onTap: _handleSignOut,
                    borderRadius: BorderRadius.circular(14.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF1F2),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(color: const Color(0xFFFECDD3), width: 1.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.logout_rounded,
                            size: 18.0,
                            color: Color(0xFFE11D48),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'Sign Out',
                            style: GoogleFonts.interTight(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFE11D48),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20.0),

                  // App Version Footer
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Travia App • v1.0.0',
                          style: GoogleFonts.inter(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          'Travel Together • Save Together',
                          style: GoogleFonts.inter(
                            fontSize: 11.0,
                            color: const Color(0xFFCBD5E1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
