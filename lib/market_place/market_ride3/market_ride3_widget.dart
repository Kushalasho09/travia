import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/thank_you_market_place_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'market_ride3_model.dart';
export 'market_ride3_model.dart';

class MarketRide3Widget extends StatefulWidget {
  const MarketRide3Widget({super.key});

  static String routeName = 'marketRide3';
  static String routePath = '/marketRide3';

  @override
  State<MarketRide3Widget> createState() => _MarketRide3WidgetState();
}

class _MarketRide3WidgetState extends State<MarketRide3Widget> {
  late MarketRide3Model _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isPublishing = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MarketRide3Model());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _uploadProductImage() async {
    final selectedMedia = await selectMediaWithSourceBottomSheet(
      context: context,
      maxWidth: 600.0,
      maxHeight: 600.0,
      imageQuality: 90,
      allowPhoto: true,
    );

    if (selectedMedia != null && selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
      if (!mounted) return;
      setState(() => _model.isDataUploading_uploadDataCdwjvinsuh = true);

      try {
        showUploadMessage(context, 'Uploading image...', showLoading: true);

        final selectedUploadedFiles = selectedMedia
            .map((m) => FFUploadedFile(
                  name: m.storagePath.split('/').last,
                  bytes: m.bytes,
                  height: m.dimensions?.height,
                  width: m.dimensions?.width,
                  blurHash: m.blurHash,
                  originalFilename: m.originalFilename,
                ))
            .toList();

        final downloadUrls = (await Future.wait(
          selectedMedia.map((m) async => await uploadData(m.storagePath, m.bytes)),
        ))
            .where((u) => u != null)
            .map((u) => u!)
            .toList();

        if (selectedUploadedFiles.length == selectedMedia.length && downloadUrls.length == selectedMedia.length) {
          setState(() {
            _model.uploadedLocalFile_uploadDataCdwjvinsuh = selectedUploadedFiles.first;
            _model.uploadedFileUrl_uploadDataCdwjvinsuh = downloadUrls.first;
          });
          if (mounted) showUploadMessage(context, 'Photo uploaded successfully!');
        } else {
          if (mounted) showUploadMessage(context, 'Failed to upload photo.');
        }
      } finally {
        if (mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          setState(() => _model.isDataUploading_uploadDataCdwjvinsuh = false);
        }
      }
    }
  }

  Future<void> _publishMarketplaceItem() async {
    if (_isPublishing) return;

    if (_model.uploadedFileUrl_uploadDataCdwjvinsuh.isEmpty) {
      showDialog(
        context: context,
        builder: (alertDialogContext) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(
            'Photo Required',
            style: GoogleFonts.inter(fontSize: 17.0, fontWeight: FontWeight.w700),
          ),
          content: Text(
            'Please upload a clear photo of the product you are listing before publishing.',
            style: GoogleFonts.inter(fontSize: 13.5, color: const Color(0xFF475569)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(alertDialogContext),
              child: Text(
                'Got It',
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFEE7B4D),
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }

    setState(() => _isPublishing = true);

    try {
      await MarketPlaceRecord.collection.doc().set(
        createMarketPlaceRecordData(
          productName: FFAppState().NameoftheProducts,
          origin: FFAppState().origin,
          destination: FFAppState().destination,
          descriptionItem: FFAppState().Descriptionoftheitem,
          quantity: FFAppState().quantity,
          price: FFAppState().price,
          postedBy: currentUserReference,
          imageOfproduct: _model.uploadedFileUrl_uploadDataCdwjvinsuh,
          arivalDate: FFAppState().marketPlaceAriveDate,
          status: 'Under Review',
        ),
      );

      if (!mounted) return;

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          Future.delayed(const Duration(milliseconds: 2800), () {
            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop();
            }
            if (mounted) {
              context.goNamed(
                MarketPlaceCustomerWidget.routeName,
                queryParameters: {
                  'tabNumberRef': serializeParam(2, ParamType.int),
                }.withoutNulls,
              );
            }
          });

          return const Dialog(
            backgroundColor: Colors.transparent,
            child: ThankYouMarketPlaceWidget(),
          );
        },
      );
    } catch (e) {
      debugPrint('Error publishing marketplace ride: $e');
    } finally {
      if (mounted) setState(() => _isPublishing = false);
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => context.safePop(),
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    width: 38.0,
                    height: 38.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12.0),
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
            ),
          ),
          title: Text(
            'Review & Publish',
            style: GoogleFonts.inter(
              fontSize: 16.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: InkWell(
                  onTap: () => context.pushNamed(DriveProfileWidget.routeName),
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                    ),
                    child: ClipOval(
                      child: currentUserPhoto.isNotEmpty
                          ? Image.network(
                              currentUserPhoto,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Image.asset(
                                'assets/images/userIconTr.png',
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              'assets/images/userIconTr.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Stepper Header
              _buildStepperHeader(),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Title
                      Text(
                        'Review & Upload Photo',
                        style: GoogleFonts.inter(
                          fontSize: 21.0,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Check your listing details and add a photo of your product.',
                        style: GoogleFonts.inter(
                          fontSize: 13.0,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // Listing Summary Card
                      Container(
                        padding: const EdgeInsets.all(18.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x06000000),
                              blurRadius: 12.0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header with Product Name & Price Badge
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    FFAppState().NameoftheProducts.isNotEmpty
                                        ? FFAppState().NameoftheProducts
                                        : 'Marketplace Product',
                                    style: GoogleFonts.inter(
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF111827),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF5ED),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: const Color(0xFFFED7AA)),
                                  ),
                                  child: Text(
                                    '₹ ${FFAppState().price}',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFFEE7B4D),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6.0),

                            // Quantity Chip
                            if (FFAppState().quantity.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  'Quantity: ${FFAppState().quantity}',
                                  style: GoogleFonts.inter(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF475569),
                                  ),
                                ),
                              ),

                            const SizedBox(height: 14.0),
                            const Divider(height: 1.0, color: Color(0xFFF1F5F9)),
                            const SizedBox(height: 14.0),

                            // Route Display
                            Row(
                              children: [
                                const Icon(Icons.trip_origin_rounded, color: Color(0xFF10D4A0), size: 16.0),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    FFAppState().origin.isNotEmpty ? FFAppState().origin : 'Pickup Location',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF1E293B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 7.0),
                              child: Container(
                                width: 2.0,
                                height: 16.0,
                                color: const Color(0xFFCBD5E1),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on_rounded, color: Color(0xFFEE7B4D), size: 16.0),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    FFAppState().destination.isNotEmpty ? FFAppState().destination : 'Delivery Location',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF1E293B),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            if (FFAppState().marketPlaceAriveDate != null) ...[
                              const SizedBox(height: 14.0),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.schedule_rounded, size: 16.0, color: Color(0xFF64748B)),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      'Arrival: ${dateTimeFormat('yMMMd', FFAppState().marketPlaceAriveDate!)} at ${dateTimeFormat('jm', FFAppState().marketPlaceAriveDate!)}',
                                      style: GoogleFonts.inter(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF475569),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],

                            if (FFAppState().Descriptionoftheitem.isNotEmpty) ...[
                              const SizedBox(height: 12.0),
                              Text(
                                '"${FFAppState().Descriptionoftheitem}"',
                                style: GoogleFonts.inter(
                                  fontSize: 12.5,
                                  fontStyle: FontStyle.italic,
                                  color: const Color(0xFF64748B),
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: 24.0),

                      // Photo Upload Card
                      Text(
                        'Product Photo *',
                        style: GoogleFonts.inter(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _model.isDataUploading_uploadDataCdwjvinsuh ? null : _uploadProductImage,
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            width: double.infinity,
                            height: 190.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: _model.uploadedFileUrl_uploadDataCdwjvinsuh.isNotEmpty
                                    ? const Color(0xFF10D4A0)
                                    : const Color(0xFFCBD5E1),
                                width: 1.5,
                              ),
                            ),
                            child: _model.isDataUploading_uploadDataCdwjvinsuh
                                ? const Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircularProgressIndicator(color: Color(0xFFEE7B4D), strokeWidth: 2.5),
                                        SizedBox(height: 12.0),
                                        Text('Uploading photo...'),
                                      ],
                                    ),
                                  )
                                : _model.uploadedFileUrl_uploadDataCdwjvinsuh.isNotEmpty
                                    ? Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(18.0),
                                            child: Image.network(
                                              _model.uploadedFileUrl_uploadDataCdwjvinsuh,
                                              fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) => const Center(
                                                child: Icon(Icons.broken_image_rounded, size: 40.0, color: Color(0xFF94A3B8)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 10.0,
                                            right: 10.0,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withValues(alpha: 0.65),
                                                borderRadius: BorderRadius.circular(16.0),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(Icons.edit_rounded, color: Colors.white, size: 14.0),
                                                  const SizedBox(width: 4.0),
                                                  Text(
                                                    'Change',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 11.5,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 10.0,
                                            left: 10.0,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF10D4A0),
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(Icons.check_circle_rounded, color: Colors.white, size: 14.0),
                                                  const SizedBox(width: 4.0),
                                                  Text(
                                                    'Photo Attached',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 11.0,
                                                      fontWeight: FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 54.0,
                                            height: 54.0,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFFFF5ED),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.add_a_photo_outlined,
                                              color: Color(0xFFEE7B4D),
                                              size: 26.0,
                                            ),
                                          ),
                                          const SizedBox(height: 12.0),
                                          Text(
                                            'Tap to upload product photo',
                                            style: GoogleFonts.inter(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF1E293B),
                                            ),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Text(
                                            'JPG or PNG from Camera or Gallery (Max 5MB)',
                                            style: GoogleFonts.inter(
                                              fontSize: 11.5,
                                              color: const Color(0xFF94A3B8),
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
              ),

              // Bottom Fixed Action Bar
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 12.0,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SizedBox(
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
                      onPressed: _isPublishing ? null : _publishMarketplaceItem,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: _isPublishing
                          ? const SizedBox(
                              width: 22.0,
                              height: 22.0,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Post Marketplace Item',
                                  style: GoogleFonts.inter(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                const Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Colors.white,
                                  size: 19.0,
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepperHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step 3 of 3',
                style: GoogleFonts.inter(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFEE7B4D),
                ),
              ),
              Text(
                'Photos & Publish',
                style: GoogleFonts.inter(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEE7B4D),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              const SizedBox(width: 6.0),
              Expanded(
                child: Container(
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEE7B4D),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              const SizedBox(width: 6.0),
              Expanded(
                child: Container(
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEE7B4D),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
