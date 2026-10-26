import 'package:travia/compotement/termsconditions11/termsconditions11_widget.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'book_ride_model.dart';
export 'book_ride_model.dart';

class BookRideWidget extends StatefulWidget {
  const BookRideWidget({
    super.key,
    required this.rideID,
  });

  final DocumentReference? rideID;

  static String routeName = 'BookRide';
  static String routePath = '/bookRide';

  @override
  State<BookRideWidget> createState() => _BookRideWidgetState();
}

class _BookRideWidgetState extends State<BookRideWidget> {
  late BookRideModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookRideModel());

    _model.bookingFor = 'Self';

    _model.nameTextController ??= TextEditingController(text: currentUserDisplayName);
    _model.nameFocusNode ??= FocusNode();

    _model.contactNumberTextController ??= TextEditingController(text: currentPhoneNumber);
    _model.contactNumberFocusNode ??= FocusNode();

    _model.contactNumberMask = MaskTextInputFormatter(mask: '+91 ###### #####');
    _model.meetupAddressTextController ??= TextEditingController();
    _model.meetupAddressFocusNode ??= FocusNode();

    _model.additionalInformationTextController ??= TextEditingController();
    _model.additionalInformationFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _showWarningDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const Icon(Icons.info_outline_rounded, color: Color(0xFFEE7B4D), size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Required Info',
              style: GoogleFonts.inter(fontSize: 17.0, fontWeight: FontWeight.bold, color: const Color(0xFF111827)),
            ),
          ],
        ),
        content: Text(
          message,
          style: GoogleFonts.inter(fontSize: 13.5, color: const Color(0xFF475569), height: 1.4),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEE7B4D),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            ),
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Got it',
              style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitRideBooking() async {
    if (_model.bookingFor.isEmpty || _model.bookingFor == 'NotSet') {
      _showWarningDialog('Please select who you are booking the trip for (Self or Friend).');
      return;
    }
    if (_model.nameTextController?.text.trim().isEmpty ?? true) {
      _showWarningDialog('Please enter the full name of the passenger.');
      return;
    }
    if (_model.contactNumberTextController?.text.trim().isEmpty ?? true) {
      _showWarningDialog('Please enter the passenger\'s contact number.');
      return;
    }
    if (_model.meetupAddressTextController?.text.trim().isEmpty ?? true) {
      _showWarningDialog('Please select the meetup or pickup address.');
      return;
    }
    if (_model.checkboxValue != true) {
      _showWarningDialog('Please accept the Terms & Conditions to proceed.');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // 1. Create Booking in Firestore
      await BookingsRecord.collection.doc().set(createBookingsRecordData(
            bookingType: 'Ride',
            rideNameOfPerson: _model.nameTextController?.text.trim() ?? '',
            ridePersonContactNumber: _model.contactNumberTextController?.text.trim() ?? '',
            rideMeetupAddress: _model.meetupAddressTextController?.text.trim() ?? '',
            meetupLocationMap: _model.meetupLocationMap,
            rideAdditionalInformation: _model.additionalInformationTextController?.text.trim() ?? '',
            liveTrackingEnabled: _model.liveTrackingEnabled,
            status: 'Pending',
            rideBookFor: _model.bookingFor,
            createdTime: getCurrentTimestamp,
            creator: currentUserReference,
            rideID: widget.rideID,
            bookingFor: _model.bookingFor,
          ));

      // 2. Send push notification to driver
      try {
        final rideRef = widget.rideID;
        if (rideRef != null) {
          final rideSnapshot = await rideRef.get();
          if (rideSnapshot.exists) {
            final rideData = rideSnapshot.data() as Map<String, dynamic>?;
            final DocumentReference? driverRef = rideData?['creatorID'] as DocumentReference?;
            if (driverRef != null) {
              final driverSnapshot = await driverRef.get();
              if (driverSnapshot.exists) {
                final driverData = driverSnapshot.data() as Map<String, dynamic>?;
                String? fcmToken;
                if (driverData?['fcmToken'] != null) {
                  fcmToken = driverData!['fcmToken'] as String?;
                } else if (driverData?['fcmTokens'] is List && (driverData!['fcmTokens'] as List).isNotEmpty) {
                  fcmToken = (driverData['fcmTokens'] as List).first as String?;
                }

                if (fcmToken != null && fcmToken.isNotEmpty) {
                  await FirebaseFunctions.instance.httpsCallable('sendChatNotification').call({
                    'token': fcmToken,
                    'senderName': currentUserDisplayName.isNotEmpty ? currentUserDisplayName : 'Travia Customer',
                    'message': 'A passenger wants to book a seat on your ride!',
                    'chatId': '',
                  });
                }
              }
            }
          }
        }
      } catch (e) {
        // Non-fatal error
      }

      if (mounted) {
        context.goNamed(
          RideBookingSentWidget.routeName,
          queryParameters: {
            'rideRef': serializeParam(
              widget.rideID,
              ParamType.DocumentReference,
            ),
          }.withoutNulls,
        );
      }
    } catch (e) {
      if (mounted) {
        _showWarningDialog('Failed to book ride: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
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
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0.5,
          shadowColor: Colors.black.withValues(alpha: 0.04),
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: FlutterFlowIconButton(
              borderRadius: 12.0,
              buttonSize: 40.0,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF111827),
                size: 18.0,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: Text(
            'Book Your Ride',
            style: GoogleFonts.inter(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Optional Trip Summary Card (if rideID is present)
                if (widget.rideID != null)
                  StreamBuilder<RidesNewRecord>(
                    stream: RidesNewRecord.getDocument(widget.rideID!),
                    builder: (context, rideSnapshot) {
                      if (!rideSnapshot.hasData) {
                        return const SizedBox.shrink();
                      }
                      final ride = rideSnapshot.data!;

                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 18.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10.0,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF4ED),
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(color: const Color(0xFFFFD4C2)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.directions_car_filled_rounded, color: Color(0xFFEE7B4D), size: 14.0),
                                      const SizedBox(width: 5.0),
                                      Text(
                                        'Shared Ride',
                                        style: GoogleFonts.inter(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFFEE7B4D),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (ride.pricePerPassengers > 0)
                                  Text(
                                    '₹${ride.pricePerPassengers} / seat',
                                    style: GoogleFonts.inter(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFF111827),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 14.0),

                            // Route Visual
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 10.0,
                                      height: 10.0,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF10B981),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Container(
                                      width: 2.0,
                                      height: 24.0,
                                      color: const Color(0xFFCBD5E1),
                                    ),
                                    Container(
                                      width: 10.0,
                                      height: 10.0,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFEE7B4D),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ride.rideStartLocation.isNotEmpty ? ride.rideStartLocation : 'Pickup Location',
                                        style: GoogleFonts.inter(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF1E293B),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 14.0),
                                      Text(
                                        ride.rideEndLocation.isNotEmpty ? ride.rideEndLocation : 'Destination Location',
                                        style: GoogleFonts.inter(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF1E293B),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            if (ride.pickupTime != null) ...[
                              const SizedBox(height: 12.0),
                              const Divider(height: 1.0, color: Color(0xFFF1F5F9)),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  const Icon(Icons.schedule_rounded, size: 15.0, color: Color(0xFF64748B)),
                                  const SizedBox(width: 6.0),
                                  Text(
                                    'Departure: ${dateTimeFormat("MMM d, yyyy  •  jm", ride.pickupTime!)}',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),

                // Main Booking Form Card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10.0,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Booking For Selector
                      Text(
                        'Who are you booking for?',
                        style: GoogleFonts.inter(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 10.0),

                      Row(
                        children: [
                          Expanded(
                            child: _buildBookingForPill(
                              label: 'For Myself',
                              subtitle: 'Self booking',
                              isSelected: _model.bookingFor == 'Self',
                              onTap: () {
                                setState(() {
                                  _model.bookingFor = 'Self';
                                  if ((_model.nameTextController?.text.isEmpty ?? true) && currentUserDisplayName.isNotEmpty) {
                                    _model.nameTextController?.text = currentUserDisplayName;
                                  }
                                  if ((_model.contactNumberTextController?.text.isEmpty ?? true) && currentPhoneNumber.isNotEmpty) {
                                    _model.contactNumberTextController?.text = currentPhoneNumber;
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: _buildBookingForPill(
                              label: 'Friend / Family',
                              subtitle: 'Other person',
                              isSelected: _model.bookingFor == 'Friend',
                              onTap: () {
                                setState(() {
                                  _model.bookingFor = 'Friend';
                                  _model.nameTextController?.clear();
                                  _model.contactNumberTextController?.clear();
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20.0),
                      const Divider(height: 1.0, color: Color(0xFFE2E8F0)),
                      const SizedBox(height: 18.0),

                      // Passenger Info Fields
                      Text(
                        'Passenger Details',
                        style: GoogleFonts.inter(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 12.0),

                      _buildFormField(
                        label: 'Passenger Full Name *',
                        hint: 'Enter full name',
                        controller: _model.nameTextController!,
                        focusNode: _model.nameFocusNode!,
                        icon: Icons.person_outline_rounded,
                      ),
                      const SizedBox(height: 14.0),

                      _buildFormField(
                        label: 'Contact Number *',
                        hint: '+91 XXXXX XXXXX',
                        controller: _model.contactNumberTextController!,
                        focusNode: _model.contactNumberFocusNode!,
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [_model.contactNumberMask],
                      ),
                      const SizedBox(height: 14.0),

                      // Meetup / Pickup Location
                      Text(
                        'Pickup / Meetup Address *',
                        style: GoogleFonts.inter(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569),
                        ),
                      ),
                      const SizedBox(height: 6.0),

                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on_outlined, color: Color(0xFFEE7B4D), size: 20.0),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: GooglePlaceAutoCompleteTextField(
                                focusNode: _model.meetupAddressFocusNode,
                                textEditingController: _model.meetupAddressTextController!,
                                googleAPIKey: "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
                                boxDecoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                containerHorizontalPadding: 0,
                                containerVerticalPadding: 0,
                                inputDecoration: InputDecoration(
                                  hintText: 'Search meetup address...',
                                  hintStyle: GoogleFonts.inter(fontSize: 13.5, color: const Color(0xFF94A3B8)),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                                ),
                                textStyle: GoogleFonts.inter(fontSize: 13.5, color: const Color(0xFF1E293B)),
                                debounceTime: 600,
                                isLatLngRequired: true,
                                getPlaceDetailWithLatLng: (prediction) {
                                  if (prediction.lat != null && prediction.lng != null) {
                                    _model.meetupLocationMap = LatLng(
                                      double.parse(prediction.lat!),
                                      double.parse(prediction.lng!),
                                    );
                                  }
                                },
                                itemClick: (prediction) {
                                  _model.meetupAddressTextController!.text = prediction.description ?? "";
                                  _model.meetupAddressTextController!.selection = TextSelection.fromPosition(
                                    TextPosition(offset: prediction.description?.length ?? 0),
                                  );
                                },
                                itemBuilder: (context, index, prediction) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on_outlined, size: 18.0, color: Color(0xFFEE7B4D)),
                                        const SizedBox(width: 10.0),
                                        Expanded(
                                          child: Text(
                                            prediction.description ?? "",
                                            style: GoogleFonts.inter(fontSize: 13.5, color: const Color(0xFF1E293B)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                seperatedBuilder: const Divider(height: 1.0, thickness: 0.5),
                                isCrossBtnShown: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14.0),

                      _buildFormField(
                        label: 'Additional Information (Optional)',
                        hint: 'Luggage details or special requests...',
                        controller: _model.additionalInformationTextController!,
                        focusNode: _model.additionalInformationFocusNode!,
                        icon: Icons.notes_rounded,
                        maxLines: 2,
                      ),

                      const SizedBox(height: 18.0),
                      const Divider(height: 1.0, color: Color(0xFFE2E8F0)),
                      const SizedBox(height: 18.0),

                      // Live Tracking Option (Pro/Premium)
                      Builder(
                        builder: (context) {
                          final isPremium = currentUserDocument?.isPremium ?? false;

                          if (isPremium) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF4ED),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.share_location_rounded,
                                      color: Color(0xFFEE7B4D),
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Live Tracking',
                                              style: GoogleFonts.inter(
                                                fontSize: 13.5,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xFF111827),
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFFF4ED),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: const Text(
                                                'PRO',
                                                style: TextStyle(
                                                  fontSize: 9.5,
                                                  fontWeight: FontWeight.w800,
                                                  color: Color(0xFFEE7B4D),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Send live route updates via notification',
                                          style: GoogleFonts.inter(fontSize: 11.5, color: const Color(0xFF64748B)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Switch.adaptive(
                                    value: _model.liveTrackingEnabled,
                                    activeThumbColor: const Color(0xFFEE7B4D),
                                    activeTrackColor: const Color(0xFFFFDCD0),
                                    onChanged: (val) {
                                      setState(() => _model.liveTrackingEnabled = val);
                                    },
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFBEB),
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: const Color(0xFFFDE68A)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFEF3C7),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Icon(Icons.lock_outline_rounded, color: Color(0xFFD97706), size: 18),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Live Tracking',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.w700,
                                                    color: const Color(0xFF92400E),
                                                  ),
                                                ),
                                                const SizedBox(width: 6),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFFFEF3C7),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: const Text(
                                                    'PREMIUM ONLY',
                                                    style: TextStyle(
                                                      fontSize: 9.0,
                                                      fontWeight: FontWeight.w800,
                                                      color: Color(0xFFD97706),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              'Available in notification for premium members only',
                                              style: GoogleFonts.inter(fontSize: 11.5, color: const Color(0xFFB45309)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          if (currentUserReference != null) {
                                            await currentUserReference!.update({
                                              'is_premium': true,
                                              'isPremium': true,
                                            });
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text('✨ Premium activated for testing!'),
                                                  duration: Duration(seconds: 2),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFEE7B4D).withValues(alpha: 0.12),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Text(
                                            '⚡ Activate Test Premium',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFFEE7B4D),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      InkWell(
                                        onTap: () => context.pushNamed(PlansWidget.routeName),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF1E293B),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Text(
                                            'View Plans',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),

                      const SizedBox(height: 18.0),
                      const Divider(height: 1.0, color: Color(0xFFE2E8F0)),
                      const SizedBox(height: 16.0),

                      // Terms & Conditions
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 22.0,
                            height: 22.0,
                            child: Checkbox(
                              value: _model.checkboxValue ??= true,
                              activeColor: const Color(0xFFEE7B4D),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                              side: BorderSide(
                                color: (_model.checkboxValue ?? true) ? const Color(0xFFEE7B4D) : const Color(0xFF94A3B8),
                                width: 1.5,
                              ),
                              onChanged: (val) {
                                setState(() => _model.checkboxValue = val ?? false);
                              },
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const Dialog(
                                      insetPadding: EdgeInsets.all(16),
                                      child: NewTermsconditions11Widget(),
                                    );
                                  },
                                );
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: 'I agree to the ',
                                  style: GoogleFonts.inter(fontSize: 12.5, color: const Color(0xFF64748B)),
                                  children: [
                                    TextSpan(
                                      text: 'Terms & Conditions',
                                      style: GoogleFonts.inter(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFFEE7B4D),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    const TextSpan(text: ' *'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24.0),

                      // Confirm Ride Booking Button
                      SizedBox(
                        width: double.infinity,
                        height: 52.0,
                        child: ElevatedButton(
                          onPressed: _isSubmitting ? null : _submitRideBooking,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEE7B4D),
                            disabledBackgroundColor: const Color(0xFFCBD5E1),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                            shadowColor: const Color(0xFFEE7B4D).withValues(alpha: 0.3),
                          ),
                          child: _isSubmitting
                              ? const SizedBox(
                                  width: 24.0,
                                  height: 24.0,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 20.0),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      'Confirm Ride Booking',
                                      style: GoogleFonts.inter(
                                        fontSize: 15.5,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
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
    );
  }

  Widget _buildBookingForPill({
    required String label,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF4ED) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected ? const Color(0xFFEE7B4D) : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                  color: isSelected ? const Color(0xFFEE7B4D) : const Color(0xFF94A3B8),
                  size: 17.0,
                ),
                const SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 13.0,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                      color: isSelected ? const Color(0xFF111827) : const Color(0xFF475569),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.only(left: 23.0),
              child: Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 11.0,
                  color: isSelected ? const Color(0xFFEE7B4D) : const Color(0xFF94A3B8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required FocusNode focusNode,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    List<dynamic>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
          child: Row(
            crossAxisAlignment: maxLines > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: maxLines > 1 ? 10.0 : 0.0),
                child: Icon(icon, color: const Color(0xFF94A3B8), size: 19.0),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  maxLines: maxLines,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters?.cast(),
                  style: GoogleFonts.inter(fontSize: 13.5, color: const Color(0xFF1E293B)),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: GoogleFonts.inter(fontSize: 13.0, color: const Color(0xFF94A3B8)),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
