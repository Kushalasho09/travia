import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: FlutterFlowTheme.of(context).otherColour,
          child: Image.asset(
            'assets/images/Untitled_design_(1).gif',
            fit: BoxFit.contain,
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'Select_Bid_Type': ParameterData.none(),
  'TCPages': (data) async => ParameterData(
        allParams: {
          'categoryRef': getParameter<String>(data, 'categoryRef'),
        },
      ),
  'Page_seven': ParameterData.none(),
  'Page_Notification': ParameterData.none(),
  'Drive_Profile': ParameterData.none(),
  'editprofile': ParameterData.none(),
  'Support_Page': ParameterData.none(),
  'editMarketPlaceDriver': (data) async => ParameterData(
        allParams: {
          'editMarketPlace':
              getParameter<DocumentReference>(data, 'editMarketPlace'),
        },
      ),
  'BookingsDriver': ParameterData.none(),
  'RideLocation1': ParameterData.none(),
  'RideStartDateTime2': ParameterData.none(),
  'RideEndDateTime3': ParameterData.none(),
  'pansanger5B': ParameterData.none(),
  'parcelCost6': ParameterData.none(),
  'ListofItems4': ParameterData.none(),
  'transportMode4': ParameterData.none(),
  'travelTime6': ParameterData.none(),
  'ruleRide8': ParameterData.none(),
  'ruleRide8B': ParameterData.none(),
  'driverDetail10': ParameterData.none(),
  'Areyousure12': ParameterData.none(),
  'RideEditPage': (data) async => ParameterData(
        allParams: {
          'rideEdit': getParameter<DocumentReference>(data, 'rideEdit'),
        },
      ),
  'RideEditPageCopy': ParameterData.none(),
  'caryItems5': ParameterData.none(),
  'marketRide': ParameterData.none(),
  'marketRide2': ParameterData.none(),
  'marketRide3': ParameterData.none(),
  'Stoppage7': ParameterData.none(),
  'personal_KYC': ParameterData.none(),
  'faqs': ParameterData.none(),
  'carryItemEdit': (data) async => ParameterData(
        allParams: {
          'carryItemEdit':
              getParameter<DocumentReference>(data, 'carryItemEdit'),
        },
      ),
  'CarryItemsEdit2': ParameterData.none(),
  'RideDetailsCustomer': (data) async => ParameterData(
        allParams: {
          'rideDetails': getParameter<DocumentReference>(data, 'rideDetails'),
        },
      ),
  'SendParcel': (data) async => ParameterData(
        allParams: {
          'bookingKarnaHai':
              getParameter<DocumentReference>(data, 'bookingKarnaHai'),
        },
      ),
  'Market_Place_Customer': (data) async => ParameterData(
        allParams: {
          'tabNumberRef': getParameter<int>(data, 'tabNumberRef'),
        },
      ),
  'EditBookings': (data) async => ParameterData(
        allParams: {
          'editBookings': getParameter<DocumentReference>(data, 'editBookings'),
        },
      ),
  'CustomerWallet': ParameterData.none(),
  'MarketPlaceBooking': (data) async => ParameterData(
        allParams: {
          'showCustomerMarketPlaceRef': getParameter<DocumentReference>(
              data, 'showCustomerMarketPlaceRef'),
        },
      ),
  'MarketPlaceBidYourRate': (data) async => ParameterData(
        allParams: {
          'marketPlaceBids':
              getParameter<DocumentReference>(data, 'marketPlaceBids'),
        },
      ),
  'phoneNumberLogin': ParameterData.none(),
  'VerifyOTP': ParameterData.none(),
  'AddFund': ParameterData.none(),
  'PostRideSelect': ParameterData.none(),
  'Plans': ParameterData.none(),
  'Home': (data) async => ParameterData(
        allParams: {
          'tabNumberRef': getParameter<int>(data, 'tabNumberRef'),
        },
      ),
  'SearchRide': (data) async => ParameterData(
        allParams: {
          'query1': getParameter<String>(data, 'query1'),
          'query2': getParameter<String>(data, 'query2'),
        },
      ),
  'SavedRides': ParameterData.none(),
  'BIdsPostedByUsers': ParameterData.none(),
  'searchMarketPlace': (data) async => ParameterData(
        allParams: {
          'searchQuery1': getParameter<String>(data, 'searchQuery1'),
          'searchQuery2': getParameter<String>(data, 'searchQuery2'),
        },
      ),
  'kksjfkaf': ParameterData.none(),
  'MarketPlaceOrders': (data) async => ParameterData(
        allParams: {
          'marketPlaceRef':
              getParameter<DocumentReference>(data, 'marketPlaceRef'),
        },
      ),
  'SetProfileImage': ParameterData.none(),
  'DriverReview': (data) async => ParameterData(
        allParams: {
          'userRef': getParameter<DocumentReference>(data, 'userRef'),
        },
      ),
  'AddRating': (data) async => ParameterData(
        allParams: {
          'userRef': getParameter<DocumentReference>(data, 'userRef'),
        },
      ),
  'BookRide': (data) async => ParameterData(
        allParams: {
          'rideID': getParameter<DocumentReference>(data, 'rideID'),
        },
      ),
  'RideBookingSent': ParameterData.none(),
  'ChatUsers': ParameterData.none(),
  'chat': (data) async => ParameterData(
        allParams: {
          'reciveChats': getParameter<DocumentReference>(data, 'reciveChats'),
        },
      ),
  'first': ParameterData.none(),
  'second': ParameterData.none(),
  'third': ParameterData.none(),
  'fourth': ParameterData.none(),
  'whatyouCarry5': ParameterData.none(),
  'driverDetail6': ParameterData.none(),
  'rideRules7': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
