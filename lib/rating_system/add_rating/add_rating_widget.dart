import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_rating_model.dart';
export 'add_rating_model.dart';

class AddRatingWidget extends StatefulWidget {
  const AddRatingWidget({
    super.key,
    required this.userRef,
  });

  final DocumentReference? userRef;

  static String routeName = 'AddRating';
  static String routePath = '/addRating';

  @override
  State<AddRatingWidget> createState() => _AddRatingWidgetState();
}

class _AddRatingWidgetState extends State<AddRatingWidget> {
  late AddRatingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Set<String> _selectedCompliments = {};
  bool _isSubmitting = false;

  final List<Map<String, dynamic>> _complimentsList = const [
    {'icon': Icons.shield_outlined, 'text': 'Safe Driver'},
    {'icon': Icons.inventory_2_outlined, 'text': 'Careful Handling'},
    {'icon': Icons.sentiment_satisfied_alt_rounded, 'text': 'Friendly & Polite'},
    {'icon': Icons.access_time_rounded, 'text': 'Always On Time'},
    {'icon': Icons.chat_bubble_outline_rounded, 'text': 'Clear Communication'},
    {'icon': Icons.directions_car_rounded, 'text': 'Clean Vehicle'},
    {'icon': Icons.music_note_rounded, 'text': 'Comfortable Ride'},
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddRatingModel());
    _model.reviewWordsTextController ??= TextEditingController();
    _model.reviewWordsFocusNode ??= FocusNode();
    _model.ratingBarValue = 5.0; // Default to 5 stars
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  String _getRatingLabel(double rating) {
    if (rating >= 5.0) return 'Outstanding Experience! 😍';
    if (rating >= 4.0) return 'Very Good Ride! 😊';
    if (rating >= 3.0) return 'Good / Satisfactory 🙂';
    if (rating >= 2.0) return 'Below Expectations 😐';
    if (rating >= 1.0) return 'Poor Experience 😞';
    return 'Tap the stars to rate';
  }

  Color _getRatingColor(double rating) {
    if (rating >= 4.5) return const Color(0xFF10B981);
    if (rating >= 3.5) return const Color(0xFF0D9488);
    if (rating >= 2.5) return const Color(0xFFF59E0B);
    if (rating >= 1.5) return const Color(0xFFF97316);
    return const Color(0xFFEF4444);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userRef == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            buttonSize: 50.0,
            icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0F172A), size: 24.0),
            onPressed: () => context.pop(),
          ),
          title: const Text(
            'Rate Driver',
            style: TextStyle(color: Color(0xFF0F172A), fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('User details not available', style: TextStyle(color: Color(0xFF64748B))),
        ),
      );
    }

    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget.userRef!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            body: const Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: SpinKitFadingCircle(
                  color: Color(0xFF0F2537),
                  size: 50.0,
                ),
              ),
            ),
          );
        }

        final addRatingUsersRecord = snapshot.data!;
        final ratingsList = addRatingUsersRecord.ratings.toList();
        final double avgRating = functions.averageRating(ratingsList) ?? 0.0;
        final int totalReviewsCount = ratingsList.length;
        final String displayRatingStr = avgRating > 0 ? avgRating.toStringAsFixed(1) : '5.0';

        final String driverName = (addRatingUsersRecord.displayName.trim().isNotEmpty)
            ? addRatingUsersRecord.displayName.trim()
            : (addRatingUsersRecord.userName.trim().isNotEmpty
                ? addRatingUsersRecord.userName.trim()
                : (addRatingUsersRecord.phoneNumber.trim().isNotEmpty
                    ? addRatingUsersRecord.phoneNumber.trim()
                    : 'Driver'));

        final bool isAadhaarVerified = addRatingUsersRecord.aadharFront.isNotEmpty ||
            addRatingUsersRecord.aadharNumber > 0 ||
            addRatingUsersRecord.isVerifed;
        final bool isMobileVerified = addRatingUsersRecord.phoneNumber.trim().isNotEmpty;
        final bool isVerifiedUser = isAadhaarVerified ||
            isMobileVerified ||
            addRatingUsersRecord.isVerifed ||
            addRatingUsersRecord.isProfileCompleted;

        final double currentRating = _model.ratingBarValue ?? 5.0;

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
              elevation: 0.5,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 50.0,
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xFF0F172A),
                  size: 24.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: const Text(
                'Rate Driver',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    color: Color(0xFF0F172A),
                    size: 22.0,
                  ),
                  onPressed: () {},
                ),
              ],
              centerTitle: true,
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 14.0, bottom: 90.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // =================== SECTION 1: HERO DRIVER CARD ===================
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0B2135),
                            borderRadius: BorderRadius.circular(18.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 10.0,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              // Avatar with Checkmark Badge
                              Stack(
                                children: [
                                  Container(
                                    width: 68.0,
                                    height: 68.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.2),
                                        width: 2.0,
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Builder(
                                      builder: (context) {
                                        if (addRatingUsersRecord.photoUrl.trim().isNotEmpty) {
                                          return Image.network(
                                            addRatingUsersRecord.photoUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) =>
                                                Image.asset('assets/images/userIconTr.png', fit: BoxFit.cover),
                                          );
                                        }
                                        return Image.asset(
                                          'assets/images/userIconTr.png',
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                  if (isVerifiedUser)
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        width: 20.0,
                                        height: 20.0,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF10B981),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.check_rounded,
                                          color: Colors.white,
                                          size: 13.0,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(width: 14.0),
                              // Driver Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      driverName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star_rounded,
                                          color: Color(0xFFF59E0B),
                                          size: 17.0,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          displayRatingStr,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          '($totalReviewsCount ${totalReviewsCount == 1 ? "Review" : "Reviews"})',
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6.0),
                                    // Verification status tag
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7.0, vertical: 2.5),
                                      decoration: BoxDecoration(
                                        color: isVerifiedUser
                                            ? const Color(0xFF065F46).withOpacity(0.6)
                                            : const Color(0xFF1E293B),
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: isVerifiedUser
                                              ? const Color(0xFF10B981).withOpacity(0.4)
                                              : const Color(0xFF475569),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            isVerifiedUser
                                                ? Icons.check_circle_rounded
                                                : Icons.shield_outlined,
                                            color: isVerifiedUser
                                                ? const Color(0xFF34D399)
                                                : const Color(0xFF94A3B8),
                                            size: 11.0,
                                          ),
                                          const SizedBox(width: 3.0),
                                          Text(
                                            isVerifiedUser ? 'Verified Driver' : 'Community Driver',
                                            style: TextStyle(
                                              color: isVerifiedUser
                                                  ? const Color(0xFF34D399)
                                                  : const Color(0xFF94A3B8),
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16.0),

                        // =================== SECTION 2: INTERACTIVE STAR RATING CARD ===================
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 6.0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'How was your experience?',
                                style: GoogleFonts.inter(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                'Tap the stars below to give your rating',
                                style: GoogleFonts.inter(
                                  fontSize: 12.0,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 16.0),

                              // Interactive Rating Bar
                              RatingBar.builder(
                                initialRating: _model.ratingBarValue ?? 5.0,
                                minRating: 1.0,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                                itemSize: 42.0,
                                unratedColor: const Color(0xFFE2E8F0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star_rounded,
                                  color: Color(0xFFF59E0B),
                                ),
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    _model.ratingBarValue = rating;
                                  });
                                },
                              ),
                              const SizedBox(height: 12.0),

                              // Dynamic Feedback Badge
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                  color: _getRatingColor(currentRating).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    color: _getRatingColor(currentRating).withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  _getRatingLabel(currentRating),
                                  style: GoogleFonts.inter(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: _getRatingColor(currentRating),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16.0),

                        // =================== SECTION 3: QUICK COMPLIMENT TAGS ===================
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 6.0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.thumb_up_alt_outlined,
                                    size: 18.0,
                                    color: Color(0xFF0D9488),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    'What did you like most?',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                'Select highlights that describe your trip',
                                style: GoogleFonts.inter(
                                  fontSize: 11.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 12.0),

                              Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: _complimentsList.map((item) {
                                  final String text = item['text'] as String;
                                  final IconData icon = item['icon'] as IconData;
                                  final bool isSelected = _selectedCompliments.contains(text);

                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (isSelected) {
                                          _selectedCompliments.remove(text);
                                        } else {
                                          _selectedCompliments.add(text);
                                        }
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 150),
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFF0D9488)
                                            : const Color(0xFFF8FAFC),
                                        borderRadius: BorderRadius.circular(12.0),
                                        border: Border.all(
                                          color: isSelected
                                              ? const Color(0xFF0D9488)
                                              : const Color(0xFFE2E8F0),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            icon,
                                            size: 13.0,
                                            color: isSelected ? Colors.white : const Color(0xFF0D9488),
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            text,
                                            style: GoogleFonts.inter(
                                              fontSize: 11.5,
                                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                              color: isSelected ? Colors.white : const Color(0xFF334155),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16.0),

                        // =================== SECTION 4: DETAILED REVIEW INPUT CARD ===================
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 6.0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.edit_note_rounded,
                                    size: 19.0,
                                    color: Color(0xFF0D9488),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    'Write your review (optional)',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                controller: _model.reviewWordsTextController,
                                focusNode: _model.reviewWordsFocusNode,
                                autofocus: false,
                                textCapitalization: TextCapitalization.sentences,
                                textInputAction: TextInputAction.done,
                                maxLines: 4,
                                minLines: 4,
                                style: GoogleFonts.inter(
                                  fontSize: 13.5,
                                  color: const Color(0xFF0F172A),
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Share more details about punctuality, driving safety, vehicle cleanliness, etc...',
                                  hintStyle: GoogleFonts.inter(
                                    fontSize: 12.5,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFF8FAFC),
                                  contentPadding: const EdgeInsets.all(14.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFE2E8F0),
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF0D9488),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // =================== SECTION 5: STICKY BOTTOM SUBMIT BUTTON ===================
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10.0,
                            offset: const Offset(0, -3),
                          ),
                        ],
                      ),
                      child: SafeArea(
                        top: false,
                        child: Container(
                          width: double.infinity,
                          height: 52.0,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF0D9488), Color(0xFF059669)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(14.0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF0D9488).withOpacity(0.3),
                                blurRadius: 8.0,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14.0),
                            onTap: _isSubmitting
                                ? null
                                : () async {
                                    final ratingVal = _model.ratingBarValue;
                                    if (ratingVal == null || ratingVal <= 0) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Please select a star rating first.'),
                                          backgroundColor: Color(0xFFEF4444),
                                        ),
                                      );
                                      return;
                                    }

                                    setState(() {
                                      _isSubmitting = true;
                                    });

                                    try {
                                      String writtenText = _model.reviewWordsTextController?.text.trim() ?? '';
                                      if (_selectedCompliments.isNotEmpty && writtenText.isEmpty) {
                                        writtenText = _selectedCompliments.join(', ');
                                      }

                                      await ReviewRecord.createDoc(widget.userRef!)
                                          .set(createReviewRecordData(
                                        userRef: currentUserReference,
                                        review: writtenText,
                                        rating: ratingVal,
                                        dateCreated: getCurrentTimestamp,
                                      ));

                                      await addRatingUsersRecord.reference.update({
                                        ...mapToFirestore(
                                          {
                                            'ratings': FieldValue.arrayUnion([ratingVal]),
                                          },
                                        ),
                                      });

                                      if (!mounted) return;

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Review submitted successfully! Thank you for your feedback.',
                                          ),
                                          backgroundColor: Color(0xFF0D9488),
                                          duration: Duration(seconds: 3),
                                        ),
                                      );

                                      if (Navigator.of(context).canPop()) {
                                        context.pop();
                                      } else {
                                        context.pushNamed(
                                          HomeWidget.routeName,
                                          queryParameters: {
                                            'tabNumberRef': serializeParam(0, ParamType.int),
                                          }.withoutNulls,
                                        );
                                      }
                                    } catch (e) {
                                      if (!mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Failed to submit review: $e'),
                                          backgroundColor: const Color(0xFFEF4444),
                                        ),
                                      );
                                    } finally {
                                      if (mounted) {
                                        setState(() {
                                          _isSubmitting = false;
                                        });
                                      }
                                    }
                                  },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (_isSubmitting) ...[
                                    const SizedBox(
                                      width: 20.0,
                                      height: 20.0,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.0,
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                  ] else ...[
                                    const Icon(
                                      Icons.send_rounded,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                    const SizedBox(width: 8.0),
                                  ],
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _isSubmitting ? 'Submitting Review...' : 'Submit Review',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        'Share your experience with others',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 9.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
      },
    );
  }
}
