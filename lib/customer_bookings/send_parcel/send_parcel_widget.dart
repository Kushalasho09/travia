import 'package:travia/compotement/termsconditions11/termsconditions11_widget.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/bid_posted_thanks_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'send_parcel_model.dart';
export 'send_parcel_model.dart';

class SendParcelWidget extends StatefulWidget {
  const SendParcelWidget({
    super.key,
    required this.bookingKarnaHai,
  });

  final DocumentReference? bookingKarnaHai;

  static String routeName = 'SendParcel';
  static String routePath = '/sendParcel';

  @override
  State<SendParcelWidget> createState() => _SendParcelWidgetState();
}

class _SendParcelWidgetState extends State<SendParcelWidget> {
  late SendParcelModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SendParcelModel());

    _model.itemNameTextController ??= TextEditingController();
    _model.itemNameFocusNode ??= FocusNode();

    _model.reciverNameTextController ??= TextEditingController(text: currentUserDisplayName);
    _model.reciverNameFocusNode ??= FocusNode();

    _model.phoneNumberTextController ??= TextEditingController(text: currentPhoneNumber);
    _model.phoneNumberFocusNode ??= FocusNode();

    _model.addressTextController ??= TextEditingController();
    _model.addressFocusNode ??= FocusNode();

    _model.additionalInformationTextController ??= TextEditingController();
    _model.additionalInformationFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _submitParcelBooking(RidesNewRecord rideRecord) async {
    final itemName = _model.itemNameTextController?.text.trim() ?? '';
    final receiverName = _model.reciverNameTextController?.text.trim() ?? '';
    final phone = _model.phoneNumberTextController?.text.trim() ?? '';
    final address = _model.addressTextController?.text.trim() ?? '';
    final isChecked = _model.checkboxValue ?? false;

    if (itemName.isEmpty) {
      _showWarningDialog('Please describe the parcel/items you wish to send.');
      return;
    }
    if (receiverName.isEmpty) {
      _showWarningDialog('Please enter the recipient\'s name.');
      return;
    }
    if (phone.isEmpty) {
      _showWarningDialog('Please enter the contact phone number.');
      return;
    }
    if (address.isEmpty) {
      _showWarningDialog('Please select the meetup/drop-off address.');
      return;
    }
    if (!isChecked) {
      _showWarningDialog('Please accept the Terms and Conditions to proceed.');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // 1. Create booking in Firestore
      await BookingsRecord.collection.doc().set(createBookingsRecordData(
            itemName: itemName,
            receiverName: receiverName,
            phoneNumber: phone,
            meetupLocation: address,
            meetupLocationMap: _model.meetupLocationMap,
            additionalInformation: _model.additionalInformationTextController?.text.trim() ?? '',
            createdTime: getCurrentTimestamp,
            creator: currentUserReference,
            rideID: rideRecord.reference,
            status: 'Pending',
            bookingType: 'Parcel',
          ));

      // 2. Send push notification to driver
      try {
        final driverRef = rideRecord.creatorID;
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
                'message': 'A customer requested to send a parcel on your ride!',
                'chatId': '',
              });
            }
          }
        }
      } catch (e) {
        // Non-fatal error
      }

      // 3. Show thank you dialog & navigate
      if (mounted) {
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (dialogContext) {
            return const Dialog(
              elevation: 0,
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              child: BidPostedThanksWidget(),
            );
          },
        );

        if (mounted) {
          context.goNamed(
            HomeWidget.routeName,
            queryParameters: {
              'tabNumberRef': serializeParam(1, ParamType.int),
            }.withoutNulls,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        _showWarningDialog('Failed to book parcel: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
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

  @override
  Widget build(BuildContext context) {
    if (widget.bookingKarnaHai == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF111827)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Send Parcel', style: GoogleFonts.inter(color: const Color(0xFF111827), fontWeight: FontWeight.bold)),
        ),
        body: Center(
          child: Text('Ride details not found', style: GoogleFonts.inter(color: const Color(0xFF64748B))),
        ),
      );
    }

    return StreamBuilder<RidesNewRecord>(
      stream: RidesNewRecord.getDocument(widget.bookingKarnaHai!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            backgroundColor: Color(0xFFF8FAFC),
            body: Center(
              child: SizedBox(
                width: 44.0,
                height: 44.0,
                child: SpinKitFadingCircle(
                  color: Color(0xFFEE7B4D),
                  size: 40.0,
                ),
              ),
            ),
          );
        }

        final rideRecord = snapshot.data!;

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
                'Send Parcel',
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
                    // Trip Summary Card
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
                                    const Icon(Icons.local_shipping_outlined, color: Color(0xFFEE7B4D), size: 14.0),
                                    const SizedBox(width: 5.0),
                                    Text(
                                      'Parcel Delivery',
                                      style: GoogleFonts.inter(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFFEE7B4D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (rideRecord.totalDeliveryCost.isNotEmpty)
                                Text(
                                  '₹${rideRecord.totalDeliveryCost}',
                                  style: GoogleFonts.inter(
                                    fontSize: 18.0,
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
                                      rideRecord.rideStartLocation.isNotEmpty ? rideRecord.rideStartLocation : 'Pickup Location',
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
                                      rideRecord.rideEndLocation.isNotEmpty ? rideRecord.rideEndLocation : 'Destination Location',
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

                          if (rideRecord.pickupTime != null) ...[
                            const SizedBox(height: 12.0),
                            const Divider(height: 1.0, color: Color(0xFFF1F5F9)),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                const Icon(Icons.schedule_rounded, size: 15.0, color: Color(0xFF64748B)),
                                const SizedBox(width: 6.0),
                                Text(
                                  'Departure: ${dateTimeFormat("MMM d, yyyy  •  jm", rideRecord.pickupTime!)}',
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
                    ),
                    const SizedBox(height: 18.0),

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
                          // Section 1: Item Details
                          Text(
                            'Parcel Details',
                            style: GoogleFonts.inter(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF111827),
                            ),
                          ),
                          const SizedBox(height: 12.0),

                          _buildFormField(
                            label: 'Item Description *',
                            hint: 'e.g. Documents, Clothes, Small Box',
                            controller: _model.itemNameTextController!,
                            focusNode: _model.itemNameFocusNode!,
                            icon: Icons.inventory_2_outlined,
                          ),
                          const SizedBox(height: 14.0),

                          _buildFormField(
                            label: 'Additional Information (Optional)',
                            hint: 'Weight, size, or special instructions...',
                            controller: _model.additionalInformationTextController!,
                            focusNode: _model.additionalInformationFocusNode!,
                            icon: Icons.notes_rounded,
                            maxLines: 2,
                          ),

                          const SizedBox(height: 20.0),
                          const Divider(height: 1.0, color: Color(0xFFE2E8F0)),
                          const SizedBox(height: 18.0),

                          // Section 2: Recipient Details
                          Text(
                            'Recipient Information',
                            style: GoogleFonts.inter(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF111827),
                            ),
                          ),
                          const SizedBox(height: 12.0),

                          _buildFormField(
                            label: 'Recipient Full Name *',
                            hint: 'Name of person receiving the parcel',
                            controller: _model.reciverNameTextController!,
                            focusNode: _model.reciverNameFocusNode!,
                            icon: Icons.person_outline_rounded,
                          ),
                          const SizedBox(height: 14.0),

                          _buildFormField(
                            label: 'Contact Phone Number *',
                            hint: 'Recipient phone number',
                            controller: _model.phoneNumberTextController!,
                            focusNode: _model.phoneNumberFocusNode!,
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                          ),

                          const SizedBox(height: 20.0),
                          const Divider(height: 1.0, color: Color(0xFFE2E8F0)),
                          const SizedBox(height: 18.0),

                          // Section 3: Meetup / Pickup Address
                          Text(
                            'Meetup / Handover Address *',
                            style: GoogleFonts.inter(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF111827),
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            'Where will you handover the parcel to the driver?',
                            style: GoogleFonts.inter(
                              fontSize: 12.0,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 10.0),

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
                                    focusNode: _model.addressFocusNode,
                                    textEditingController: _model.addressTextController!,
                                    googleAPIKey: "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
                                    boxDecoration: const BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    containerHorizontalPadding: 0,
                                    containerVerticalPadding: 0,
                                    inputDecoration: InputDecoration(
                                      hintText: 'Search pickup address or landmark...',
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
                                      _model.addressTextController!.text = prediction.description ?? "";
                                      _model.addressTextController!.selection = TextSelection.fromPosition(
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

                          const SizedBox(height: 20.0),
                          const Divider(height: 1.0, color: Color(0xFFE2E8F0)),
                          const SizedBox(height: 16.0),

                          // Terms and Conditions Checkbox
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 22.0,
                                height: 22.0,
                                child: Checkbox(
                                  value: _model.checkboxValue ??= false,
                                  activeColor: const Color(0xFFEE7B4D),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                                  side: BorderSide(
                                    color: (_model.checkboxValue ?? false) ? const Color(0xFFEE7B4D) : const Color(0xFF94A3B8),
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

                          // Confirm Booking Button
                          SizedBox(
                            width: double.infinity,
                            height: 52.0,
                            child: ElevatedButton(
                              onPressed: _isSubmitting ? null : () => _submitParcelBooking(rideRecord),
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
                                          'Confirm Parcel Booking',
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
      },
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
