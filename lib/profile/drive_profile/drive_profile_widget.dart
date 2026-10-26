import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/compotement/main_footer/main_footer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'drive_profile_model.dart';
export 'drive_profile_model.dart';

class DriveProfileWidget extends StatefulWidget {
  const DriveProfileWidget({super.key});

  static String routeName = 'Drive_Profile';
  static String routePath = '/driveProfile';

  @override
  State<DriveProfileWidget> createState() => _DriveProfileWidgetState();
}

class _DriveProfileWidgetState extends State<DriveProfileWidget> {
  late DriveProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DriveProfileModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canGoBack = Navigator.of(context).canPop();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: canGoBack
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      context.pop();
                    },
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3F4F6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Color(0xFF111827),
                        size: 20.0,
                      ),
                    ),
                  ),
                )
              : null,
          title: Text(
            'My Profile',
            style: GoogleFonts.inter(
              fontSize: 19.0,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: InkWell(
                onTap: () async {
                  context.pushNamed(EditprofileWidget.routeName);
                },
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F4F6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFF2C3550),
                    size: 19.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const MainFooterWidget(selectedIndex: 4),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. TOP HERO PROFILE CARD
                _buildHeroProfileCard(context),

                const SizedBox(height: 18.0),

                // 2. MANDATORY KYC ACTION CARD
                _buildKycActionCard(context),

                const SizedBox(height: 20.0),

                // 3. PERSONAL INFORMATION CARD
                _buildPersonalInfoCard(context),

                const SizedBox(height: 18.0),

                // 4. ADDRESS INFORMATION CARD (if available)
                _buildAddressInfoCard(context),

                const SizedBox(height: 18.0),

                // 5. ACCOUNT DETAILS CARD
                _buildAccountDetailsCard(context),

                const SizedBox(height: 18.0),

                // 6. SUPPORT & HELP CARD
                _buildSupportCard(context),

                const SizedBox(height: 20.0),

                // 7. LEGAL & POLICIES CARD
                _buildLegalAndPoliciesCard(context),

                const SizedBox(height: 24.0),

                // 8. LOG OUT BUTTON
                _buildLogoutButton(context),

                const SizedBox(height: 12.0),

                // 9. DELETE ACCOUNT BUTTON (DPDP Act)
                _buildDeleteAccountButton(context),

                const SizedBox(height: 28.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 1. HERO PROFILE CARD
  // ==========================================
  Widget _buildHeroProfileCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
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
            blurRadius: 16.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar Stack with edit/camera button
          Stack(
            children: [
              Container(
                width: 88.0,
                height: 88.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF3F4F6),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 10.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Builder(
                    builder: (context) {
                      if (currentUserPhoto.isNotEmpty) {
                        return Image.network(
                          currentUserPhoto,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/userIconTravia.png',
                              fit: BoxFit.cover,
                            );
                          },
                        );
                      } else {
                        return Image.asset(
                          'assets/images/userIconTravia.png',
                          fit: BoxFit.cover,
                        );
                      }
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: InkWell(
                  onTap: () async {
                    context.pushNamed(SetProfileImageWidget.routeName);
                  },
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(6.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEE7B4D),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x28000000),
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 14.0,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14.0),

          // User Name
          AuthUserStreamWidget(
            builder: (context) {
              final name = valueOrDefault(
                currentUserDocument?.userName,
                currentUserDisplayName.isNotEmpty ? currentUserDisplayName : 'Travia Member',
              );
              return Text(
                name,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              );
            },
          ),

          const SizedBox(height: 6.0),

          // Phone or Email Subtitle
          AuthUserStreamWidget(
            builder: (context) {
              final phone = currentPhoneNumber;
              final email = currentUserEmail;
              final displaySub = phone.isNotEmpty ? phone : (email.isNotEmpty ? email : '');
              if (displaySub.isEmpty) return const SizedBox.shrink();

              return Text(
                displaySub,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6B7280),
                ),
              );
            },
          ),

          const SizedBox(height: 12.0),

          // Verification Badge Pill
          AuthUserStreamWidget(
            builder: (context) {
              final isVerified = valueOrDefault<bool>(currentUserDocument?.isVerifed, false);

              if (isVerified) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF7F2),
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(
                      color: const Color(0xFFD6EFE1),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified_rounded,
                        color: Color(0xFF10B981),
                        size: 15.0,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        'Verified Profile',
                        style: GoogleFonts.inter(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF10B981),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return InkWell(
                  onTap: () async {
                    context.pushNamed(PersonalKYCWidget.routeName);
                  },
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF6EE),
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        color: const Color(0xFFFFE2CC),
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.shield_outlined,
                          color: Color(0xFFEE7B4D),
                          size: 15.0,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          'Unverified • Complete KYC',
                          style: GoogleFonts.inter(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFEE7B4D),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    ).animate().fade(duration: 450.ms).slideY(begin: -0.04, end: 0);
  }

  // ==========================================
  // 2. MANDATORY KYC ACTION CARD
  // ==========================================
  Widget _buildKycActionCard(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          context.pushNamed(PersonalKYCWidget.routeName);
        },
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF0ECFD),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: const Color(0xFFE2DBFC),
              width: 1.0,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0C5F46E8),
                blurRadius: 14.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48.0,
                height: 48.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.assignment_ind_rounded,
                    color: Color(0xFF6C4DF6),
                    size: 26.0,
                  ),
                ),
              ).animate(onPlay: (c) => c.repeat(reverse: true))
               .scale(begin: const Offset(0.97, 0.97), end: const Offset(1.03, 1.03), duration: 2000.ms, curve: Curves.easeInOut),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Personal KYC',
                          style: GoogleFonts.inter(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2C3550),
                          ),
                        ),
                        const SizedBox(width: 7.0),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEE7B4D),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Text(
                            'MANDATORY',
                            style: GoogleFonts.inter(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      'Upload your government ID to verify',
                      style: GoogleFonts.inter(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6E7891),
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                width: 36.0,
                height: 36.0,
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
                  size: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fade(delay: 150.ms, duration: 500.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
  }

  // ==========================================
  // 3. PERSONAL INFORMATION CARD
  // ==========================================
  Widget _buildPersonalInfoCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: const Color(0xFFEAECEF),
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 12.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF0E9),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: Color(0xFFEE7B4D),
                      size: 20.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    'Personal Information',
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () async {
                  context.pushNamed(EditprofileWidget.routeName);
                },
                borderRadius: BorderRadius.circular(20.0),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Edit',
                        style: GoogleFonts.inter(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFEE7B4D),
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      const Icon(
                        Icons.edit_rounded,
                        color: Color(0xFFEE7B4D),
                        size: 14.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16.0),

          // Email
          if (currentUserEmail.isNotEmpty) ...[
            _buildDataRow(
              icon: Icons.email_outlined,
              iconColor: const Color(0xFF3B82F6),
              iconBgColor: const Color(0xFFEFF6FF),
              label: 'Email',
              value: currentUserEmail,
            ),
            const Divider(height: 20.0, thickness: 0.8, color: Color(0xFFF1F5F9)),
          ],

          // Phone
          if (currentPhoneNumber.isNotEmpty) ...[
            AuthUserStreamWidget(
              builder: (context) => _buildDataRow(
                icon: Icons.phone_outlined,
                iconColor: const Color(0xFF10B981),
                iconBgColor: const Color(0xFFECFDF5),
                label: 'Phone',
                value: currentPhoneNumber,
              ),
            ),
            const Divider(height: 20.0, thickness: 0.8, color: Color(0xFFF1F5F9)),
          ],

          // Date of Birth
          AuthUserStreamWidget(
            builder: (context) {
              final newDob = currentUserDocument?.newDateOfBirth ?? '';
              final oldDob = currentUserDocument?.dateOfBirth != null
                  ? dateTimeFormat("yMMMd", currentUserDocument?.dateOfBirth)
                  : '';
              final dob = newDob.isNotEmpty ? newDob : oldDob;

              if (dob.isEmpty) return const SizedBox.shrink();

              return _buildDataRow(
                icon: Icons.cake_outlined,
                iconColor: const Color(0xFFEC4899),
                iconBgColor: const Color(0xFFFDF2F8),
                label: 'Date of Birth',
                value: dob,
              );
            },
          ),
        ],
      ),
    ).animate().fade(delay: 250.ms, duration: 500.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
  }

  // ==========================================
  // 4. ADDRESS INFORMATION CARD
  // ==========================================
  Widget _buildAddressInfoCard(BuildContext context) {
    return AuthUserStreamWidget(
      builder: (context) {
        final city = valueOrDefault(currentUserDocument?.city, '');
        final street = valueOrDefault(currentUserDocument?.street, '');
        final state = valueOrDefault(currentUserDocument?.state, '');
        final country = currentUserDocument?.country.isNotEmpty == true ? currentUserDocument!.country : 'India';
        final postalCode = valueOrDefault<int>(currentUserDocument?.postalCode, 0);

        // If no address info entered yet, skip showing an empty card
        if (city.isEmpty && street.isEmpty && state.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: const Color(0xFFEAECEF),
              width: 1.0,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x08000000),
                blurRadius: 12.0,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF7F2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF10B981),
                      size: 20.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    'Address Information',
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16.0),

              if (street.isNotEmpty) ...[
                _buildDataRow(
                  icon: Icons.home_outlined,
                  iconColor: const Color(0xFF6B7280),
                  iconBgColor: const Color(0xFFF3F4F6),
                  label: 'Street',
                  value: street,
                ),
                const Divider(height: 20.0, thickness: 0.8, color: Color(0xFFF1F5F9)),
              ],

              if (city.isNotEmpty) ...[
                _buildDataRow(
                  icon: Icons.location_city_outlined,
                  iconColor: const Color(0xFF6B7280),
                  iconBgColor: const Color(0xFFF3F4F6),
                  label: 'City',
                  value: city,
                ),
                const Divider(height: 20.0, thickness: 0.8, color: Color(0xFFF1F5F9)),
              ],

              if (state.isNotEmpty) ...[
                _buildDataRow(
                  icon: Icons.map_outlined,
                  iconColor: const Color(0xFF6B7280),
                  iconBgColor: const Color(0xFFF3F4F6),
                  label: 'State / Province',
                  value: state,
                ),
                const Divider(height: 20.0, thickness: 0.8, color: Color(0xFFF1F5F9)),
              ],

              _buildDataRow(
                icon: Icons.public_outlined,
                iconColor: const Color(0xFF6B7280),
                iconBgColor: const Color(0xFFF3F4F6),
                label: 'Country',
                value: country,
              ),

              if (postalCode != 0) ...[
                const Divider(height: 20.0, thickness: 0.8, color: Color(0xFFF1F5F9)),
                _buildDataRow(
                  icon: Icons.local_post_office_outlined,
                  iconColor: const Color(0xFF6B7280),
                  iconBgColor: const Color(0xFFF3F4F6),
                  label: 'Postal Code',
                  value: postalCode.toString(),
                ),
              ],
            ],
          ),
        ).animate().fade(delay: 350.ms, duration: 500.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
      },
    );
  }

  // ==========================================
  // 5. ACCOUNT DETAILS CARD
  // ==========================================
  Widget _buildAccountDetailsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: const Color(0xFFEAECEF),
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 12.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0ECFD),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Icon(
                  Icons.badge_outlined,
                  color: Color(0xFF6C4DF6),
                  size: 20.0,
                ),
              ),
              const SizedBox(width: 10.0),
              Text(
                'Account Information',
                style: GoogleFonts.inter(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16.0),

          // User ID
          _buildDataRow(
            icon: Icons.fingerprint_rounded,
            iconColor: const Color(0xFF6366F1),
            iconBgColor: const Color(0xFFEEF2FF),
            label: 'User ID',
            value: currentUserUid.isNotEmpty ? currentUserUid : 'N/A',
            isCopiable: currentUserUid.isNotEmpty,
          ),

          const Divider(height: 20.0, thickness: 0.8, color: Color(0xFFF1F5F9)),

          // Created On
          AuthUserStreamWidget(
            builder: (context) {
              final created = currentUserDocument?.createdTime != null
                  ? dateTimeFormat("yMMMd", currentUserDocument?.createdTime)
                  : 'N/A';
              return _buildDataRow(
                icon: Icons.calendar_today_outlined,
                iconColor: const Color(0xFFF59E0B),
                iconBgColor: const Color(0xFFFEF3C7),
                label: 'Created On',
                value: created,
              );
            },
          ),

          const Divider(height: 20.0, thickness: 0.8, color: Color(0xFFF1F5F9)),

          // Account Status
          AuthUserStreamWidget(
            builder: (context) {
              final isVerified = valueOrDefault<bool>(currentUserDocument?.isVerifed, false);
              return Row(
                children: [
                  Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: isVerified ? const Color(0xFFEEF7F2) : const Color(0xFFFFF6EE),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(
                      isVerified ? Icons.verified_user_outlined : Icons.gpp_maybe_outlined,
                      color: isVerified ? const Color(0xFF10B981) : const Color(0xFFEE7B4D),
                      size: 18.0,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Text(
                    'Account Status',
                    style: GoogleFonts.inter(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF4B5563),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: isVerified ? const Color(0xFFEEF7F2) : const Color(0xFFFFF6EE),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: isVerified ? const Color(0xFFD6EFE1) : const Color(0xFFFFE2CC),
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      isVerified ? 'Verified' : 'Unverified',
                      style: GoogleFonts.inter(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: isVerified ? const Color(0xFF10B981) : const Color(0xFFEE7B4D),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    ).animate().fade(delay: 400.ms, duration: 500.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
  }

  // ==========================================
  // 6. SUPPORT & HELP CARD
  // ==========================================
  Widget _buildSupportCard(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          context.pushNamed(SupportPageWidget.routeName);
        },
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF7F2),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: const Color(0xFFD6EFE1),
              width: 1.0,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0C10B981),
                blurRadius: 14.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48.0,
                height: 48.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.support_agent_rounded,
                    color: Color(0xFF10B981),
                    size: 26.0,
                  ),
                ),
              ).animate(onPlay: (c) => c.repeat(reverse: true))
               .scale(begin: const Offset(0.97, 0.97), end: const Offset(1.03, 1.03), duration: 2000.ms, curve: Curves.easeInOut),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Live Chat & Support',
                      style: GoogleFonts.inter(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2C3550),
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      'Talk to our 24/7 dedicated support team',
                      style: GoogleFonts.inter(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6E7891),
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                width: 36.0,
                height: 36.0,
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
                  size: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fade(delay: 500.ms, duration: 500.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
  }

  // ==========================================
  // 7. LEGAL & POLICIES CARD
  // ==========================================
  Widget _buildLegalAndPoliciesCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: const Color(0xFFEAECEF),
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 12.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Icon(
                  Icons.gavel_rounded,
                  color: Color(0xFFF59E0B),
                  size: 20.0,
                ),
              ),
              const SizedBox(width: 10.0),
              Text(
                'Legal & Policies',
                style: GoogleFonts.inter(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14.0),

          _buildLegalTile(
            context,
            icon: Icons.privacy_tip_outlined,
            iconColor: const Color(0xFF10B981),
            iconBgColor: const Color(0xFFEEF7F2),
            title: 'Privacy Policy',
            categoryRef: 'Privacy Policy',
          ),

          const Divider(height: 16.0, thickness: 0.8, color: Color(0xFFF1F5F9)),

          _buildLegalTile(
            context,
            icon: Icons.description_outlined,
            iconColor: const Color(0xFF6366F1),
            iconBgColor: const Color(0xFFEEF2FF),
            title: 'Terms & Conditions',
            categoryRef: 'Terms & Conditions',
          ),

          const Divider(height: 16.0, thickness: 0.8, color: Color(0xFFF1F5F9)),

          _buildLegalTile(
            context,
            icon: Icons.warning_amber_rounded,
            iconColor: const Color(0xFFF59E0B),
            iconBgColor: const Color(0xFFFEF3C7),
            title: 'Disclaimer',
            categoryRef: 'Disclaimer',
          ),

          const Divider(height: 16.0, thickness: 0.8, color: Color(0xFFF1F5F9)),

          _buildLegalTile(
            context,
            icon: Icons.handshake_outlined,
            iconColor: const Color(0xFF3B82F6),
            iconBgColor: const Color(0xFFEFF6FF),
            title: 'Terms of Service',
            categoryRef: 'Terms of Service',
          ),

          const Divider(height: 16.0, thickness: 0.8, color: Color(0xFFF1F5F9)),

          _buildLegalTile(
            context,
            icon: Icons.copyright_outlined,
            iconColor: const Color(0xFF8B5CF6),
            iconBgColor: const Color(0xFFF3E8FF),
            title: 'Copyright Notice',
            categoryRef: 'Copyright Notice',
          ),
        ],
      ),
    ).animate().fade(delay: 600.ms, duration: 500.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildLegalTile(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String categoryRef,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          context.pushNamed(
            TCPagesWidget.routeName,
            queryParameters: {
              'categoryRef': serializeParam(
                categoryRef,
                ParamType.String,
              ),
            }.withoutNulls,
          );
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
          child: Row(
            children: [
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 19.0,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2937),
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF9CA3AF),
                size: 14.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 8. LOG OUT BUTTON
  // ==========================================
  Widget _buildLogoutButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: Text(
                  'Log Out',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    color: const Color(0xFF111827),
                  ),
                ),
                content: Text(
                  'Are you sure you want to log out of your account?',
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    color: const Color(0xFF4B5563),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext, false),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext, true),
                    child: Text(
                      'Log Out',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFEF4444),
                      ),
                    ),
                  ),
                ],
              );
            },
          );

          if (confirm == true) {
            if (!context.mounted) return;
            GoRouter.of(context).prepareAuthEvent();
            await authManager.signOut();
            if (!context.mounted) return;
            GoRouter.of(context).clearRedirectLocation();
            context.goNamedAuth(
              PhoneNumberLoginWidget.routeName,
              context.mounted,
            );
          }
        },
        borderRadius: BorderRadius.circular(18.0),
        child: Container(
          width: double.infinity,
          height: 52.0,
          decoration: BoxDecoration(
            color: const Color(0xFFFEF2F2),
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(
              color: const Color(0xFFFCA5A5),
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.logout_rounded,
                color: Color(0xFFEF4444),
                size: 20.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Log Out',
                style: GoogleFonts.inter(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFEF4444),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fade(delay: 700.ms, duration: 500.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
  }

  // ==========================================
  // 9. DELETE ACCOUNT BUTTON (DPDP Act)
  // ==========================================
  Widget _buildDeleteAccountButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Icon(Icons.warning_amber_rounded, color: Color(0xFFDC2626), size: 22.0),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        'Delete Account',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                          color: const Color(0xFF111827),
                        ),
                      ),
                    ),
                  ],
                ),
                content: Text(
                  'Are you sure you want to permanently delete your account and personal data? This action cannot be undone (DPDP Act Compliance).',
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    color: const Color(0xFF4B5563),
                    height: 1.45,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext, false),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext, true),
                    child: Text(
                      'Delete Account',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFDC2626),
                      ),
                    ),
                  ),
                ],
              );
            },
          );

          if (confirm == true) {
            try {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Deleting your account and data...')),
              );
              if (currentUserReference != null) {
                await currentUserReference!.delete();
              }
              if (!context.mounted) return;
              await authManager.deleteUser(context);
              if (!context.mounted) return;
              GoRouter.of(context).prepareAuthEvent();
              await authManager.signOut();
              if (!context.mounted) return;
              GoRouter.of(context).clearRedirectLocation();
              context.goNamedAuth(
                PhoneNumberLoginWidget.routeName,
                context.mounted,
              );
            } catch (e) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to delete account: $e'),
                  backgroundColor: const Color(0xFFDC2626),
                ),
              );
            }
          }
        },
        borderRadius: BorderRadius.circular(18.0),
        child: Container(
          width: double.infinity,
          height: 48.0,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.delete_outline_rounded,
                color: Color(0xFF9CA3AF),
                size: 18.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Delete Account',
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fade(delay: 750.ms, duration: 500.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
  }

  // ==========================================
  // HELPER: DATA ROW
  // ==========================================
  Widget _buildDataRow({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String label,
    required String value,
    bool isCopiable = false,
  }) {
    return Row(
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 18.0,
          ),
        ),
        const SizedBox(width: 12.0),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF4B5563),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111827),
            ),
          ),
        ),
        if (isCopiable) ...[
          const SizedBox(width: 6.0),
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: value));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Copied $label to clipboard'),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16.0),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.copy_rounded,
                size: 15.0,
                color: Color(0xFF9CA3AF),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
