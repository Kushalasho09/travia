import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import 'package:flutter_svg/svg.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_footer_model.dart';
export 'main_footer_model.dart';

class MainFooterWidget extends StatefulWidget {
  const MainFooterWidget({super.key, this.selectedIndex});
  final int? selectedIndex;

  @override
  State<MainFooterWidget> createState() => _MainFooterWidgetState();
}

class _MainFooterWidgetState extends State<MainFooterWidget> {
  late MainFooterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainFooterModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  int _getActiveIndex(BuildContext context) {
    if (widget.selectedIndex != null) {
      return widget.selectedIndex!;
    }
    try {
      final routeName = ModalRoute.of(context)?.settings.name ?? '';
      final location = GoRouterState.of(context).uri.toString();

      if (routeName == HomeWidget.routeName || location.contains('homeWidget')) {
        return 0; // Rides
      } else if (routeName == MarketPlaceCustomerWidget.routeName || location.contains('marketPlaceCustomer')) {
        return 1; // Market
      } else if (routeName == PostRideSelectWidget.routeName || routeName == SelectBidTypeWidget.routeName || routeName == RideLocation1Widget.routeName || location.contains('postRideSelect') || location.contains('selectBidType') || location.contains('rideLocation1')) {
        return 2; // Publish
      } else if (routeName == ChatUsersWidget.routeName || location.contains('chatUsers') || location.contains('chat')) {
        return 3; // Chats
      } else if (routeName == DriveProfileWidget.routeName || location.contains('driveProfile')) {
        return 4; // Profile
      }
    } catch (_) {}
    return 0; // Default fallback to Rides
  }

  Widget _buildNavItem({
    required BuildContext context,
    required String svgPath,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    Widget? badge,
  }) {
    final activeColor = FlutterFlowTheme.of(context).tertiary;
    const inactiveColor = Color(0xFF1E293B);
    final color = isSelected ? activeColor : inactiveColor;

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  svgPath,
                  width: 24.0,
                  height: 24.0,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
                if (badge != null) badge,
              ],
            ),
            const SizedBox(height: 3.0),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11.5,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeIndex = _getActiveIndex(context);

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0, top: 4.0),
      child: Container(
        width: double.infinity,
        height: 64.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: const [
            BoxShadow(
              blurRadius: 16.0,
              color: Color(0x14000000),
              offset: Offset(0.0, 4.0),
            ),
            BoxShadow(
              blurRadius: 6.0,
              color: Color(0x0A000000),
              offset: Offset(0.0, -1.0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 1. Rides
            _buildNavItem(
              context: context,
              svgPath: 'assets/images/4.svg',
              label: 'Rides',
              isSelected: activeIndex == 0,
              onTap: () async {
                if (activeIndex != 0) {
                  context.pushNamed(
                    HomeWidget.routeName,
                    queryParameters: {
                      'tabNumberRef': serializeParam(
                        0,
                        ParamType.int,
                      ),
                    }.withoutNulls,
                  );
                }
              },
            ),

            // 2. Market
            _buildNavItem(
              context: context,
              svgPath: 'assets/images/3.svg',
              label: 'Market',
              isSelected: activeIndex == 1,
              onTap: () async {
                if (activeIndex != 1) {
                  context.pushNamed(
                    MarketPlaceCustomerWidget.routeName,
                    queryParameters: {
                      'tabNumberRef': serializeParam(
                        0,
                        ParamType.int,
                      ),
                    }.withoutNulls,
                  );
                }
              },
            ),

            // 3. Publish
            _buildNavItem(
              context: context,
              svgPath: 'assets/images/5.svg',
              label: 'Publish',
              isSelected: activeIndex == 2,
              onTap: () async {
                context.pushNamed(PostRideSelectWidget.routeName);
              },
            ),

            // 4. Chats
            loggedIn
                ? StreamBuilder<List<ChatsRecord>>(
                    stream: queryChatsRecord(
                      queryBuilder: (chatsRecord) => chatsRecord
                          .where('userIDs', arrayContains: currentUserReference)
                          .orderBy('lastMessageTime', descending: true),
                    ),
                    builder: (context, snapshot) {
                      bool hasUnread = false;
                      if (snapshot.hasData) {
                        final chatsList = snapshot.data!;
                        hasUnread = chatsList.any((chat) {
                          return !chat.lastMessagesSeenBy.any(
                            (userRef) => userRef.id == currentUserUid,
                          );
                        });
                      }

                      return _buildNavItem(
                        context: context,
                        svgPath: 'assets/images/2.svg',
                        label: 'Chats',
                        isSelected: activeIndex == 3,
                        badge: hasUnread
                            ? Positioned(
                                top: -2.0,
                                right: -2.0,
                                child: Container(
                                  width: 8.0,
                                  height: 8.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).tertiary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              )
                            : null,
                        onTap: () async {
                          if (activeIndex != 3) {
                            context.pushNamed(ChatUsersWidget.routeName);
                          }
                        },
                      );
                    },
                  )
                : _buildNavItem(
                    context: context,
                    svgPath: 'assets/images/2.svg',
                    label: 'Chats',
                    isSelected: activeIndex == 3,
                    onTap: () async {
                      if (activeIndex != 3) {
                        context.pushNamed(ChatUsersWidget.routeName);
                      }
                    },
                  ),

            // 5. Profile
            _buildNavItem(
              context: context,
              svgPath: 'assets/images/1.svg',
              label: 'Profile',
              isSelected: activeIndex == 4,
              onTap: () async {
                if (activeIndex != 4) {
                  context.pushNamed(DriveProfileWidget.routeName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
