import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'driver_review_model.dart';
export 'driver_review_model.dart';

class DriverReviewWidget extends StatefulWidget {
  const DriverReviewWidget({
    super.key,
    required this.userRef,
  });

  final DocumentReference? userRef;

  static String routeName = 'DriverReview';
  static String routePath = '/driverReview';

  @override
  State<DriverReviewWidget> createState() => _DriverReviewWidgetState();
}

class _DriverReviewWidgetState extends State<DriverReviewWidget> {
  late DriverReviewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedFilter = 'All Reviews';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DriverReviewModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
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
            'Driver Reviews',
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

        final driverReviewUsersRecord = snapshot.data!;
        final ratingsList = driverReviewUsersRecord.ratings.toList();
        final double avgRating = functions.averageRating(ratingsList) ?? 0.0;
        final int totalReviewsCount = ratingsList.length;
        final String displayRatingStr = avgRating > 0 ? avgRating.toStringAsFixed(1) : '5.0';

        final String driverName = (driverReviewUsersRecord.displayName.trim().isNotEmpty)
            ? driverReviewUsersRecord.displayName.trim()
            : (driverReviewUsersRecord.userName.trim().isNotEmpty
                ? driverReviewUsersRecord.userName.trim()
                : (driverReviewUsersRecord.phoneNumber.trim().isNotEmpty
                    ? driverReviewUsersRecord.phoneNumber.trim()
                    : 'Driver'));

        final bool isAadhaarVerified = driverReviewUsersRecord.aadharFront.isNotEmpty ||
            driverReviewUsersRecord.aadharNumber > 0 ||
            driverReviewUsersRecord.isVerifed;
        final bool isMobileVerified = driverReviewUsersRecord.phoneNumber.trim().isNotEmpty;
        final bool isVerifiedUser = isAadhaarVerified ||
            isMobileVerified ||
            driverReviewUsersRecord.isVerifed ||
            driverReviewUsersRecord.isProfileCompleted;

        // Rating breakdown calculations
        final int star5Count = ratingsList.where((r) => r >= 4.5).length;
        final int star4Count = ratingsList.where((r) => r >= 3.5 && r < 4.5).length;
        final int star3Count = ratingsList.where((r) => r >= 2.5 && r < 3.5).length;
        final int star2Count = ratingsList.where((r) => r >= 1.5 && r < 2.5).length;
        final int star1Count = ratingsList.where((r) => r < 1.5).length;

        final double star5Pct = totalReviewsCount > 0 ? star5Count / totalReviewsCount : (avgRating >= 4.5 ? 1.0 : 0.0);
        final double star4Pct = totalReviewsCount > 0 ? star4Count / totalReviewsCount : 0.0;
        final double star3Pct = totalReviewsCount > 0 ? star3Count / totalReviewsCount : 0.0;
        final double star2Pct = totalReviewsCount > 0 ? star2Count / totalReviewsCount : 0.0;
        final double star1Pct = totalReviewsCount > 0 ? star1Count / totalReviewsCount : 0.0;

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
                'Driver Reviews',
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
                        left: 14.0, right: 14.0, top: 12.0, bottom: 90.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // =================== SECTION 1: HERO HEADER CARD ===================
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
                          child: Column(
                            children: [
                              // Top User Row
                              Row(
                                children: [
                                  // Avatar with Checkmark Badge
                                  Stack(
                                    children: [
                                      Container(
                                        width: 76.0,
                                        height: 76.0,
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
                                            if (driverReviewUsersRecord.photoUrl.trim().isNotEmpty) {
                                              return Image.network(
                                                driverReviewUsersRecord.photoUrl,
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
                                            width: 22.0,
                                            height: 22.0,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF10B981),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.check_rounded,
                                              color: Colors.white,
                                              size: 14.0,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(width: 14.0),
                                  // User Details Column
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          driverName,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
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
                                              size: 18.0,
                                            ),
                                            const SizedBox(width: 4.0),
                                            Text(
                                              displayRatingStr,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
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
                                        // Verified Traveler Pill
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 3.0),
                                          decoration: BoxDecoration(
                                            color: isVerifiedUser
                                                ? const Color(0xFF065F46).withOpacity(0.6)
                                                : const Color(0xFF1E293B),
                                            borderRadius: BorderRadius.circular(12.0),
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
                                                size: 12.0,
                                              ),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                isVerifiedUser ? 'Verified Driver' : 'Community Driver',
                                                style: TextStyle(
                                                  color: isVerifiedUser
                                                      ? const Color(0xFF34D399)
                                                      : const Color(0xFF94A3B8),
                                                  fontSize: 10.5,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 6.0),
                                        // Security Badges
                                        Row(
                                          children: [
                                            Icon(
                                              isAadhaarVerified
                                                  ? Icons.shield_rounded
                                                  : Icons.shield_outlined,
                                              color: isAadhaarVerified
                                                  ? const Color(0xFF34D399)
                                                  : const Color(0xFF94A3B8),
                                              size: 12.0,
                                            ),
                                            const SizedBox(width: 3.0),
                                            Text(
                                              isAadhaarVerified ? 'Aadhaar Verified' : 'Aadhaar Pending',
                                              style: TextStyle(
                                                color: isAadhaarVerified ? Colors.white70 : Colors.white38,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            const Text(
                                              '   |   ',
                                              style: TextStyle(
                                                color: Colors.white38,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            Icon(
                                              isMobileVerified
                                                  ? Icons.phone_iphone_rounded
                                                  : Icons.phone_android_outlined,
                                              color: isMobileVerified
                                                  ? const Color(0xFF60A5FA)
                                                  : const Color(0xFF94A3B8),
                                              size: 12.0,
                                            ),
                                            const SizedBox(width: 3.0),
                                            Text(
                                              isMobileVerified ? 'Mobile Verified' : 'Mobile Pending',
                                              style: TextStyle(
                                                color: isMobileVerified ? Colors.white70 : Colors.white38,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 14.0),
                              Divider(color: Colors.white.withOpacity(0.12), height: 1.0),
                              const SizedBox(height: 12.0),

                              // Bottom Stats Bar (4 Dynamic Columns)
                              FutureBuilder<int>(
                                future: queryRidesNewRecordCount(
                                  queryBuilder: (q) => q.where('creatorID', isEqualTo: driverReviewUsersRecord.reference),
                                ),
                                builder: (context, ridesSnapshot) {
                                  final int tripsCount = ridesSnapshot.data ?? 0;

                                  return FutureBuilder<int>(
                                    future: queryMarketPlaceRecordCount(
                                      queryBuilder: (q) => q.where('postedBy', isEqualTo: driverReviewUsersRecord.reference),
                                    ),
                                    builder: (context, marketSnapshot) {
                                      final int deliveriesCount = marketSnapshot.data ?? 0;
                                      final String scoreStr = totalReviewsCount > 0
                                          ? (avgRating >= 4.0 ? '98%' : '${((avgRating / 5.0) * 100).toInt()}%')
                                          : '100%';

                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          _buildStatColumn(
                                            icon: Icons.card_travel_rounded,
                                            iconColor: const Color(0xFF60A5FA),
                                            bgColor: const Color(0xFF1E3A5F),
                                            value: '$tripsCount',
                                            label: 'Trips Listed',
                                          ),
                                          _buildStatColumn(
                                            icon: Icons.inventory_2_outlined,
                                            iconColor: const Color(0xFFF59E0B),
                                            bgColor: const Color(0xFF3B2D1B),
                                            value: '$deliveriesCount',
                                            label: 'Deliveries',
                                          ),
                                          _buildStatColumn(
                                            icon: Icons.access_time_filled_rounded,
                                            iconColor: const Color(0xFF34D399),
                                            bgColor: const Color(0xFF133E36),
                                            value: scoreStr,
                                            label: 'Score',
                                          ),
                                          _buildStatColumn(
                                            icon: Icons.people_alt_rounded,
                                            iconColor: const Color(0xFFA78BFA),
                                            bgColor: const Color(0xFF2E2349),
                                            value: '$totalReviewsCount',
                                            label: 'Reviews',
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14.0),

                        // =================== SECTION 2: BREAKDOWN GRID (2 CARDS) ===================
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Card: Overall Rating Breakdown
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14.0),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Overall Rating',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0F172A),
                                      ),
                                    ),
                                    const SizedBox(height: 6.0),
                                    Row(
                                      children: [
                                        Text(
                                          displayRatingStr,
                                          style: const TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF0F172A),
                                          ),
                                        ),
                                        const SizedBox(width: 6.0),
                                        RatingBarIndicator(
                                          itemBuilder: (context, index) => const Icon(
                                            Icons.star_rounded,
                                            color: Color(0xFFF59E0B),
                                          ),
                                          direction: Axis.horizontal,
                                          rating: avgRating > 0 ? avgRating : 5.0,
                                          unratedColor: const Color(0xFFE2E8F0),
                                          itemCount: 5,
                                          itemSize: 13.0,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Based on $totalReviewsCount ${totalReviewsCount == 1 ? "review" : "reviews"}',
                                      style: const TextStyle(
                                        fontSize: 9.5,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),

                                    // Dynamic Rating Progress Bars
                                    _buildRatingProgressRow(stars: 5, count: star5Count, flexPct: star5Pct),
                                    _buildRatingProgressRow(stars: 4, count: star4Count, flexPct: star4Pct),
                                    _buildRatingProgressRow(stars: 3, count: star3Count, flexPct: star3Pct),
                                    _buildRatingProgressRow(stars: 2, count: star2Count, flexPct: star2Pct),
                                    _buildRatingProgressRow(stars: 1, count: star1Count, flexPct: star1Pct),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            // Right Card: What people love about him
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14.0),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Driver Highlights',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0F172A),
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Wrap(
                                      spacing: 5.0,
                                      runSpacing: 5.0,
                                      children: const [
                                        _LoveTag(icon: Icons.shield_outlined, text: 'Safe Driver'),
                                        _LoveTag(icon: Icons.inventory_2_outlined, text: 'Careful Handling'),
                                        _LoveTag(icon: Icons.sentiment_satisfied_alt_rounded, text: 'Friendly'),
                                        _LoveTag(icon: Icons.access_time_rounded, text: 'On Time'),
                                        _LoveTag(icon: Icons.chat_bubble_outline_rounded, text: 'Clear Comm.'),
                                        _LoveTag(icon: Icons.directions_car_rounded, text: 'Clean Vehicle'),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    const Text(
                                      'Based on traveler feedback',
                                      style: TextStyle(
                                        fontSize: 9.0,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14.0),

                        // =================== SECTION 3: FILTER & SORT BAR ===================
                        Row(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    _buildFilterChip('All Reviews'),
                                    const SizedBox(width: 6.0),
                                    _buildFilterChip('5 Stars'),
                                    const SizedBox(width: 6.0),
                                    _buildFilterChip('4+ Stars'),
                                    const SizedBox(width: 6.0),
                                    _buildFilterChip('Recent'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14.0),

                        // =================== SECTION 4: REVIEWS LIST ===================
                        StreamBuilder<List<ReviewRecord>>(
                          stream: queryReviewRecord(
                            parent: driverReviewUsersRecord.reference,
                            queryBuilder: (reviewRecord) => reviewRecord
                                .orderBy('dateCreated', descending: true),
                          ),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: SizedBox(
                                  width: 40.0,
                                  height: 40.0,
                                  child: SpinKitFadingCircle(
                                    color: Color(0xFF0F2537),
                                    size: 40.0,
                                  ),
                                ),
                              );
                            }
                            List<ReviewRecord> rawReviews = snapshot.data!;

                            // Apply filters
                            List<ReviewRecord> listViewReviewRecordList = rawReviews.where((r) {
                              if (_selectedFilter == '5 Stars') {
                                return r.rating >= 4.5;
                              } else if (_selectedFilter == '4+ Stars') {
                                return r.rating >= 3.5;
                              }
                              return true;
                            }).toList();

                            if (listViewReviewRecordList.isEmpty) {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 20.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14.0),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 56.0,
                                      height: 56.0,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF1F5F9),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.rate_review_outlined,
                                        size: 28.0,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Text(
                                      'No Reviews Yet',
                                      style: GoogleFonts.inter(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                    const SizedBox(height: 6.0),
                                    Text(
                                      'This driver hasn\'t received any reviews yet. Be the first to share your experience!',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: 12.5,
                                        color: const Color(0xFF64748B),
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: listViewReviewRecordList.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 12.0),
                              itemBuilder: (context, listViewIndex) {
                                final listViewReviewRecord =
                                    listViewReviewRecordList[listViewIndex];

                                if (listViewReviewRecord.userRef == null) {
                                  return _buildReviewCard(
                                    reviewerName: 'Verified User',
                                    reviewerPhoto: '',
                                    isVerified: true,
                                    rating: listViewReviewRecord.rating,
                                    dateCreated: listViewReviewRecord.dateCreated,
                                    reviewText: listViewReviewRecord.review,
                                  );
                                }

                                return StreamBuilder<UsersRecord>(
                                  stream: UsersRecord.getDocument(
                                      listViewReviewRecord.userRef!),
                                  builder: (context, snapshot) {
                                    final containerUsersRecord = snapshot.data;
                                    final reviewerName = (containerUsersRecord?.displayName.trim().isNotEmpty == true)
                                        ? containerUsersRecord!.displayName.trim()
                                        : (containerUsersRecord?.userName.trim().isNotEmpty == true
                                            ? containerUsersRecord!.userName.trim()
                                            : 'Verified User');
                                    final reviewerPhoto = containerUsersRecord?.photoUrl ?? '';
                                    final bool isReviewerVerified = containerUsersRecord?.isVerifed == true ||
                                        containerUsersRecord?.isProfileCompleted == true;

                                    return _buildReviewCard(
                                      reviewerName: reviewerName,
                                      reviewerPhoto: reviewerPhoto,
                                      isVerified: isReviewerVerified,
                                      rating: listViewReviewRecord.rating,
                                      dateCreated: listViewReviewRecord.dateCreated,
                                      reviewText: listViewReviewRecord.review,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // =================== SECTION 5: STICKY BOTTOM BUTTON ===================
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
                            onTap: () async {
                              await context.pushNamed(
                                AddRatingWidget.routeName,
                                queryParameters: {
                                  'userRef': serializeParam(
                                    driverReviewUsersRecord.reference,
                                    ParamType.DocumentReference,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.edit_note_rounded,
                                    color: Colors.white,
                                    size: 22.0,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Write a Review',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
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

  // =================== HELPER BUILDERS ===================

  Widget _buildReviewCard({
    required String reviewerName,
    required String reviewerPhoto,
    required bool isVerified,
    required double rating,
    required DateTime? dateCreated,
    required String reviewText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reviewer Header Row
          Row(
            children: [
              Container(
                width: 38.0,
                height: 38.0,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: reviewerPhoto.isNotEmpty
                    ? Image.network(
                        reviewerPhoto,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset('assets/images/userIconTr.png', fit: BoxFit.cover),
                      )
                    : Image.asset(
                        'assets/images/userIconTr.png',
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            reviewerName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        if (isVerified) ...[
                          const SizedBox(width: 6.0),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 2.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0FDF4),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: const Color(0xFFDCFCE7)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: Color(0xFF10B981),
                                  size: 10.0,
                                ),
                                SizedBox(width: 2.0),
                                Text(
                                  'Verified User',
                                  style: TextStyle(
                                    color: Color(0xFF0F766E),
                                    fontSize: 9.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2.0),
                    Row(
                      children: [
                        RatingBarIndicator(
                          itemBuilder: (context, index) => const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFF59E0B),
                          ),
                          direction: Axis.horizontal,
                          rating: rating > 0 ? rating : 5.0,
                          unratedColor: const Color(0xFFCBD5E1),
                          itemCount: 5,
                          itemSize: 13.0,
                        ),
                        if (dateCreated != null) ...[
                          const SizedBox(width: 6.0),
                          Text(
                            '•  ${dateTimeFormat("relative", dateCreated)}',
                            style: const TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (reviewText.isNotEmpty) ...[
            const SizedBox(height: 8.0),
            Text(
              reviewText,
              style: const TextStyle(
                fontSize: 12.0,
                height: 1.35,
                color: Color(0xFF334155),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatColumn({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String value,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: iconColor, size: 16.0),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 8.5,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingProgressRow({
    required int stars,
    required int count,
    required double flexPct,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            '$stars ★',
            style: const TextStyle(
              fontSize: 10.0,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4.0),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: LinearProgressIndicator(
                value: flexPct.clamp(0.0, 1.0),
                minHeight: 5.0,
                backgroundColor: const Color(0xFFF1F5F9),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
              ),
            ),
          ),
          const SizedBox(width: 6.0),
          SizedBox(
            width: 14.0,
            child: Text(
              '$count',
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 10.0,
                color: Color(0xFF64748B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final bool isSelected = _selectedFilter == label;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      borderRadius: BorderRadius.circular(20.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F2537) : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: isSelected ? const Color(0xFF0F2537) : const Color(0xFFCBD5E1),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF475569),
          ),
        ),
      ),
    );
  }
}

class _LoveTag extends StatelessWidget {
  const _LoveTag({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFFDCFCE7)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF0F766E), size: 10.0),
          const SizedBox(width: 3.0),
          Text(
            text,
            style: const TextStyle(
              fontSize: 9.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F766E),
            ),
          ),
        ],
      ),
    );
  }
}
