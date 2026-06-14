import 'package:travia/chat_option/chat/chat_widget.dart';
import 'package:travia/chat_option/chat_users/chat_users_widget.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'page_notification_model.dart';
export 'page_notification_model.dart';

// class PageNotificationWidget extends StatefulWidget {
//   const PageNotificationWidget({super.key});
//
//   static String routeName = 'Page_Notification';
//   static String routePath = '/pageNotification';
//
//   @override
//   State<PageNotificationWidget> createState() => _PageNotificationWidgetState();
// }
//
// class _PageNotificationWidgetState extends State<PageNotificationWidget> {
//   late PageNotificationModel _model;
//
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => PageNotificationModel());
//   }
//
//   @override
//   void dispose() {
//     _model.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//         FocusManager.instance.primaryFocus?.unfocus();
//       },
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//         appBar: AppBar(
//           backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
//           automaticallyImplyLeading: false,
//           leading: FlutterFlowIconButton(
//             borderRadius: 20.0,
//             buttonSize: 40.0,
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: FlutterFlowTheme.of(context).primaryText,
//               size: 24.0,
//             ),
//             onPressed: () {
//               print('IconButton pressed ...');
//             },
//           ),
//           title: Text(
//             'Ride Notifications',
//             style: FlutterFlowTheme.of(context).titleLarge.override(
//                   font: GoogleFonts.interTight(
//                     fontWeight: FontWeight.w600,
//                     fontStyle:
//                         FlutterFlowTheme.of(context).titleLarge.fontStyle,
//                   ),
//                   fontSize: 20.0,
//                   letterSpacing: 0.0,
//                   fontWeight: FontWeight.w600,
//                   fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
//                 ),
//           ),
//           actions: [],
//           centerTitle: true,
//           elevation: 0.0,
//         ),
//         body: SafeArea(
//           top: true,
//           child: Padding(
//             padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: FlutterFlowTheme.of(context).secondaryBackground,
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 4.0,
//                           color: Color(0x20000000),
//                           offset: Offset(
//                             0.0,
//                             2.0,
//                           ),
//                         )
//                       ],
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: 48.0,
//                             height: 48.0,
//                             decoration: BoxDecoration(
//                               color: FlutterFlowTheme.of(context).accent1,
//                               borderRadius: BorderRadius.circular(24.0),
//                             ),
//                             child: Align(
//                               alignment: AlignmentDirectional(0.0, 0.0),
//                               child: Icon(
//                                 Icons.local_taxi,
//                                 color: FlutterFlowTheme.of(context).primary,
//                                 size: 24.0,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   12.0, 0.0, 12.0, 0.0),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'Your ride is arriving',
//                                         style: FlutterFlowTheme.of(context)
//                                             .titleSmall
//                                             .override(
//                                               font: GoogleFonts.interTight(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontStyle:
//                                                     FlutterFlowTheme.of(context)
//                                                         .titleSmall
//                                                         .fontStyle,
//                                               ),
//                                               letterSpacing: 0.0,
//                                               fontWeight: FontWeight.w600,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .titleSmall
//                                                       .fontStyle,
//                                             ),
//                                       ),
//                                       Text(
//                                         '2m ago',
//                                         style: FlutterFlowTheme.of(context)
//                                             .labelSmall
//                                             .override(
//                                               font: GoogleFonts.inter(
//                                                 fontWeight:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelSmall
//                                                         .fontWeight,
//                                                 fontStyle:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelSmall
//                                                         .fontStyle,
//                                               ),
//                                               color:
//                                                   FlutterFlowTheme.of(context)
//                                                       .secondaryText,
//                                               letterSpacing: 0.0,
//                                               fontWeight:
//                                                   FlutterFlowTheme.of(context)
//                                                       .labelSmall
//                                                       .fontWeight,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .labelSmall
//                                                       .fontStyle,
//                                             ),
//                                       ),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0.0, 4.0, 0.0, 0.0),
//                                     child: Text(
//                                       'Your driver John is 2 minutes away. Vehicle: Toyota Camry (ABC123)',
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodyMedium
//                                           .override(
//                                             font: GoogleFonts.inter(
//                                               fontWeight:
//                                                   FlutterFlowTheme.of(context)
//                                                       .bodyMedium
//                                                       .fontWeight,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .bodyMedium
//                                                       .fontStyle,
//                                             ),
//                                             color: FlutterFlowTheme.of(context)
//                                                 .secondaryText,
//                                             letterSpacing: 0.0,
//                                             fontWeight:
//                                                 FlutterFlowTheme.of(context)
//                                                     .bodyMedium
//                                                     .fontWeight,
//                                             fontStyle:
//                                                 FlutterFlowTheme.of(context)
//                                                     .bodyMedium
//                                                     .fontStyle,
//                                           ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0.0, 8.0, 0.0, 0.0),
//                                     child: FFButtonWidget(
//                                       onPressed: () {
//                                         print('Button pressed ...');
//                                       },
//                                       text: 'Track ride',
//                                       options: FFButtonOptions(
//                                         width: 100.0,
//                                         height: 32.0,
//                                         padding: EdgeInsets.all(8.0),
//                                         iconPadding:
//                                             EdgeInsetsDirectional.fromSTEB(
//                                                 0.0, 0.0, 0.0, 0.0),
//                                         color: FlutterFlowTheme.of(context)
//                                             .accent1,
//                                         textStyle: FlutterFlowTheme.of(context)
//                                             .labelMedium
//                                             .override(
//                                               font: GoogleFonts.inter(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontStyle:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelMedium
//                                                         .fontStyle,
//                                               ),
//                                               color:
//                                                   FlutterFlowTheme.of(context)
//                                                       .primary,
//                                               letterSpacing: 0.0,
//                                               fontWeight: FontWeight.w600,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .labelMedium
//                                                       .fontStyle,
//                                             ),
//                                         elevation: 0.0,
//                                         borderSide: BorderSide(
//                                           color: FlutterFlowTheme.of(context)
//                                               .primary,
//                                           width: 0.0,
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(20.0),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: FlutterFlowTheme.of(context).secondaryBackground,
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 4.0,
//                           color: Color(0x20000000),
//                           offset: Offset(
//                             0.0,
//                             2.0,
//                           ),
//                         )
//                       ],
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: 48.0,
//                             height: 48.0,
//                             decoration: BoxDecoration(
//                               color: Color(0x4D39D2C0),
//                               borderRadius: BorderRadius.circular(24.0),
//                             ),
//                             child: Align(
//                               alignment: AlignmentDirectional(0.0, 0.0),
//                               child: Icon(
//                                 Icons.receipt_long,
//                                 color: FlutterFlowTheme.of(context).secondary,
//                                 size: 24.0,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   12.0, 0.0, 12.0, 0.0),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'Ride completed',
//                                         style: FlutterFlowTheme.of(context)
//                                             .titleSmall
//                                             .override(
//                                               font: GoogleFonts.interTight(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontStyle:
//                                                     FlutterFlowTheme.of(context)
//                                                         .titleSmall
//                                                         .fontStyle,
//                                               ),
//                                               letterSpacing: 0.0,
//                                               fontWeight: FontWeight.w600,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .titleSmall
//                                                       .fontStyle,
//                                             ),
//                                       ),
//                                       Text(
//                                         '1h ago',
//                                         style: FlutterFlowTheme.of(context)
//                                             .labelSmall
//                                             .override(
//                                               font: GoogleFonts.inter(
//                                                 fontWeight:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelSmall
//                                                         .fontWeight,
//                                                 fontStyle:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelSmall
//                                                         .fontStyle,
//                                               ),
//                                               color:
//                                                   FlutterFlowTheme.of(context)
//                                                       .secondaryText,
//                                               letterSpacing: 0.0,
//                                               fontWeight:
//                                                   FlutterFlowTheme.of(context)
//                                                       .labelSmall
//                                                       .fontWeight,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .labelSmall
//                                                       .fontStyle,
//                                             ),
//                                       ),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0.0, 4.0, 0.0, 0.0),
//                                     child: Text(
//                                       'Your ride to Downtown has been completed. Total fare: \$15.75',
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodyMedium
//                                           .override(
//                                             font: GoogleFonts.inter(
//                                               fontWeight:
//                                                   FlutterFlowTheme.of(context)
//                                                       .bodyMedium
//                                                       .fontWeight,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .bodyMedium
//                                                       .fontStyle,
//                                             ),
//                                             color: FlutterFlowTheme.of(context)
//                                                 .secondaryText,
//                                             letterSpacing: 0.0,
//                                             fontWeight:
//                                                 FlutterFlowTheme.of(context)
//                                                     .bodyMedium
//                                                     .fontWeight,
//                                             fontStyle:
//                                                 FlutterFlowTheme.of(context)
//                                                     .bodyMedium
//                                                     .fontStyle,
//                                           ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0.0, 8.0, 0.0, 0.0),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         FFButtonWidget(
//                                           onPressed: () {
//                                             print('Button pressed ...');
//                                           },
//                                           text: 'Rate driver',
//                                           options: FFButtonOptions(
//                                             width: 110.0,
//                                             height: 32.0,
//                                             padding: EdgeInsets.all(8.0),
//                                             iconPadding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     0.0, 0.0, 0.0, 0.0),
//                                             color: FlutterFlowTheme.of(context)
//                                                 .accent1,
//                                             textStyle: FlutterFlowTheme.of(
//                                                     context)
//                                                 .labelMedium
//                                                 .override(
//                                                   font: GoogleFonts.inter(
//                                                     fontWeight: FontWeight.w600,
//                                                     fontStyle:
//                                                         FlutterFlowTheme.of(
//                                                                 context)
//                                                             .labelMedium
//                                                             .fontStyle,
//                                                   ),
//                                                   color: FlutterFlowTheme.of(
//                                                           context)
//                                                       .primary,
//                                                   letterSpacing: 0.0,
//                                                   fontWeight: FontWeight.w600,
//                                                   fontStyle:
//                                                       FlutterFlowTheme.of(
//                                                               context)
//                                                           .labelMedium
//                                                           .fontStyle,
//                                                 ),
//                                             elevation: 0.0,
//                                             borderSide: BorderSide(
//                                               color:
//                                                   FlutterFlowTheme.of(context)
//                                                       .primary,
//                                               width: 0.0,
//                                             ),
//                                             borderRadius:
//                                                 BorderRadius.circular(20.0),
//                                           ),
//                                         ),
//                                         FFButtonWidget(
//                                           onPressed: () {
//                                             print('Button pressed ...');
//                                           },
//                                           text: 'View receipt',
//                                           options: FFButtonOptions(
//                                             width: 110.0,
//                                             height: 32.0,
//                                             padding: EdgeInsets.all(8.0),
//                                             iconPadding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     0.0, 0.0, 0.0, 0.0),
//                                             color: FlutterFlowTheme.of(context)
//                                                 .accent2,
//                                             textStyle: FlutterFlowTheme.of(
//                                                     context)
//                                                 .labelMedium
//                                                 .override(
//                                                   font: GoogleFonts.inter(
//                                                     fontWeight: FontWeight.w600,
//                                                     fontStyle:
//                                                         FlutterFlowTheme.of(
//                                                                 context)
//                                                             .labelMedium
//                                                             .fontStyle,
//                                                   ),
//                                                   color: FlutterFlowTheme.of(
//                                                           context)
//                                                       .secondary,
//                                                   letterSpacing: 0.0,
//                                                   fontWeight: FontWeight.w600,
//                                                   fontStyle:
//                                                       FlutterFlowTheme.of(
//                                                               context)
//                                                           .labelMedium
//                                                           .fontStyle,
//                                                 ),
//                                             elevation: 0.0,
//                                             borderSide: BorderSide(
//                                               color:
//                                                   FlutterFlowTheme.of(context)
//                                                       .secondary,
//                                               width: 0.0,
//                                             ),
//                                             borderRadius:
//                                                 BorderRadius.circular(20.0),
//                                           ),
//                                         ),
//                                       ].divide(SizedBox(width: 8.0)),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: FlutterFlowTheme.of(context).secondaryBackground,
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 4.0,
//                           color: Color(0x20000000),
//                           offset: Offset(
//                             0.0,
//                             2.0,
//                           ),
//                         )
//                       ],
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: 48.0,
//                             height: 48.0,
//                             decoration: BoxDecoration(
//                               color: Color(0x4DEE8B60),
//                               borderRadius: BorderRadius.circular(24.0),
//                             ),
//                             child: Align(
//                               alignment: AlignmentDirectional(0.0, 0.0),
//                               child: Icon(
//                                 Icons.discount,
//                                 color: FlutterFlowTheme.of(context).tertiary,
//                                 size: 24.0,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   12.0, 0.0, 12.0, 0.0),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'Promo code applied',
//                                         style: FlutterFlowTheme.of(context)
//                                             .titleSmall
//                                             .override(
//                                               font: GoogleFonts.interTight(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontStyle:
//                                                     FlutterFlowTheme.of(context)
//                                                         .titleSmall
//                                                         .fontStyle,
//                                               ),
//                                               letterSpacing: 0.0,
//                                               fontWeight: FontWeight.w600,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .titleSmall
//                                                       .fontStyle,
//                                             ),
//                                       ),
//                                       Text(
//                                         '3h ago',
//                                         style: FlutterFlowTheme.of(context)
//                                             .labelSmall
//                                             .override(
//                                               font: GoogleFonts.inter(
//                                                 fontWeight:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelSmall
//                                                         .fontWeight,
//                                                 fontStyle:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelSmall
//                                                         .fontStyle,
//                                               ),
//                                               color:
//                                                   FlutterFlowTheme.of(context)
//                                                       .secondaryText,
//                                               letterSpacing: 0.0,
//                                               fontWeight:
//                                                   FlutterFlowTheme.of(context)
//                                                       .labelSmall
//                                                       .fontWeight,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .labelSmall
//                                                       .fontStyle,
//                                             ),
//                                       ),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0.0, 4.0, 0.0, 0.0),
//                                     child: Text(
//                                       'Your promo code \'RIDE25\' has been applied. Enjoy 25% off your next 3 rides!',
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodyMedium
//                                           .override(
//                                             font: GoogleFonts.inter(
//                                               fontWeight:
//                                                   FlutterFlowTheme.of(context)
//                                                       .bodyMedium
//                                                       .fontWeight,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .bodyMedium
//                                                       .fontStyle,
//                                             ),
//                                             color: FlutterFlowTheme.of(context)
//                                                 .secondaryText,
//                                             letterSpacing: 0.0,
//                                             fontWeight:
//                                                 FlutterFlowTheme.of(context)
//                                                     .bodyMedium
//                                                     .fontWeight,
//                                             fontStyle:
//                                                 FlutterFlowTheme.of(context)
//                                                     .bodyMedium
//                                                     .fontStyle,
//                                           ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0.0, 8.0, 0.0, 0.0),
//                                     child: FFButtonWidget(
//                                       onPressed: () {
//                                         print('Button pressed ...');
//                                       },
//                                       text: 'Book a ride',
//                                       options: FFButtonOptions(
//                                         width: 100.0,
//                                         height: 32.0,
//                                         padding: EdgeInsets.all(8.0),
//                                         iconPadding:
//                                             EdgeInsetsDirectional.fromSTEB(
//                                                 0.0, 0.0, 0.0, 0.0),
//                                         color: FlutterFlowTheme.of(context)
//                                             .accent3,
//                                         textStyle: FlutterFlowTheme.of(context)
//                                             .labelMedium
//                                             .override(
//                                               font: GoogleFonts.inter(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontStyle:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelMedium
//                                                         .fontStyle,
//                                               ),
//                                               color:
//                                                   FlutterFlowTheme.of(context)
//                                                       .tertiary,
//                                               letterSpacing: 0.0,
//                                               fontWeight: FontWeight.w600,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .labelMedium
//                                                       .fontStyle,
//                                             ),
//                                         elevation: 0.0,
//                                         borderSide: BorderSide(
//                                           color: FlutterFlowTheme.of(context)
//                                               .tertiary,
//                                           width: 0.0,
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(20.0),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: FlutterFlowTheme.of(context).secondaryBackground,
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 4.0,
//                           color: Color(0x20000000),
//                           offset: Offset(
//                             0.0,
//                             2.0,
//                           ),
//                         )
//                       ],
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: 48.0,
//                             height: 48.0,
//                             decoration: BoxDecoration(
//                               color: Color(0x4C4B39EF),
//                               borderRadius: BorderRadius.circular(24.0),
//                             ),
//                             child: Align(
//                               alignment: AlignmentDirectional(0.0, 0.0),
//                               child: Icon(
//                                 Icons.schedule,
//                                 color: FlutterFlowTheme.of(context).primary,
//                                 size: 24.0,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   12.0, 0.0, 12.0, 0.0),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'Scheduled ride reminder',
//                                         style: FlutterFlowTheme.of(context)
//                                             .titleSmall
//                                             .override(
//                                               font: GoogleFonts.interTight(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontStyle:
//                                                     FlutterFlowTheme.of(context)
//                                                         .titleSmall
//                                                         .fontStyle,
//                                               ),
//                                               letterSpacing: 0.0,
//                                               fontWeight: FontWeight.w600,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .titleSmall
//                                                       .fontStyle,
//                                             ),
//                                       ),
//                                       Text(
//                                         '5h ago',
//                                         style: FlutterFlowTheme.of(context)
//                                             .labelSmall
//                                             .override(
//                                               font: GoogleFonts.inter(
//                                                 fontWeight:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelSmall
//                                                         .fontWeight,
//                                                 fontStyle:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelSmall
//                                                         .fontStyle,
//                                               ),
//                                               color:
//                                                   FlutterFlowTheme.of(context)
//                                                       .secondaryText,
//                                               letterSpacing: 0.0,
//                                               fontWeight:
//                                                   FlutterFlowTheme.of(context)
//                                                       .labelSmall
//                                                       .fontWeight,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .labelSmall
//                                                       .fontStyle,
//                                             ),
//                                       ),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0.0, 4.0, 0.0, 0.0),
//                                     child: Text(
//                                       'Your ride to Airport is scheduled for tomorrow at 8:00 AM. Driver will arrive 10 minutes early.',
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodyMedium
//                                           .override(
//                                             font: GoogleFonts.inter(
//                                               fontWeight:
//                                                   FlutterFlowTheme.of(context)
//                                                       .bodyMedium
//                                                       .fontWeight,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .bodyMedium
//                                                       .fontStyle,
//                                             ),
//                                             color: FlutterFlowTheme.of(context)
//                                                 .secondaryText,
//                                             letterSpacing: 0.0,
//                                             fontWeight:
//                                                 FlutterFlowTheme.of(context)
//                                                     .bodyMedium
//                                                     .fontWeight,
//                                             fontStyle:
//                                                 FlutterFlowTheme.of(context)
//                                                     .bodyMedium
//                                                     .fontStyle,
//                                           ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0.0, 8.0, 0.0, 0.0),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         FFButtonWidget(
//                                           onPressed: () {
//                                             print('Button pressed ...');
//                                           },
//                                           text: 'Modify',
//                                           options: FFButtonOptions(
//                                             width: 90.0,
//                                             height: 32.0,
//                                             padding: EdgeInsets.all(8.0),
//                                             iconPadding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     0.0, 0.0, 0.0, 0.0),
//                                             color: FlutterFlowTheme.of(context)
//                                                 .accent1,
//                                             textStyle: FlutterFlowTheme.of(
//                                                     context)
//                                                 .labelMedium
//                                                 .override(
//                                                   font: GoogleFonts.inter(
//                                                     fontWeight: FontWeight.w600,
//                                                     fontStyle:
//                                                         FlutterFlowTheme.of(
//                                                                 context)
//                                                             .labelMedium
//                                                             .fontStyle,
//                                                   ),
//                                                   color: FlutterFlowTheme.of(
//                                                           context)
//                                                       .primary,
//                                                   letterSpacing: 0.0,
//                                                   fontWeight: FontWeight.w600,
//                                                   fontStyle:
//                                                       FlutterFlowTheme.of(
//                                                               context)
//                                                           .labelMedium
//                                                           .fontStyle,
//                                                 ),
//                                             elevation: 0.0,
//                                             borderSide: BorderSide(
//                                               color:
//                                                   FlutterFlowTheme.of(context)
//                                                       .primary,
//                                               width: 0.0,
//                                             ),
//                                             borderRadius:
//                                                 BorderRadius.circular(20.0),
//                                           ),
//                                         ),
//                                         FFButtonWidget(
//                                           onPressed: () {
//                                             print('Button pressed ...');
//                                           },
//                                           text: 'Cancel',
//                                           options: FFButtonOptions(
//                                             width: 90.0,
//                                             height: 32.0,
//                                             padding: EdgeInsets.all(8.0),
//                                             iconPadding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     0.0, 0.0, 0.0, 0.0),
//                                             color: Color(0x20FF5963),
//                                             textStyle: FlutterFlowTheme.of(
//                                                     context)
//                                                 .labelMedium
//                                                 .override(
//                                                   font: GoogleFonts.inter(
//                                                     fontWeight: FontWeight.w600,
//                                                     fontStyle:
//                                                         FlutterFlowTheme.of(
//                                                                 context)
//                                                             .labelMedium
//                                                             .fontStyle,
//                                                   ),
//                                                   color: FlutterFlowTheme.of(
//                                                           context)
//                                                       .error,
//                                                   letterSpacing: 0.0,
//                                                   fontWeight: FontWeight.w600,
//                                                   fontStyle:
//                                                       FlutterFlowTheme.of(
//                                                               context)
//                                                           .labelMedium
//                                                           .fontStyle,
//                                                 ),
//                                             elevation: 0.0,
//                                             borderSide: BorderSide(
//                                               color:
//                                                   FlutterFlowTheme.of(context)
//                                                       .error,
//                                               width: 0.0,
//                                             ),
//                                             borderRadius:
//                                                 BorderRadius.circular(20.0),
//                                           ),
//                                         ),
//                                       ].divide(SizedBox(width: 8.0)),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: FlutterFlowTheme.of(context).secondaryBackground,
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 4.0,
//                           color: Color(0x20000000),
//                           offset: Offset(
//                             0.0,
//                             2.0,
//                           ),
//                         )
//                       ],
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: 48.0,
//                             height: 48.0,
//                             decoration: BoxDecoration(
//                               color: Color(0x20249689),
//                               borderRadius: BorderRadius.circular(24.0),
//                             ),
//                             child: Align(
//                               alignment: AlignmentDirectional(0.0, 0.0),
//                               child: Icon(
//                                 Icons.person,
//                                 color: FlutterFlowTheme.of(context).success,
//                                 size: 24.0,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   12.0, 0.0, 12.0, 0.0),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'Driver message',
//                                         style: FlutterFlowTheme.of(context)
//                                             .titleSmall
//                                             .override(
//                                               font: GoogleFonts.interTight(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontStyle:
//                                                     FlutterFlowTheme.of(context)
//                                                         .titleSmall
//                                                         .fontStyle,
//                                               ),
//                                               letterSpacing: 0.0,
//                                               fontWeight: FontWeight.w600,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .titleSmall
//                                                       .fontStyle,
//                                             ),
//                                       ),
//                                       Text(
//                                         'Yesterday',
//                                         style: FlutterFlowTheme.of(context)
//                                             .labelSmall
//                                             .override(
//                                               font: GoogleFonts.inter(
//                                                 fontWeight:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelSmall
//                                                         .fontWeight,
//                                                 fontStyle:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelSmall
//                                                         .fontStyle,
//                                               ),
//                                               color:
//                                                   FlutterFlowTheme.of(context)
//                                                       .secondaryText,
//                                               letterSpacing: 0.0,
//                                               fontWeight:
//                                                   FlutterFlowTheme.of(context)
//                                                       .labelSmall
//                                                       .fontWeight,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .labelSmall
//                                                       .fontStyle,
//                                             ),
//                                       ),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0.0, 4.0, 0.0, 0.0),
//                                     child: Text(
//                                       'Your driver Sarah left a message: \'Thanks for the great conversation during our ride! Rated you 5 stars.\'',
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodyMedium
//                                           .override(
//                                             font: GoogleFonts.inter(
//                                               fontWeight:
//                                                   FlutterFlowTheme.of(context)
//                                                       .bodyMedium
//                                                       .fontWeight,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .bodyMedium
//                                                       .fontStyle,
//                                             ),
//                                             color: FlutterFlowTheme.of(context)
//                                                 .secondaryText,
//                                             letterSpacing: 0.0,
//                                             fontWeight:
//                                                 FlutterFlowTheme.of(context)
//                                                     .bodyMedium
//                                                     .fontWeight,
//                                             fontStyle:
//                                                 FlutterFlowTheme.of(context)
//                                                     .bodyMedium
//                                                     .fontStyle,
//                                           ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0.0, 8.0, 0.0, 0.0),
//                                     child: FFButtonWidget(
//                                       onPressed: () {
//                                         print('Button pressed ...');
//                                       },
//                                       text: 'Send thanks',
//                                       options: FFButtonOptions(
//                                         width: 110.0,
//                                         height: 32.0,
//                                         padding: EdgeInsets.all(8.0),
//                                         iconPadding:
//                                             EdgeInsetsDirectional.fromSTEB(
//                                                 0.0, 0.0, 0.0, 0.0),
//                                         color: Color(0x20249689),
//                                         textStyle: FlutterFlowTheme.of(context)
//                                             .labelMedium
//                                             .override(
//                                               font: GoogleFonts.inter(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontStyle:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelMedium
//                                                         .fontStyle,
//                                               ),
//                                               color:
//                                                   FlutterFlowTheme.of(context)
//                                                       .success,
//                                               letterSpacing: 0.0,
//                                               fontWeight: FontWeight.w600,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .labelMedium
//                                                       .fontStyle,
//                                             ),
//                                         elevation: 0.0,
//                                         borderSide: BorderSide(
//                                           color: FlutterFlowTheme.of(context)
//                                               .success,
//                                           width: 0.0,
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(20.0),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: FlutterFlowTheme.of(context).secondaryBackground,
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 4.0,
//                           color: Color(0x20000000),
//                           offset: Offset(
//                             0.0,
//                             2.0,
//                           ),
//                         )
//                       ],
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: 48.0,
//                             height: 48.0,
//                             decoration: BoxDecoration(
//                               color: Color(0x20F9CF58),
//                               borderRadius: BorderRadius.circular(24.0),
//                             ),
//                             child: Align(
//                               alignment: AlignmentDirectional(0.0, 0.0),
//                               child: Icon(
//                                 Icons.warning_amber_rounded,
//                                 color: FlutterFlowTheme.of(context).warning,
//                                 size: 24.0,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   12.0, 0.0, 12.0, 0.0),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'High demand alert',
//                                         style: FlutterFlowTheme.of(context)
//                                             .titleSmall
//                                             .override(
//                                               font: GoogleFonts.interTight(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontStyle:
//                                                     FlutterFlowTheme.of(context)
//                                                         .titleSmall
//                                                         .fontStyle,
//                                               ),
//                                               letterSpacing: 0.0,
//                                               fontWeight: FontWeight.w600,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .titleSmall
//                                                       .fontStyle,
//                                             ),
//                                       ),
//                                       Text(
//                                         '2 days ago',
//                                         style: FlutterFlowTheme.of(context)
//                                             .labelSmall
//                                             .override(
//                                               font: GoogleFonts.inter(
//                                                 fontWeight:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelSmall
//                                                         .fontWeight,
//                                                 fontStyle:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelSmall
//                                                         .fontStyle,
//                                               ),
//                                               color:
//                                                   FlutterFlowTheme.of(context)
//                                                       .secondaryText,
//                                               letterSpacing: 0.0,
//                                               fontWeight:
//                                                   FlutterFlowTheme.of(context)
//                                                       .labelSmall
//                                                       .fontWeight,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .labelSmall
//                                                       .fontStyle,
//                                             ),
//                                       ),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0.0, 4.0, 0.0, 0.0),
//                                     child: Text(
//                                       'Rides in your area are in high demand. Prices may be higher than usual for the next 2 hours.',
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodyMedium
//                                           .override(
//                                             font: GoogleFonts.inter(
//                                               fontWeight:
//                                                   FlutterFlowTheme.of(context)
//                                                       .bodyMedium
//                                                       .fontWeight,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .bodyMedium
//                                                       .fontStyle,
//                                             ),
//                                             color: FlutterFlowTheme.of(context)
//                                                 .secondaryText,
//                                             letterSpacing: 0.0,
//                                             fontWeight:
//                                                 FlutterFlowTheme.of(context)
//                                                     .bodyMedium
//                                                     .fontWeight,
//                                             fontStyle:
//                                                 FlutterFlowTheme.of(context)
//                                                     .bodyMedium
//                                                     .fontStyle,
//                                           ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0.0, 8.0, 0.0, 0.0),
//                                     child: FFButtonWidget(
//                                       onPressed: () {
//                                         print('Button pressed ...');
//                                       },
//                                       text: 'Schedule for later',
//                                       options: FFButtonOptions(
//                                         width: 150.0,
//                                         height: 32.0,
//                                         padding: EdgeInsets.all(8.0),
//                                         iconPadding:
//                                             EdgeInsetsDirectional.fromSTEB(
//                                                 0.0, 0.0, 0.0, 0.0),
//                                         color: Color(0x20F9CF58),
//                                         textStyle: FlutterFlowTheme.of(context)
//                                             .labelMedium
//                                             .override(
//                                               font: GoogleFonts.inter(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontStyle:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelMedium
//                                                         .fontStyle,
//                                               ),
//                                               color:
//                                                   FlutterFlowTheme.of(context)
//                                                       .warning,
//                                               letterSpacing: 0.0,
//                                               fontWeight: FontWeight.w600,
//                                               fontStyle:
//                                                   FlutterFlowTheme.of(context)
//                                                       .labelMedium
//                                                       .fontStyle,
//                                             ),
//                                         elevation: 0.0,
//                                         borderSide: BorderSide(
//                                           color: FlutterFlowTheme.of(context)
//                                               .warning,
//                                           width: 0.0,
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(20.0),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ].divide(SizedBox(height: 16.0)),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import '/backend/backend.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import 'package:rxdart/rxdart.dart';
import '/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

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

  // Format timestamp to relative time
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
      return '${difference.inDays} days ago';
    } else {
      return dateTimeFormat('MMMd', timestamp);
    }
  }

  Widget _buildNotificationIcon(AppNotification notification) {
    IconData iconData;
    Color color;
    Color bgColor;

    switch (notification.type) {
      case NotificationType.bookingRequest:
        iconData = Icons.drive_eta;
        color = FlutterFlowTheme.of(context).primary;
        bgColor = FlutterFlowTheme.of(context).accent1;
        break;
      case NotificationType.bookingStatus:
        if (notification.status.toLowerCase() == 'accepted') {
          iconData = Icons.check_circle_outline;
          color = FlutterFlowTheme.of(context).success;
          bgColor = const Color(0x20249689);
        } else if (notification.status.toLowerCase() == 'rejected') {
          iconData = Icons.cancel_outlined;
          color = FlutterFlowTheme.of(context).error;
          bgColor = const Color(0x20FF5963);
        } else {
          iconData = Icons.info_outline;
          color = FlutterFlowTheme.of(context).secondaryText;
          bgColor = FlutterFlowTheme.of(context).accent2;
        }
        break;
      case NotificationType.savedRide:
        iconData = Icons.bookmark_outline;
        color = const Color(0xFFF77F4A);
        bgColor = const Color(0x20EE8B60);
        break;
    }

    return Container(
      width: 48.0,
      height: 48.0,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Center(
        child: Icon(
          iconData,
          color: color,
          size: 24.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Stream 1: Bookings made BY the current user (as a passenger/customer)
    final passengerBookingsStream = currentUserReference == null
        ? Stream<List<BookingsRecord>>.value([])
        : queryBookingsRecord(
            queryBuilder: (q) => q
                .where('creator', isEqualTo: currentUserReference)
                .orderBy('createdTime', descending: true),
            limit: 50,
          );

    // Stream 2: All rides posted BY the current user (as a driver)
    final driverRidesStream = currentUserReference == null
        ? Stream<List<RidesNewRecord>>.value([])
        : queryRidesNewRecord(
            queryBuilder: (q) => q.where('creatorID', isEqualTo: currentUserReference),
          );

    // Stream 3: Bookings on those rides — we fetch all recent bookings and cross-ref
    // (Firestore can't easily query by rideID array membership, so we fetch driver's
    //  ride refs from stream 2 and join in memory)
    final allRecentBookingsStream = currentUserReference == null
        ? Stream<List<BookingsRecord>>.value([])
        : queryBookingsRecord(
            queryBuilder: (q) => q.orderBy('createdTime', descending: true),
            limit: 100,
          );

    // Stream 4: Rides saved by the current user
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 20.0,
            buttonSize: 40.0,
            icon: Icon(
              Icons.arrow_back_ios,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          title: Text(
            'Notifications',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  font: GoogleFonts.interTight(
                    fontWeight: FontWeight.w600,
                  ),
                  fontSize: 20.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
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

                  // Notifications for the current user as a PASSENGER (bookings they made)
                  for (final booking in passengerBookings) {
                    if (seenIds.contains(booking.reference.id)) continue;
                    seenIds.add(booking.reference.id);
                    list.add(AppNotification(
                      id: booking.reference.id,
                      title: booking.bookingType == 'Parcel' ? 'Parcel Status Update' : 'Ride Status Update',
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

                  // Notifications for the current user as a DRIVER (bookings on their rides)
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

                  // Saved ride status updates
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
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: SpinKitFadingCircle(
                        color: FlutterFlowTheme.of(context).primary,
                        size: 50.0,
                      ),
                    ),
                  );
                }

                final notifications = snapshot.data!;

                if (notifications.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: 64.0,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'No new notifications',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                font: GoogleFonts.inter(),
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: notifications.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.0),
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x20000000),
                            offset: Offset(0.0, 2.0),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildNotificationIcon(notification),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          notification.title,
                                          style: FlutterFlowTheme.of(context).titleSmall.override(
                                                font: GoogleFonts.interTight(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Text(
                                          _getRelativeTime(notification.time),
                                          style: FlutterFlowTheme.of(context).labelSmall.override(
                                                font: GoogleFonts.inter(),
                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                      child: Text(
                                        notification.message,
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              font: GoogleFonts.inter(),
                                              color: FlutterFlowTheme.of(context).secondaryText,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                    if (notification.type == NotificationType.bookingRequest)
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            context.pushNamed(BookingsDriverWidget.routeName);
                                          },
                                          text: 'View Bookings',
                                          options: FFButtonOptions(
                                            height: 32.0,
                                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                                            color: FlutterFlowTheme.of(context).accent1,
                                            textStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                  font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                                  color: FlutterFlowTheme.of(context).primary,
                                                  letterSpacing: 0.0,
                                                ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).primary,
                                              width: 0.0,
                                            ),
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                    if ((notification.type == NotificationType.bookingStatus ||
                                            notification.type == NotificationType.savedRide) &&
                                        notification.rideRef != null)
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
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
                                          text: 'View Ride',
                                          options: FFButtonOptions(
                                            height: 32.0,
                                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                                            color: FlutterFlowTheme.of(context).accent1,
                                            textStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                  font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                                  color: FlutterFlowTheme.of(context).primary,
                                                  letterSpacing: 0.0,
                                                ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).primary,
                                              width: 0.0,
                                            ),
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

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