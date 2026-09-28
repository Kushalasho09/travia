import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

enum TraviaPlanTier {
  dayPass24h,
  monthlyPass,
  vip3Months,
}

class TraviaPlanItem {
  final TraviaPlanTier tier;
  final String id;
  final String title;
  final String durationLabel;
  final Duration duration;
  final int priceInr;
  final String priceDisplay;
  final String perMonthDisplay;
  final String? badge;
  final String? savings;
  final String subtitle;
  final int rideLimit; // -1 means unlimited
  final int marketplaceLimit; // -1 means unlimited
  final String rideQuotaText;
  final String marketplaceQuotaText;
  final Color accentColor;
  final Color bgColor;
  final Color borderColor;
  final IconData icon;

  const TraviaPlanItem({
    required this.tier,
    required this.id,
    required this.title,
    required this.durationLabel,
    required this.duration,
    required this.priceInr,
    required this.priceDisplay,
    required this.perMonthDisplay,
    this.badge,
    this.savings,
    required this.subtitle,
    required this.rideLimit,
    required this.marketplaceLimit,
    required this.rideQuotaText,
    required this.marketplaceQuotaText,
    required this.accentColor,
    required this.bgColor,
    required this.borderColor,
    required this.icon,
  });
}

const List<TraviaPlanItem> kTraviaBlueprintPlans = [
  // 1. HOT IMPULSE PASS (₹29)
  TraviaPlanItem(
    tier: TraviaPlanTier.dayPass24h,
    id: '24_hour_pass',
    title: '24-Hour Day Pass',
    durationLabel: '24 Hours VIP Access',
    duration: Duration(hours: 24),
    priceInr: 29,
    priceDisplay: '₹29',
    perMonthDisplay: '₹29 / 24 Hours',
    badge: 'HOT IMPULSE PASS',
    savings: null,
    subtitle: '5 Rides (Book & Publish) + 5 Marketplace Parcel Posts',
    rideLimit: 5,
    marketplaceLimit: 5,
    rideQuotaText: '5 Rides (Book & Publish)',
    marketplaceQuotaText: '5 Parcel Posts / Requests',
    accentColor: Color(0xFFEE7B4D),
    bgColor: Color(0xFFFFF5ED),
    borderColor: Color(0xFFFED7AA),
    icon: Icons.flash_on_rounded,
  ),

  // 2. 1-MONTH FREQUENT PASS (₹199)
  TraviaPlanItem(
    tier: TraviaPlanTier.monthlyPass,
    id: 'monthly_pass',
    title: '1-Month Frequent Pass',
    durationLabel: '30 Days Access',
    duration: Duration(days: 30),
    priceInr: 199,
    priceDisplay: '₹199',
    perMonthDisplay: '₹6.6 / day',
    badge: 'MOST POPULAR',
    savings: 'Commuter Choice',
    subtitle: 'UNLIMITED Rides + 15 Marketplace Parcel Posts',
    rideLimit: -1,
    marketplaceLimit: 15,
    rideQuotaText: 'UNLIMITED Rides (Book & Publish)',
    marketplaceQuotaText: '15 Parcel Posts / month',
    accentColor: Color(0xFF6C7EE8),
    bgColor: Color(0xFFF0ECFD),
    borderColor: Color(0xFFE2DBFC),
    icon: Icons.workspace_premium_rounded,
  ),

  // 3. 3-MONTH VIP PASS (₹499)
  TraviaPlanItem(
    tier: TraviaPlanTier.vip3Months,
    id: 'vip_3m',
    title: '3-Month VIP Pass',
    durationLabel: '90 Days VIP Access',
    duration: Duration(days: 90),
    priceInr: 499,
    priceDisplay: '₹499',
    perMonthDisplay: '₹166 / month',
    badge: 'BEST VALUE (40% OFF)',
    savings: 'Save 40%',
    subtitle: '100% UNLIMITED Rides + UNLIMITED Marketplace Parcels',
    rideLimit: -1,
    marketplaceLimit: -1,
    rideQuotaText: 'UNLIMITED Rides (Zero Caps)',
    marketplaceQuotaText: 'UNLIMITED Marketplace & Parcels',
    accentColor: Color(0xFF10D4A0),
    bgColor: Color(0xFFEBF9F5),
    borderColor: Color(0xFFB9F0E1),
    icon: Icons.diamond_rounded,
  ),
];

class RazorpayService {
  // Toggle this to TRUE for Live Mode, FALSE for Test Mode
  static bool isLiveMode = false;

  // Test Key ID (Used for testing / development)
  static const String testKeyId = 'rzp_test_TeL5T7XX1QCJ13';
  
  // Live Key ID (Paste your Razorpay Live Key ID starting with rzp_live_...)
  static String liveKeyId = '';

  static String get activeKeyId {
    if (isLiveMode && liveKeyId.isNotEmpty) {
      return liveKeyId;
    }
    return testKeyId;
  }

  static bool get isUsingLiveMode => isLiveMode && liveKeyId.isNotEmpty;

  late Razorpay _razorpay;

  void initialize({
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onError,
    required Function(ExternalWalletResponse) onExternalWallet,
  }) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);
  }

  void dispose() {
    _razorpay.clear();
  }

  bool openCheckout({
    required TraviaPlanItem plan,
    required String userPhone,
    required String userEmail,
    required String userName,
  }) {
    final cleanPhone = userPhone.replaceAll(RegExp(r'[^0-9]'), '');
    final phone10Digits = cleanPhone.length > 10 ? cleanPhone.substring(cleanPhone.length - 10) : cleanPhone;

    var options = {
      'key': activeKeyId,
      'amount': plan.priceInr * 100, // Amount in paise (₹29 = 2900 paise)
      'name': 'Travia',
      'description': '${plan.title} (${plan.durationLabel})',
      'prefill': {
        'contact': phone10Digits,
        'email': userEmail.isNotEmpty ? userEmail : 'user@travia.com',
        'name': userName.isNotEmpty ? userName : 'Travia Traveler',
      },
      'theme': {
        'color': '#EE7B4D', // Travia brand orange
      },
      'send_sms_hash': true,
      'external': {
        'wallets': ['paytm', 'phonepe']
      }
    };

    try {
      _razorpay.open(options);
      return true;
    } catch (e) {
      debugPrint('Razorpay checkout error: $e');
      return false;
    }
  }
}

class SubscriptionUtil {
  /// Check if user has an active, non-expired subscription
  static bool isUserSubscribed(Map<String, dynamic>? userData) {
    if (userData == null) return false;

    final isPremium = userData['is_premium'] == true || userData['isPremium'] == true;
    if (!isPremium) return false;

    final expiresAtTimestamp = userData['subscription_expires_at'] as Timestamp?;
    if (expiresAtTimestamp == null) {
      // Legacy premium fallback without expiry timestamp
      return isPremium;
    }

    final expiresAt = expiresAtTimestamp.toDate();
    return DateTime.now().isBefore(expiresAt);
  }

  /// Check if user has 1 free welcome ride remaining
  static bool hasFreeRideRemaining(Map<String, dynamic>? userData) {
    if (userData == null) return true;
    final freeRidesUsed = (userData['free_rides_used'] as num?)?.toInt() ?? 0;
    return freeRidesUsed < 1;
  }

  /// Human-readable remaining subscription duration
  static String getRemainingTimeLabel(DateTime? expiresAt) {
    if (expiresAt == null) return 'Active';
    final diff = expiresAt.difference(DateTime.now());
    if (diff.isNegative) return 'Expired';

    if (diff.inDays > 1) {
      final hours = diff.inHours % 24;
      return hours > 0 ? '${diff.inDays}d ${hours}h left' : '${diff.inDays} days left';
    } else if (diff.inHours >= 1) {
      final mins = diff.inMinutes % 60;
      return mins > 0 ? '${diff.inHours}h ${mins}m left' : '${diff.inHours} hours left';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} mins left';
    } else {
      return '< 1 min left';
    }
  }

  /// Check if user has ride quota remaining to book or publish a ride
  static bool canUserBookRide(Map<String, dynamic>? userData) {
    if (!isUserSubscribed(userData)) return false;
    final rideLimit = (userData?['rides_limit'] as num?)?.toInt() ?? -1;
    if (rideLimit == -1) return true; // Unlimited
    final ridesUsed = (userData?['rides_used_in_period'] as num?)?.toInt() ?? 0;
    return ridesUsed < rideLimit;
  }

  /// Check if user has marketplace quota remaining to post or request a parcel
  static bool canUserPostMarketplace(Map<String, dynamic>? userData) {
    if (!isUserSubscribed(userData)) return false;
    final mpLimit = (userData?['marketplace_limit'] as num?)?.toInt() ?? -1;
    if (mpLimit == -1) return true; // Unlimited
    final mpUsed = (userData?['marketplace_used_in_period'] as num?)?.toInt() ?? 0;
    return mpUsed < mpLimit;
  }

  /// Get remaining rides count display string
  static String getRemainingRidesLabel(Map<String, dynamic>? userData) {
    if (!isUserSubscribed(userData)) return '0 Rides';
    final limit = (userData?['rides_limit'] as num?)?.toInt() ?? -1;
    if (limit == -1) return 'Unlimited';
    final used = (userData?['rides_used_in_period'] as num?)?.toInt() ?? 0;
    final remaining = (limit - used).clamp(0, limit);
    return '$remaining / $limit left';
  }

  /// Get remaining marketplace posts count display string
  static String getRemainingMarketplaceLabel(Map<String, dynamic>? userData) {
    if (!isUserSubscribed(userData)) return '0 Posts';
    final limit = (userData?['marketplace_limit'] as num?)?.toInt() ?? -1;
    if (limit == -1) return 'Unlimited';
    final used = (userData?['marketplace_used_in_period'] as num?)?.toInt() ?? 0;
    final remaining = (limit - used).clamp(0, limit);
    return '$remaining / $limit left';
  }
}

