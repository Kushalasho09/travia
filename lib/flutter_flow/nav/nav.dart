import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => appStateNotifier.loggedIn
          ? SelectBidTypeWidget()
          : PhoneNumberLoginWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.loggedIn
              ? SelectBidTypeWidget()
              : PhoneNumberLoginWidget(),
        ),
        FFRoute(
          name: SelectBidTypeWidget.routeName,
          path: SelectBidTypeWidget.routePath,
          builder: (context, params) => SelectBidTypeWidget(),
        ),
        FFRoute(
          name: TCPagesWidget.routeName,
          path: TCPagesWidget.routePath,
          builder: (context, params) => TCPagesWidget(
            categoryRef: params.getParam(
              'categoryRef',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: PageSevenWidget.routeName,
          path: PageSevenWidget.routePath,
          builder: (context, params) => PageSevenWidget(),
        ),
        FFRoute(
          name: PageNotificationWidget.routeName,
          path: PageNotificationWidget.routePath,
          builder: (context, params) => PageNotificationWidget(),
        ),
        FFRoute(
          name: DriveProfileWidget.routeName,
          path: DriveProfileWidget.routePath,
          builder: (context, params) => DriveProfileWidget(),
        ),
        FFRoute(
          name: EditprofileWidget.routeName,
          path: EditprofileWidget.routePath,
          builder: (context, params) => EditprofileWidget(),
        ),
        FFRoute(
          name: SupportPageWidget.routeName,
          path: SupportPageWidget.routePath,
          builder: (context, params) => SupportPageWidget(),
        ),
        FFRoute(
          name: EditMarketPlaceDriverWidget.routeName,
          path: EditMarketPlaceDriverWidget.routePath,
          builder: (context, params) => EditMarketPlaceDriverWidget(
            editMarketPlace: params.getParam(
              'editMarketPlace',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['marketPlace'],
            ),
          ),
        ),
        FFRoute(
          name: BookingsDriverWidget.routeName,
          path: BookingsDriverWidget.routePath,
          builder: (context, params) => BookingsDriverWidget(),
        ),
        FFRoute(
          name: RideLocation1Widget.routeName,
          path: RideLocation1Widget.routePath,
          builder: (context, params) => RideLocation1Widget(),
        ),
        FFRoute(
          name: RideStartDateTime2Widget.routeName,
          path: RideStartDateTime2Widget.routePath,
          builder: (context, params) => RideStartDateTime2Widget(),
        ),
        FFRoute(
          name: RideEndDateTime3Widget.routeName,
          path: RideEndDateTime3Widget.routePath,
          builder: (context, params) => RideEndDateTime3Widget(),
        ),
        FFRoute(
          name: Pansanger5BWidget.routeName,
          path: Pansanger5BWidget.routePath,
          builder: (context, params) => Pansanger5BWidget(),
        ),
        FFRoute(
          name: ParcelCost6Widget.routeName,
          path: ParcelCost6Widget.routePath,
          builder: (context, params) => ParcelCost6Widget(),
        ),
        FFRoute(
          name: ListofItems4Widget.routeName,
          path: ListofItems4Widget.routePath,
          builder: (context, params) => ListofItems4Widget(),
        ),
        FFRoute(
          name: TransportMode4Widget.routeName,
          path: TransportMode4Widget.routePath,
          builder: (context, params) => TransportMode4Widget(),
        ),
        FFRoute(
          name: TravelTime6Widget.routeName,
          path: TravelTime6Widget.routePath,
          builder: (context, params) => TravelTime6Widget(),
        ),
        FFRoute(
          name: RuleRide8Widget.routeName,
          path: RuleRide8Widget.routePath,
          builder: (context, params) => RuleRide8Widget(),
        ),
        FFRoute(
          name: RuleRide8BWidget.routeName,
          path: RuleRide8BWidget.routePath,
          builder: (context, params) => RuleRide8BWidget(),
        ),
        FFRoute(
          name: DriverDetail10Widget.routeName,
          path: DriverDetail10Widget.routePath,
          builder: (context, params) => DriverDetail10Widget(),
        ),
        FFRoute(
          name: Areyousure12Widget.routeName,
          path: Areyousure12Widget.routePath,
          builder: (context, params) => Areyousure12Widget(),
        ),
        FFRoute(
          name: RideEditPageWidget.routeName,
          path: RideEditPageWidget.routePath,
          builder: (context, params) => RideEditPageWidget(
            rideEdit: params.getParam(
              'rideEdit',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['RidesNew'],
            ),
          ),
        ),
        FFRoute(
          name: RideEditPageCopyWidget.routeName,
          path: RideEditPageCopyWidget.routePath,
          builder: (context, params) => RideEditPageCopyWidget(),
        ),
        FFRoute(
          name: CaryItems5Widget.routeName,
          path: CaryItems5Widget.routePath,
          builder: (context, params) => CaryItems5Widget(),
        ),
        FFRoute(
          name: MarketRideWidget.routeName,
          path: MarketRideWidget.routePath,
          builder: (context, params) => MarketRideWidget(),
        ),
        FFRoute(
          name: MarketRide2Widget.routeName,
          path: MarketRide2Widget.routePath,
          builder: (context, params) => MarketRide2Widget(),
        ),
        FFRoute(
          name: MarketRide3Widget.routeName,
          path: MarketRide3Widget.routePath,
          builder: (context, params) => MarketRide3Widget(),
        ),
        FFRoute(
          name: Stoppage7Widget.routeName,
          path: Stoppage7Widget.routePath,
          builder: (context, params) => Stoppage7Widget(),
        ),
        FFRoute(
          name: PersonalKYCWidget.routeName,
          path: PersonalKYCWidget.routePath,
          builder: (context, params) => PersonalKYCWidget(),
        ),
        FFRoute(
          name: FaqsWidget.routeName,
          path: FaqsWidget.routePath,
          builder: (context, params) => FaqsWidget(),
        ),
        FFRoute(
          name: CarryItemEditWidget.routeName,
          path: CarryItemEditWidget.routePath,
          builder: (context, params) => CarryItemEditWidget(
            carryItemEdit: params.getParam(
              'carryItemEdit',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['RidesNew'],
            ),
          ),
        ),
        FFRoute(
          name: CarryItemsEdit2Widget.routeName,
          path: CarryItemsEdit2Widget.routePath,
          builder: (context, params) => CarryItemsEdit2Widget(),
        ),
        FFRoute(
          name: RideDetailsCustomerWidget.routeName,
          path: RideDetailsCustomerWidget.routePath,
          builder: (context, params) => RideDetailsCustomerWidget(
            rideDetails: params.getParam(
              'rideDetails',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['RidesNew'],
            ),
          ),
        ),
        FFRoute(
          name: SendParcelWidget.routeName,
          path: SendParcelWidget.routePath,
          builder: (context, params) => SendParcelWidget(
            bookingKarnaHai: params.getParam(
              'bookingKarnaHai',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['RidesNew'],
            ),
          ),
        ),
        FFRoute(
          name: MarketPlaceCustomerWidget.routeName,
          path: MarketPlaceCustomerWidget.routePath,
          builder: (context, params) => MarketPlaceCustomerWidget(
            tabNumberRef: params.getParam(
              'tabNumberRef',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: EditBookingsWidget.routeName,
          path: EditBookingsWidget.routePath,
          builder: (context, params) => EditBookingsWidget(
            editBookings: params.getParam(
              'editBookings',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['bookings'],
            ),
          ),
        ),
        FFRoute(
          name: CustomerWalletWidget.routeName,
          path: CustomerWalletWidget.routePath,
          builder: (context, params) => CustomerWalletWidget(),
        ),
        FFRoute(
          name: MarketPlaceBookingWidget.routeName,
          path: MarketPlaceBookingWidget.routePath,
          builder: (context, params) => MarketPlaceBookingWidget(
            showCustomerMarketPlaceRef: params.getParam(
              'showCustomerMarketPlaceRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['marketPlace'],
            ),
          ),
        ),
        FFRoute(
          name: MarketPlaceBidYourRateWidget.routeName,
          path: MarketPlaceBidYourRateWidget.routePath,
          builder: (context, params) => MarketPlaceBidYourRateWidget(
            marketPlaceBids: params.getParam(
              'marketPlaceBids',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['marketPlace'],
            ),
          ),
        ),
        FFRoute(
          name: PhoneNumberLoginWidget.routeName,
          path: PhoneNumberLoginWidget.routePath,
          builder: (context, params) => PhoneNumberLoginWidget(),
        ),
        FFRoute(
          name: VerifyOTPWidget.routeName,
          path: VerifyOTPWidget.routePath,
          builder: (context, params) => VerifyOTPWidget(),
        ),
        FFRoute(
          name: AddFundWidget.routeName,
          path: AddFundWidget.routePath,
          builder: (context, params) => AddFundWidget(),
        ),
        FFRoute(
          name: PostRideSelectWidget.routeName,
          path: PostRideSelectWidget.routePath,
          builder: (context, params) => PostRideSelectWidget(),
        ),
        FFRoute(
          name: PlansWidget.routeName,
          path: PlansWidget.routePath,
          builder: (context, params) => PlansWidget(),
        ),
        FFRoute(
          name: HomeWidget.routeName,
          path: HomeWidget.routePath,
          builder: (context, params) => HomeWidget(
            tabNumberRef: params.getParam(
              'tabNumberRef',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: SearchRideWidget.routeName,
          path: SearchRideWidget.routePath,
          builder: (context, params) => SearchRideWidget(
            query1: params.getParam(
              'query1',
              ParamType.String,
            ),
            query2: params.getParam(
              'query2',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: SavedRidesWidget.routeName,
          path: SavedRidesWidget.routePath,
          builder: (context, params) => SavedRidesWidget(),
        ),
        FFRoute(
          name: BIdsPostedByUsersWidget.routeName,
          path: BIdsPostedByUsersWidget.routePath,
          builder: (context, params) => BIdsPostedByUsersWidget(),
        ),
        FFRoute(
          name: SearchMarketPlaceWidget.routeName,
          path: SearchMarketPlaceWidget.routePath,
          builder: (context, params) => SearchMarketPlaceWidget(
            searchQuery1: params.getParam(
              'searchQuery1',
              ParamType.String,
            ),
            searchQuery2: params.getParam(
              'searchQuery2',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: KksjfkafWidget.routeName,
          path: KksjfkafWidget.routePath,
          builder: (context, params) => KksjfkafWidget(),
        ),
        FFRoute(
          name: MarketPlaceOrdersWidget.routeName,
          path: MarketPlaceOrdersWidget.routePath,
          builder: (context, params) => MarketPlaceOrdersWidget(
            marketPlaceRef: params.getParam(
              'marketPlaceRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['marketPlace'],
            ),
          ),
        ),
        FFRoute(
          name: SetProfileImageWidget.routeName,
          path: SetProfileImageWidget.routePath,
          builder: (context, params) => SetProfileImageWidget(),
        ),
        FFRoute(
          name: DriverReviewWidget.routeName,
          path: DriverReviewWidget.routePath,
          builder: (context, params) => DriverReviewWidget(
            userRef: params.getParam(
              'userRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Users'],
            ),
          ),
        ),
        FFRoute(
          name: AddRatingWidget.routeName,
          path: AddRatingWidget.routePath,
          builder: (context, params) => AddRatingWidget(
            userRef: params.getParam(
              'userRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Users'],
            ),
          ),
        ),
        FFRoute(
          name: BookRideWidget.routeName,
          path: BookRideWidget.routePath,
          builder: (context, params) => BookRideWidget(
            rideID: params.getParam(
              'rideID',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['RidesNew'],
            ),
          ),
        ),
        FFRoute(
          name: RideBookingSentWidget.routeName,
          path: RideBookingSentWidget.routePath,
          builder: (context, params) => RideBookingSentWidget(),
        ),
        FFRoute(
          name: ChatUsersWidget.routeName,
          path: ChatUsersWidget.routePath,
          builder: (context, params) => ChatUsersWidget(),
        ),
        FFRoute(
          name: ChatWidget.routeName,
          path: ChatWidget.routePath,
          builder: (context, params) => ChatWidget(
            reciveChats: params.getParam(
              'reciveChats',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Chats'],
            ),
          ),
        ),
        FFRoute(
          name: FirstWidget.routeName,
          path: FirstWidget.routePath,
          builder: (context, params) => FirstWidget(),
        ),
        FFRoute(
          name: SecondWidget.routeName,
          path: SecondWidget.routePath,
          builder: (context, params) => SecondWidget(),
        ),
        FFRoute(
          name: ThirdWidget.routeName,
          path: ThirdWidget.routePath,
          builder: (context, params) => ThirdWidget(),
        ),
        FFRoute(
          name: FourthWidget.routeName,
          path: FourthWidget.routePath,
          builder: (context, params) => FourthWidget(),
        ),
        FFRoute(
          name: WhatyouCarry5Widget.routeName,
          path: WhatyouCarry5Widget.routePath,
          builder: (context, params) => WhatyouCarry5Widget(),
        ),
        FFRoute(
          name: DriverDetail6Widget.routeName,
          path: DriverDetail6Widget.routePath,
          builder: (context, params) => DriverDetail6Widget(),
        ),
        FFRoute(
          name: RideRules7Widget.routeName,
          path: RideRules7Widget.routePath,
          builder: (context, params) => RideRules7Widget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/phoneNumberLogin';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: FlutterFlowTheme.of(context).otherColour,
                  child: Image.asset(
                    'assets/images/Untitled_design_(1).gif',
                    fit: BoxFit.contain,
                  ),
                )
              : PushNotificationsHandler(child: page);

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
