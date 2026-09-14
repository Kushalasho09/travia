import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'page_notification_model.dart';
export 'page_notification_model.dart';

enum NotificationType {
  bookingRequest,
  bookingStatus,
  savedRide,
}

class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime time;
  final NotificationType type;
  final DocumentReference? bookingRef;
  final DocumentReference? rideRef;
  final String status;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.bookingRef,
    this.rideRef,
    this.status = '',
  });
}

class PageNotificationWidget extends StatefulWidget {
  const PageNotificationWidget({super.key});

  static String routeName = 'Page_Notification';
  static String routePath = '/pageNotification';

  @override
  State<PageNotificationWidget> createState() => _PageNotificationWidgetState();
}

class _PageNotificationWidgetState extends State<PageNotificationWidget> {
  late PageNotificationModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'Requests', 'Updates', 'Saved'];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PageNotificationModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  String _getRelativeTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return dateTimeFormat('MMMd', timestamp);
    }
  }

  Widget _buildNotificationIcon(AppNotification notification) {
    IconData iconData;
    Color iconColor;
    Color bgColor;

    switch (notification.type) {
      case NotificationType.bookingRequest:
        iconData = Icons.directions_car_filled_rounded;
        iconColor = const Color(0xFFEE7B4D);
        bgColor = const Color(0xFFFFF0E9);
        break;
      case NotificationType.bookingStatus:
        final st = notification.status.toLowerCase();
        if (st == 'accepted') {
          iconData = Icons.check_circle_rounded;
          iconColor = const Color(0xFF059669);
          bgColor = const Color(0xFFECFDF5);
        } else if (st == 'rejected') {
          iconData = Icons.cancel_rounded;
          iconColor = const Color(0xFFDC2626);
          bgColor = const Color(0xFFFEF2F2);
        } else if (st == 'completed') {
          iconData = Icons.task_alt_rounded;
          iconColor = const Color(0xFF2563EB);
          bgColor = const Color(0xFFEFF6FF);
        } else {
          iconData = Icons.schedule_rounded;
          iconColor = const Color(0xFFD97706);
          bgColor = const Color(0xFFFFFBEB);
        }
        break;
      case NotificationType.savedRide:
        iconData = Icons.bookmark_rounded;
        iconColor = const Color(0xFF6366F1);
        bgColor = const Color(0xFFF0ECFD);
        break;
    }

    return Container(
      width: 44.0,
      height: 44.0,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          iconData,
          color: iconColor,
          size: 20.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Stream 1: Bookings made BY current user (passenger/customer)
    final passengerBookingsStream = currentUserReference == null
        ? Stream<List<BookingsRecord>>.value([])
        : queryBookingsRecord(
            queryBuilder: (q) => q
                .where('creator', isEqualTo: currentUserReference)
                .orderBy('createdTime', descending: true),
            limit: 50,
          );

    // Stream 2: Rides posted BY current user (driver)
    final driverRidesStream = currentUserReference == null
        ? Stream<List<RidesNewRecord>>.value([])
        : queryRidesNewRecord(
            queryBuilder: (q) => q.where('creatorID', isEqualTo: currentUserReference),
          );

    // Stream 3: Recent bookings on driver's rides
    final allRecentBookingsStream = currentUserReference == null
        ? Stream<List<BookingsRecord>>.value([])
        : queryBookingsRecord(
            queryBuilder: (q) => q.orderBy('createdTime', descending: true),
            limit: 100,
          );

    // Stream 4: Rides saved by current user
    final savedRidesStream = currentUserReference == null
        ? Stream<List<RidesNewRecord>>.value([])
        : queryRidesNewRecord(
            queryBuilder: (q) => q.where('rideSavedByUser', isEqualTo: currentUserReference),
          );

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
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Center(
              child: InkWell(
                onTap: () => context.pop(),
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE5E7EB), width: 0.8),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xFF1E293B),
                    size: 16.0,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            'Notifications',
            style: GoogleFonts.inter(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: const Color(0xFFF1F5F9),
              height: 1.0,
            ),
          ),
        ),
        body: SafeArea(
          top: true,
          child: StreamBuilder<List<AppNotification>>(
            stream: Rx.combineLatest4<List<BookingsRecord>, List<RidesNewRecord>, List<BookingsRecord>, List<RidesNewRecord>, List<AppNotification>>(
              passengerBookingsStream,
              driverRidesStream,
              allRecentBookingsStream,
              savedRidesStream,
              (passengerBookings, driverRides, allBookings, savedRides) {
                final list = <AppNotification>[];
                final driverRideRefs = driverRides.map((r) => r.reference).toSet();
                final seenIds = <String>{};

                // Notifications for current user as PASSENGER
                for (final booking in passengerBookings) {
                  if (seenIds.contains(booking.reference.id)) continue;
                  seenIds.add(booking.reference.id);
                  list.add(AppNotification(
                    id: booking.reference.id,
                    title: booking.bookingType == 'Parcel' ? '📦 Parcel Request Update' : '🚗 Ride Request Update',
                    message: booking.bookingType == 'Parcel'
                        ? 'Your parcel request status is "${booking.status}".'
                        : 'Your booking request is "${booking.status}".',
                    time: booking.createdTime ?? DateTime.now(),
                    type: NotificationType.bookingStatus,
                    bookingRef: booking.reference,
                    rideRef: booking.rideID,
                    status: booking.status,
                  ));
                }

                // Notifications for current user as DRIVER
                for (final booking in allBookings) {
                  if (seenIds.contains(booking.reference.id)) continue;
                  if (driverRideRefs.contains(booking.rideID)) {
                    seenIds.add(booking.reference.id);
                    list.add(AppNotification(
                      id: booking.reference.id,
                      title: booking.bookingType == 'Parcel' ? '📦 New Parcel Request' : '🚗 New Booking Request',
                      message: booking.bookingType == 'Parcel'
                          ? 'A customer requested to send a parcel on your ride.'
                          : 'A passenger requested a booking for your ride.',
                      time: booking.createdTime ?? DateTime.now(),
                      type: NotificationType.bookingRequest,
                      bookingRef: booking.reference,
                      rideRef: booking.rideID,
                      status: booking.status,
                    ));
                  }
                }

                // Saved ride updates
                for (final ride in savedRides) {
                  if (seenIds.contains('saved_${ride.reference.id}')) continue;
                  seenIds.add('saved_${ride.reference.id}');
                  list.add(AppNotification(
                    id: 'saved_${ride.reference.id}',
                    title: '🔖 Saved Ride Update',
                    message: 'Your saved ride from ${ride.rideStartLocation} to ${ride.rideEndLocation} is ${ride.rideStatus.isNotEmpty ? ride.rideStatus : "scheduled"}.',
                    time: ride.createdTime ?? DateTime.now(),
                    type: NotificationType.savedRide,
                    rideRef: ride.reference,
                  ));
                }

                list.sort((a, b) => b.time.compareTo(a.time));
                return list;
              },
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: SizedBox(
                    width: 44.0,
                    height: 44.0,
                    child: SpinKitFadingCircle(
                      color: Color(0xFFEE7B4D),
                      size: 44.0,
                    ),
                  ),
                );
              }

              final allNotifications = snapshot.data!;

              // Filter by category
              final filteredNotifications = allNotifications.where((n) {
                if (_selectedCategory == 'Requests') {
                  return n.type == NotificationType.bookingRequest;
                } else if (_selectedCategory == 'Updates') {
                  return n.type == NotificationType.bookingStatus;
                } else if (_selectedCategory == 'Saved') {
                  return n.type == NotificationType.savedRide;
                }
                return true;
              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Horizontal Filter Pills (postRideSelect aesthetic)
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16.0, 14.0, 16.0, 10.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _categories.map((category) {
                          final isSelected = _selectedCategory == category;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = category;
                                });
                              },
                              borderRadius: BorderRadius.circular(30.0),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFFEE7B4D) : Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFFEE7B4D)
                                        : const Color(0xFFE5E7EB),
                                    width: 1.0,
                                  ),
                                  boxShadow: isSelected
                                      ? const [
                                          BoxShadow(
                                            color: Color(0x40EE7B4D),
                                            blurRadius: 8.0,
                                            offset: Offset(0.0, 2.0),
                                          ),
                                        ]
                                      : const [
                                          BoxShadow(
                                            color: Color(0x06000000),
                                            blurRadius: 4.0,
                                            offset: Offset(0.0, 1.0),
                                          ),
                                        ],
                                ),
                                child: Text(
                                  category,
                                  style: GoogleFonts.inter(
                                    fontSize: 13.0,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                    color: isSelected ? Colors.white : const Color(0xFF4B5563),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  // Notifications List
                  Expanded(
                    child: filteredNotifications.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 72.0,
                                    height: 72.0,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFFF0E9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.notifications_none_rounded,
                                      size: 36.0,
                                      color: Color(0xFFEE7B4D),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    'No Notifications',
                                    style: GoogleFonts.inter(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1F2937),
                                    ),
                                  ),
                                  const SizedBox(height: 6.0),
                                  Text(
                                    _selectedCategory == 'All'
                                        ? "You're all caught up! There are no new notifications."
                                        : "No notifications found in '$_selectedCategory'.",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF6B7280),
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 24.0),
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: filteredNotifications.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 12.0),
                            itemBuilder: (context, index) {
                              final notification = filteredNotifications[index];
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x082C3550),
                                      blurRadius: 12.0,
                                      offset: Offset(0.0, 3.0),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(14.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildNotificationIcon(notification),
                                    const SizedBox(width: 12.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Title & Time Row (EXPANDED TO PREVENT OVERFLOW)
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  notification.title,
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w700,
                                                    color: const Color(0xFF1F2937),
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 8.0),
                                              Text(
                                                _getRelativeTime(notification.time),
                                                style: GoogleFonts.inter(
                                                  fontSize: 11.5,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color(0xFF9CA3AF),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            notification.message,
                                            style: GoogleFonts.inter(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xFF4B5563),
                                              height: 1.35,
                                            ),
                                          ),
                                          // Action Buttons
                                          if (notification.type == NotificationType.bookingRequest) ...[
                                            const SizedBox(height: 10.0),
                                            InkWell(
                                              onTap: () async {
                                                context.pushNamed(BookingsDriverWidget.routeName);
                                              },
                                              borderRadius: BorderRadius.circular(20.0),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFFFF0E9),
                                                  borderRadius: BorderRadius.circular(20.0),
                                                  border: Border.all(color: const Color(0xFFFFD8C7), width: 0.8),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'View Bookings',
                                                      style: GoogleFonts.inter(
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.w600,
                                                        color: const Color(0xFFEE7B4D),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4.0),
                                                    const Icon(
                                                      Icons.arrow_forward_ios_rounded,
                                                      size: 10.0,
                                                      color: Color(0xFFEE7B4D),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ] else if ((notification.type == NotificationType.bookingStatus ||
                                                  notification.type == NotificationType.savedRide) &&
                                              notification.rideRef != null) ...[
                                            const SizedBox(height: 10.0),
                                            InkWell(
                                              onTap: () async {
                                                context.pushNamed(
                                                  RideDetailsCustomerWidget.routeName,
                                                  queryParameters: {
                                                    'rideDetails': serializeParam(
                                                      notification.rideRef,
                                                      ParamType.DocumentReference,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              borderRadius: BorderRadius.circular(20.0),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFFFF0E9),
                                                  borderRadius: BorderRadius.circular(20.0),
                                                  border: Border.all(color: const Color(0xFFFFD8C7), width: 0.8),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'View Ride Details',
                                                      style: GoogleFonts.inter(
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.w600,
                                                        color: const Color(0xFFEE7B4D),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4.0),
                                                    const Icon(
                                                      Icons.arrow_forward_ios_rounded,
                                                      size: 10.0,
                                                      color: Color(0xFFEE7B4D),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}