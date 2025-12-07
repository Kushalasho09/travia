import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'support_page_model.dart';
export 'support_page_model.dart';

class SupportPageWidget extends StatefulWidget {
  const SupportPageWidget({super.key});

  static String routeName = 'Support_Page';
  static String routePath = '/supportPage';

  @override
  State<SupportPageWidget> createState() => _SupportPageWidgetState();
}

class _SupportPageWidgetState extends State<SupportPageWidget> {
  late SupportPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SupportPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return StreamBuilder<List<ContactSetupRecord>>(
  //     stream: queryContactSetupRecord(
  //       singleRecord: true,
  //     ),
  //     builder: (context, snapshot) {
  //       // Customize what your widget looks like when it's loading.
  //       if (!snapshot.hasData) {
  //         return Scaffold(
  //           backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
  //           body: Center(
  //             child: SizedBox(
  //               width: 50.0,
  //               height: 50.0,
  //               child: SpinKitFadingCircle(
  //                 color: Color(0xFF2B3C58),
  //                 size: 50.0,
  //               ),
  //             ),
  //           ),
  //         );
  //       }
  //       List<ContactSetupRecord> supportPageContactSetupRecordList =
  //           snapshot.data!;
  //       // Return an empty Container when the item does not exist.
  //       if (snapshot.data!.isEmpty) {
  //         return Container();
  //       }
  //       final supportPageContactSetupRecord =
  //           supportPageContactSetupRecordList.isNotEmpty
  //               ? supportPageContactSetupRecordList.first
  //               : null;
  //
  //       return GestureDetector(
  //         onTap: () {
  //           FocusScope.of(context).unfocus();
  //           FocusManager.instance.primaryFocus?.unfocus();
  //         },
  //         child: Scaffold(
  //           key: scaffoldKey,
  //           backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
  //           appBar: AppBar(
  //             backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
  //             automaticallyImplyLeading: false,
  //             leading: FlutterFlowIconButton(
  //               borderColor: Colors.transparent,
  //               borderRadius: 30.0,
  //               borderWidth: 1.0,
  //               buttonSize: 60.0,
  //               icon: Icon(
  //                 Icons.arrow_back_rounded,
  //                 color: FlutterFlowTheme.of(context).primaryText,
  //                 size: 30.0,
  //               ),
  //               onPressed: () async {
  //                 context.pop();
  //               },
  //             ),
  //             title: Text(
  //               'Support',
  //               style: FlutterFlowTheme.of(context).headlineMedium.override(
  //                     font: GoogleFonts.interTight(
  //                       fontWeight: FlutterFlowTheme.of(context)
  //                           .headlineMedium
  //                           .fontWeight,
  //                       fontStyle: FlutterFlowTheme.of(context)
  //                           .headlineMedium
  //                           .fontStyle,
  //                     ),
  //                     color: FlutterFlowTheme.of(context).primaryText,
  //                     fontSize: 22.0,
  //                     letterSpacing: 0.0,
  //                     fontWeight: FlutterFlowTheme.of(context)
  //                         .headlineMedium
  //                         .fontWeight,
  //                     fontStyle:
  //                         FlutterFlowTheme.of(context).headlineMedium.fontStyle,
  //                   ),
  //             ),
  //             actions: [],
  //             centerTitle: true,
  //             elevation: 2.0,
  //           ),
  //           body: SafeArea(
  //             top: true,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.max,
  //               children: [
  //                 Flexible(
  //                   child: Padding(
  //                     padding: EdgeInsetsDirectional.fromSTEB(
  //                         10.0, 10.0, 10.0, 10.0),
  //                     child: ListView(
  //                       padding: EdgeInsets.zero,
  //                       primary: false,
  //                       shrinkWrap: true,
  //                       scrollDirection: Axis.vertical,
  //                       children: [
  //                         Padding(
  //                           padding: EdgeInsetsDirectional.fromSTEB(
  //                               0.0, 16.0, 0.0, 24.0),
  //                           child: Text(
  //                             'How can we help you today?',
  //                             style: FlutterFlowTheme.of(context)
  //                                 .bodyLarge
  //                                 .override(
  //                                   font: GoogleFonts.inter(
  //                                     fontWeight: FlutterFlowTheme.of(context)
  //                                         .bodyLarge
  //                                         .fontWeight,
  //                                     fontStyle: FlutterFlowTheme.of(context)
  //                                         .bodyLarge
  //                                         .fontStyle,
  //                                   ),
  //                                   color: FlutterFlowTheme.of(context)
  //                                       .primaryText,
  //                                   letterSpacing: 0.0,
  //                                   fontWeight: FlutterFlowTheme.of(context)
  //                                       .bodyLarge
  //                                       .fontWeight,
  //                                   fontStyle: FlutterFlowTheme.of(context)
  //                                       .bodyLarge
  //                                       .fontStyle,
  //                                 ),
  //                           ),
  //                         ),
  //                         Container(),
  //                         Padding(
  //                           padding: EdgeInsetsDirectional.fromSTEB(
  //                               0.0, 0.0, 0.0, 16.0),
  //                           child: Container(
  //                             width: double.infinity,
  //                             decoration: BoxDecoration(
  //                               color: FlutterFlowTheme.of(context)
  //                                   .containerColour,
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   blurRadius: 4.0,
  //                                   color: Color(0x10000000),
  //                                 )
  //                               ],
  //                               borderRadius: BorderRadius.circular(12.0),
  //                             ),
  //                             child: Padding(
  //                               padding: EdgeInsets.all(16.0),
  //                               child: Column(
  //                                 mainAxisSize: MainAxisSize.max,
  //                                 children: [
  //                                   Padding(
  //                                     padding: EdgeInsets.all(16.0),
  //                                     child: Row(
  //                                       mainAxisSize: MainAxisSize.max,
  //                                       children: [
  //                                         Container(
  //                                           width: 48.0,
  //                                           height: 48.0,
  //                                           decoration: BoxDecoration(
  //                                             color: Color(0xFFE6F5FF),
  //                                             shape: BoxShape.circle,
  //                                           ),
  //                                           child: Align(
  //                                             alignment: AlignmentDirectional(
  //                                                 0.0, 0.0),
  //                                             child: Icon(
  //                                               Icons.chat_bubble_outline,
  //                                               color:
  //                                                   FlutterFlowTheme.of(context)
  //                                                       .primary,
  //                                               size: 24.0,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         Flexible(
  //                                           child: Padding(
  //                                             padding: EdgeInsetsDirectional
  //                                                 .fromSTEB(
  //                                                     16.0, 0.0, 16.0, 0.0),
  //                                             child: Column(
  //                                               mainAxisSize: MainAxisSize.max,
  //                                               crossAxisAlignment:
  //                                                   CrossAxisAlignment.start,
  //                                               children: [
  //                                                 Text(
  //                                                   'Live Chat Support',
  //                                                   style: FlutterFlowTheme.of(
  //                                                           context)
  //                                                       .titleMedium
  //                                                       .override(
  //                                                         font: GoogleFonts
  //                                                             .interTight(
  //                                                           fontWeight:
  //                                                               FontWeight.w600,
  //                                                           fontStyle:
  //                                                               FlutterFlowTheme.of(
  //                                                                       context)
  //                                                                   .titleMedium
  //                                                                   .fontStyle,
  //                                                         ),
  //                                                         letterSpacing: 0.0,
  //                                                         fontWeight:
  //                                                             FontWeight.w600,
  //                                                         fontStyle:
  //                                                             FlutterFlowTheme.of(
  //                                                                     context)
  //                                                                 .titleMedium
  //                                                                 .fontStyle,
  //                                                       ),
  //                                                 ),
  //                                                 Padding(
  //                                                   padding:
  //                                                       EdgeInsetsDirectional
  //                                                           .fromSTEB(0.0, 4.0,
  //                                                               0.0, 0.0),
  //                                                   child: Text(
  //                                                     'Chat with our support team in real-time',
  //                                                     style:
  //                                                         FlutterFlowTheme.of(
  //                                                                 context)
  //                                                             .bodyMedium
  //                                                             .override(
  //                                                               font:
  //                                                                   GoogleFonts
  //                                                                       .inter(
  //                                                                 fontWeight: FlutterFlowTheme.of(
  //                                                                         context)
  //                                                                     .bodyMedium
  //                                                                     .fontWeight,
  //                                                                 fontStyle: FlutterFlowTheme.of(
  //                                                                         context)
  //                                                                     .bodyMedium
  //                                                                     .fontStyle,
  //                                                               ),
  //                                                               color: FlutterFlowTheme.of(
  //                                                                       context)
  //                                                                   .secondaryText,
  //                                                               letterSpacing:
  //                                                                   0.0,
  //                                                               fontWeight: FlutterFlowTheme.of(
  //                                                                       context)
  //                                                                   .bodyMedium
  //                                                                   .fontWeight,
  //                                                               fontStyle: FlutterFlowTheme.of(
  //                                                                       context)
  //                                                                   .bodyMedium
  //                                                                   .fontStyle,
  //                                                             ),
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   Padding(
  //                                     padding: EdgeInsetsDirectional.fromSTEB(
  //                                         16.0, 0.0, 16.0, 0.0),
  //                                     child: FFButtonWidget(
  //                                       onPressed: ()  {
  //                                          launchURL(
  //                                             supportPageContactSetupRecord!
  //                                                 .liveChatLink);
  //                                       },
  //                                       text: 'Start Chat',
  //                                       options: FFButtonOptions(
  //                                         width: double.infinity,
  //                                         height: 44.0,
  //                                         padding: EdgeInsets.all(8.0),
  //                                         iconPadding:
  //                                             EdgeInsetsDirectional.fromSTEB(
  //                                                 0.0, 0.0, 0.0, 0.0),
  //                                         color: Color(0xFFB3DBF5),
  //                                         textStyle: FlutterFlowTheme.of(
  //                                                 context)
  //                                             .bodyMedium
  //                                             .override(
  //                                               font: GoogleFonts.inter(
  //                                                 fontWeight:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontWeight,
  //                                                 fontStyle:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontStyle,
  //                                               ),
  //                                               color:
  //                                                   FlutterFlowTheme.of(context)
  //                                                       .info,
  //                                               letterSpacing: 0.0,
  //                                               fontWeight:
  //                                                   FlutterFlowTheme.of(context)
  //                                                       .bodyMedium
  //                                                       .fontWeight,
  //                                               fontStyle:
  //                                                   FlutterFlowTheme.of(context)
  //                                                       .bodyMedium
  //                                                       .fontStyle,
  //                                             ),
  //                                         elevation: 0.0,
  //                                         borderSide: BorderSide(
  //                                           color: Colors.transparent,
  //                                         ),
  //                                         borderRadius:
  //                                             BorderRadius.circular(8.0),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Container(),
  //                         Padding(
  //                           padding: EdgeInsetsDirectional.fromSTEB(
  //                               0.0, 0.0, 0.0, 16.0),
  //                           child: Container(
  //                             width: double.infinity,
  //                             decoration: BoxDecoration(
  //                               color: FlutterFlowTheme.of(context)
  //                                   .containerColour,
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   blurRadius: 4.0,
  //                                   color: Color(0x10000000),
  //                                 )
  //                               ],
  //                               borderRadius: BorderRadius.circular(12.0),
  //                             ),
  //                             child: Padding(
  //                               padding: EdgeInsets.all(16.0),
  //                               child: Column(
  //                                 mainAxisSize: MainAxisSize.max,
  //                                 children: [
  //                                   Padding(
  //                                     padding: EdgeInsets.all(16.0),
  //                                     child: Row(
  //                                       mainAxisSize: MainAxisSize.max,
  //                                       children: [
  //                                         Container(
  //                                           width: 48.0,
  //                                           height: 48.0,
  //                                           decoration: BoxDecoration(
  //                                             color: Color(0xFFE8F8E8),
  //                                             shape: BoxShape.circle,
  //                                           ),
  //                                           child: Align(
  //                                             alignment: AlignmentDirectional(
  //                                                 0.0, 0.0),
  //                                             child: FaIcon(
  //                                               FontAwesomeIcons.whatsapp,
  //                                               color: Color(0xFF25D366),
  //                                               size: 24.0,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         Flexible(
  //                                           child: Padding(
  //                                             padding: EdgeInsetsDirectional
  //                                                 .fromSTEB(
  //                                                     16.0, 0.0, 16.0, 0.0),
  //                                             child: Column(
  //                                               mainAxisSize: MainAxisSize.max,
  //                                               crossAxisAlignment:
  //                                                   CrossAxisAlignment.start,
  //                                               children: [
  //                                                 Text(
  //                                                   'WhatsApp Support',
  //                                                   style: FlutterFlowTheme.of(
  //                                                           context)
  //                                                       .titleMedium
  //                                                       .override(
  //                                                         font: GoogleFonts
  //                                                             .interTight(
  //                                                           fontWeight:
  //                                                               FontWeight.w600,
  //                                                           fontStyle:
  //                                                               FlutterFlowTheme.of(
  //                                                                       context)
  //                                                                   .titleMedium
  //                                                                   .fontStyle,
  //                                                         ),
  //                                                         letterSpacing: 0.0,
  //                                                         fontWeight:
  //                                                             FontWeight.w600,
  //                                                         fontStyle:
  //                                                             FlutterFlowTheme.of(
  //                                                                     context)
  //                                                                 .titleMedium
  //                                                                 .fontStyle,
  //                                                       ),
  //                                                 ),
  //                                                 Padding(
  //                                                   padding:
  //                                                       EdgeInsetsDirectional
  //                                                           .fromSTEB(0.0, 4.0,
  //                                                               0.0, 0.0),
  //                                                   child: Text(
  //                                                     'Message us on WhatsApp for quick assistance',
  //                                                     style:
  //                                                         FlutterFlowTheme.of(
  //                                                                 context)
  //                                                             .bodyMedium
  //                                                             .override(
  //                                                               font:
  //                                                                   GoogleFonts
  //                                                                       .inter(
  //                                                                 fontWeight: FlutterFlowTheme.of(
  //                                                                         context)
  //                                                                     .bodyMedium
  //                                                                     .fontWeight,
  //                                                                 fontStyle: FlutterFlowTheme.of(
  //                                                                         context)
  //                                                                     .bodyMedium
  //                                                                     .fontStyle,
  //                                                               ),
  //                                                               color: FlutterFlowTheme.of(
  //                                                                       context)
  //                                                                   .secondaryText,
  //                                                               letterSpacing:
  //                                                                   0.0,
  //                                                               fontWeight: FlutterFlowTheme.of(
  //                                                                       context)
  //                                                                   .bodyMedium
  //                                                                   .fontWeight,
  //                                                               fontStyle: FlutterFlowTheme.of(
  //                                                                       context)
  //                                                                   .bodyMedium
  //                                                                   .fontStyle,
  //                                                             ),
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   Padding(
  //                                     padding: EdgeInsetsDirectional.fromSTEB(
  //                                         16.0, 0.0, 16.0, 0.0),
  //                                     child: FFButtonWidget(
  //                                       onPressed: ()  {
  //                                          launchURL(
  //                                             supportPageContactSetupRecord!
  //                                                 .whatsappNumber);
  //                                       },
  //                                       text: 'Chat on WhatsApp',
  //                                       options: FFButtonOptions(
  //                                         width: double.infinity,
  //                                         height: 44.0,
  //                                         padding: EdgeInsets.all(8.0),
  //                                         iconPadding:
  //                                             EdgeInsetsDirectional.fromSTEB(
  //                                                 0.0, 0.0, 0.0, 0.0),
  //                                         color: Color(0xFFE8F8E8),
  //                                         textStyle: FlutterFlowTheme.of(
  //                                                 context)
  //                                             .bodyMedium
  //                                             .override(
  //                                               font: GoogleFonts.inter(
  //                                                 fontWeight:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontWeight,
  //                                                 fontStyle:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontStyle,
  //                                               ),
  //                                               color: Color(0xFF25D366),
  //                                               letterSpacing: 0.0,
  //                                               fontWeight:
  //                                                   FlutterFlowTheme.of(context)
  //                                                       .bodyMedium
  //                                                       .fontWeight,
  //                                               fontStyle:
  //                                                   FlutterFlowTheme.of(context)
  //                                                       .bodyMedium
  //                                                       .fontStyle,
  //                                             ),
  //                                         elevation: 0.0,
  //                                         borderSide: BorderSide(
  //                                           color: Colors.transparent,
  //                                         ),
  //                                         borderRadius:
  //                                             BorderRadius.circular(8.0),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Container(),
  //                         Padding(
  //                           padding: EdgeInsetsDirectional.fromSTEB(
  //                               0.0, 0.0, 0.0, 16.0),
  //                           child: Container(
  //                             width: double.infinity,
  //                             decoration: BoxDecoration(
  //                               color: FlutterFlowTheme.of(context)
  //                                   .containerColour,
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   blurRadius: 4.0,
  //                                   color: Color(0x10000000),
  //                                 )
  //                               ],
  //                               borderRadius: BorderRadius.circular(12.0),
  //                             ),
  //                             child: Padding(
  //                               padding: EdgeInsets.all(16.0),
  //                               child: Column(
  //                                 mainAxisSize: MainAxisSize.max,
  //                                 children: [
  //                                   Padding(
  //                                     padding: EdgeInsets.all(16.0),
  //                                     child: Row(
  //                                       mainAxisSize: MainAxisSize.max,
  //                                       children: [
  //                                         Container(
  //                                           width: 48.0,
  //                                           height: 48.0,
  //                                           decoration: BoxDecoration(
  //                                             color: Color(0xFFF0F0FF),
  //                                             shape: BoxShape.circle,
  //                                           ),
  //                                           child: Align(
  //                                             alignment: AlignmentDirectional(
  //                                                 0.0, 0.0),
  //                                             child: Icon(
  //                                               Icons.email_outlined,
  //                                               color: Color(0xFF5C6BC0),
  //                                               size: 24.0,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         Flexible(
  //                                           child: Padding(
  //                                             padding: EdgeInsetsDirectional
  //                                                 .fromSTEB(
  //                                                     16.0, 0.0, 16.0, 0.0),
  //                                             child: Column(
  //                                               mainAxisSize: MainAxisSize.max,
  //                                               crossAxisAlignment:
  //                                                   CrossAxisAlignment.start,
  //                                               children: [
  //                                                 Text(
  //                                                   'Email Support',
  //                                                   style: FlutterFlowTheme.of(
  //                                                           context)
  //                                                       .titleMedium
  //                                                       .override(
  //                                                         font: GoogleFonts
  //                                                             .interTight(
  //                                                           fontWeight:
  //                                                               FontWeight.w600,
  //                                                           fontStyle:
  //                                                               FlutterFlowTheme.of(
  //                                                                       context)
  //                                                                   .titleMedium
  //                                                                   .fontStyle,
  //                                                         ),
  //                                                         letterSpacing: 0.0,
  //                                                         fontWeight:
  //                                                             FontWeight.w600,
  //                                                         fontStyle:
  //                                                             FlutterFlowTheme.of(
  //                                                                     context)
  //                                                                 .titleMedium
  //                                                                 .fontStyle,
  //                                                       ),
  //                                                 ),
  //                                                 Padding(
  //                                                   padding:
  //                                                       EdgeInsetsDirectional
  //                                                           .fromSTEB(0.0, 4.0,
  //                                                               0.0, 0.0),
  //                                                   child: Text(
  //                                                     'support@traviaconnect.com',
  //                                                     style:
  //                                                         FlutterFlowTheme.of(
  //                                                                 context)
  //                                                             .bodyMedium
  //                                                             .override(
  //                                                               font:
  //                                                                   GoogleFonts
  //                                                                       .inter(
  //                                                                 fontWeight: FlutterFlowTheme.of(
  //                                                                         context)
  //                                                                     .bodyMedium
  //                                                                     .fontWeight,
  //                                                                 fontStyle: FlutterFlowTheme.of(
  //                                                                         context)
  //                                                                     .bodyMedium
  //                                                                     .fontStyle,
  //                                                               ),
  //                                                               color: FlutterFlowTheme.of(
  //                                                                       context)
  //                                                                   .secondaryText,
  //                                                               letterSpacing:
  //                                                                   0.0,
  //                                                               fontWeight: FlutterFlowTheme.of(
  //                                                                       context)
  //                                                                   .bodyMedium
  //                                                                   .fontWeight,
  //                                                               fontStyle: FlutterFlowTheme.of(
  //                                                                       context)
  //                                                                   .bodyMedium
  //                                                                   .fontStyle,
  //                                                             ),
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   Padding(
  //                                     padding: EdgeInsetsDirectional.fromSTEB(
  //                                         16.0, 0.0, 16.0, 0.0),
  //                                     child: FFButtonWidget(
  //                                       onPressed: ()  {
  //                                          launchUrl(Uri(
  //                                           scheme: 'mailto',
  //                                           path: supportPageContactSetupRecord!
  //                                               .emailID,
  //                                         ));
  //                                       },
  //                                       text: 'Send Email',
  //                                       options: FFButtonOptions(
  //                                         width: double.infinity,
  //                                         height: 44.0,
  //                                         padding: EdgeInsets.all(8.0),
  //                                         iconPadding:
  //                                             EdgeInsetsDirectional.fromSTEB(
  //                                                 0.0, 0.0, 0.0, 0.0),
  //                                         color: Color(0xFFF0F0FF),
  //                                         textStyle: FlutterFlowTheme.of(
  //                                                 context)
  //                                             .bodyMedium
  //                                             .override(
  //                                               font: GoogleFonts.inter(
  //                                                 fontWeight:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontWeight,
  //                                                 fontStyle:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontStyle,
  //                                               ),
  //                                               color: Color(0xFF5C6BC0),
  //                                               letterSpacing: 0.0,
  //                                               fontWeight:
  //                                                   FlutterFlowTheme.of(context)
  //                                                       .bodyMedium
  //                                                       .fontWeight,
  //                                               fontStyle:
  //                                                   FlutterFlowTheme.of(context)
  //                                                       .bodyMedium
  //                                                       .fontStyle,
  //                                             ),
  //                                         elevation: 0.0,
  //                                         borderSide: BorderSide(
  //                                           color: Colors.transparent,
  //                                         ),
  //                                         borderRadius:
  //                                             BorderRadius.circular(8.0),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Container(),
  //                         Padding(
  //                           padding: EdgeInsetsDirectional.fromSTEB(
  //                               0.0, 0.0, 0.0, 16.0),
  //                           child: Container(
  //                             width: double.infinity,
  //                             decoration: BoxDecoration(
  //                               color: FlutterFlowTheme.of(context)
  //                                   .containerColour,
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   blurRadius: 4.0,
  //                                   color: Color(0x10000000),
  //                                 )
  //                               ],
  //                               borderRadius: BorderRadius.circular(12.0),
  //                             ),
  //                             child: Padding(
  //                               padding: EdgeInsets.all(16.0),
  //                               child: Column(
  //                                 mainAxisSize: MainAxisSize.max,
  //                                 children: [
  //                                   Padding(
  //                                     padding: EdgeInsets.all(16.0),
  //                                     child: Row(
  //                                       mainAxisSize: MainAxisSize.max,
  //                                       children: [
  //                                         Container(
  //                                           width: 48.0,
  //                                           height: 48.0,
  //                                           decoration: BoxDecoration(
  //                                             color: Color(0xFFFFF0E6),
  //                                             shape: BoxShape.circle,
  //                                           ),
  //                                           child: Align(
  //                                             alignment: AlignmentDirectional(
  //                                                 0.0, 0.0),
  //                                             child: Icon(
  //                                               Icons.phone,
  //                                               color: Colors.orange,
  //                                               size: 24.0,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         Flexible(
  //                                           child: Padding(
  //                                             padding: EdgeInsetsDirectional
  //                                                 .fromSTEB(
  //                                                     16.0, 0.0, 16.0, 0.0),
  //                                             child: Column(
  //                                               mainAxisSize: MainAxisSize.max,
  //                                               crossAxisAlignment:
  //                                                   CrossAxisAlignment.start,
  //                                               children: [
  //                                                 Text(
  //                                                   'Phone Support',
  //                                                   style: FlutterFlowTheme.of(
  //                                                           context)
  //                                                       .titleMedium
  //                                                       .override(
  //                                                         font: GoogleFonts
  //                                                             .interTight(
  //                                                           fontWeight:
  //                                                               FontWeight.w600,
  //                                                           fontStyle:
  //                                                               FlutterFlowTheme.of(
  //                                                                       context)
  //                                                                   .titleMedium
  //                                                                   .fontStyle,
  //                                                         ),
  //                                                         letterSpacing: 0.0,
  //                                                         fontWeight:
  //                                                             FontWeight.w600,
  //                                                         fontStyle:
  //                                                             FlutterFlowTheme.of(
  //                                                                     context)
  //                                                                 .titleMedium
  //                                                                 .fontStyle,
  //                                                       ),
  //                                                 ),
  //                                                 Padding(
  //                                                   padding:
  //                                                       EdgeInsetsDirectional
  //                                                           .fromSTEB(0.0, 4.0,
  //                                                               0.0, 0.0),
  //                                                   child: Text(
  //                                                     valueOrDefault<String>(
  //                                                       supportPageContactSetupRecord
  //                                                           ?.phoneNumber,
  //                                                       '+91',
  //                                                     ),
  //                                                     style:
  //                                                         FlutterFlowTheme.of(
  //                                                                 context)
  //                                                             .bodyMedium
  //                                                             .override(
  //                                                               font:
  //                                                                   GoogleFonts
  //                                                                       .inter(
  //                                                                 fontWeight: FlutterFlowTheme.of(
  //                                                                         context)
  //                                                                     .bodyMedium
  //                                                                     .fontWeight,
  //                                                                 fontStyle: FlutterFlowTheme.of(
  //                                                                         context)
  //                                                                     .bodyMedium
  //                                                                     .fontStyle,
  //                                                               ),
  //                                                               color: FlutterFlowTheme.of(
  //                                                                       context)
  //                                                                   .secondaryText,
  //                                                               letterSpacing:
  //                                                                   0.0,
  //                                                               fontWeight: FlutterFlowTheme.of(
  //                                                                       context)
  //                                                                   .bodyMedium
  //                                                                   .fontWeight,
  //                                                               fontStyle: FlutterFlowTheme.of(
  //                                                                       context)
  //                                                                   .bodyMedium
  //                                                                   .fontStyle,
  //                                                             ),
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   Padding(
  //                                     padding: EdgeInsetsDirectional.fromSTEB(
  //                                         16.0, 0.0, 16.0, 0.0),
  //                                     child: FFButtonWidget(
  //                                       onPressed: ()  {
  //                                          launchUrl(Uri(
  //                                           scheme: 'tel',
  //                                           path: supportPageContactSetupRecord!
  //                                               .phoneNumber,
  //                                         ));
  //                                       },
  //                                       text: 'Call Now',
  //                                       options: FFButtonOptions(
  //                                         width: double.infinity,
  //                                         height: 44.0,
  //                                         padding: EdgeInsets.all(8.0),
  //                                         iconPadding:
  //                                             EdgeInsetsDirectional.fromSTEB(
  //                                                 0.0, 0.0, 0.0, 0.0),
  //                                         color: Color(0xFFFFF0E6),
  //                                         textStyle: FlutterFlowTheme.of(
  //                                                 context)
  //                                             .bodyMedium
  //                                             .override(
  //                                               font: GoogleFonts.inter(
  //                                                 fontWeight:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontWeight,
  //                                                 fontStyle:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontStyle,
  //                                               ),
  //                                               color: Colors.orange,
  //                                               letterSpacing: 0.0,
  //                                               fontWeight:
  //                                                   FlutterFlowTheme.of(context)
  //                                                       .bodyMedium
  //                                                       .fontWeight,
  //                                               fontStyle:
  //                                                   FlutterFlowTheme.of(context)
  //                                                       .bodyMedium
  //                                                       .fontStyle,
  //                                             ),
  //                                         elevation: 0.0,
  //                                         borderSide: BorderSide(
  //                                           color: Colors.transparent,
  //                                         ),
  //                                         borderRadius:
  //                                             BorderRadius.circular(8.0),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Container(),
  //                         Container(),
  //                         Padding(
  //                           padding: EdgeInsetsDirectional.fromSTEB(
  //                               0.0, 0.0, 0.0, 20.0),
  //                           child: Container(
  //                             width: double.infinity,
  //                             decoration: BoxDecoration(
  //                               color: FlutterFlowTheme.of(context)
  //                                   .containerColour,
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   blurRadius: 4.0,
  //                                   color: Color(0x10000000),
  //                                 )
  //                               ],
  //                               borderRadius: BorderRadius.circular(12.0),
  //                             ),
  //                             child: Padding(
  //                               padding: EdgeInsets.all(16.0),
  //                               child: Column(
  //                                 mainAxisSize: MainAxisSize.max,
  //                                 children: [
  //                                   Text(
  //                                     'Support Hours',
  //                                     style: FlutterFlowTheme.of(context)
  //                                         .titleMedium
  //                                         .override(
  //                                           font: GoogleFonts.interTight(
  //                                             fontWeight: FontWeight.w600,
  //                                             fontStyle:
  //                                                 FlutterFlowTheme.of(context)
  //                                                     .titleMedium
  //                                                     .fontStyle,
  //                                           ),
  //                                           letterSpacing: 0.0,
  //                                           fontWeight: FontWeight.w600,
  //                                           fontStyle:
  //                                               FlutterFlowTheme.of(context)
  //                                                   .titleMedium
  //                                                   .fontStyle,
  //                                         ),
  //                                   ),
  //                                   Padding(
  //                                     padding: EdgeInsetsDirectional.fromSTEB(
  //                                         0.0, 8.0, 0.0, 8.0),
  //                                     child: Divider(
  //                                       height: 1.0,
  //                                       thickness: 1.0,
  //                                       color: FlutterFlowTheme.of(context)
  //                                           .alternate,
  //                                     ),
  //                                   ),
  //                                   Padding(
  //                                     padding: EdgeInsetsDirectional.fromSTEB(
  //                                         0.0, 4.0, 0.0, 4.0),
  //                                     child: Row(
  //                                       mainAxisSize: MainAxisSize.max,
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.spaceBetween,
  //                                       children: [
  //                                         Text(
  //                                           'Monday - Friday',
  //                                           style: FlutterFlowTheme.of(context)
  //                                               .bodyMedium
  //                                               .override(
  //                                                 font: GoogleFonts.inter(
  //                                                   fontWeight:
  //                                                       FlutterFlowTheme.of(
  //                                                               context)
  //                                                           .bodyMedium
  //                                                           .fontWeight,
  //                                                   fontStyle:
  //                                                       FlutterFlowTheme.of(
  //                                                               context)
  //                                                           .bodyMedium
  //                                                           .fontStyle,
  //                                                 ),
  //                                                 letterSpacing: 0.0,
  //                                                 fontWeight:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontWeight,
  //                                                 fontStyle:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontStyle,
  //                                               ),
  //                                         ),
  //                                         Text(
  //                                           '9:00 AM - 8:00 PM IST',
  //                                           style: FlutterFlowTheme.of(context)
  //                                               .bodyMedium
  //                                               .override(
  //                                                 font: GoogleFonts.inter(
  //                                                   fontWeight:
  //                                                       FlutterFlowTheme.of(
  //                                                               context)
  //                                                           .bodyMedium
  //                                                           .fontWeight,
  //                                                   fontStyle:
  //                                                       FlutterFlowTheme.of(
  //                                                               context)
  //                                                           .bodyMedium
  //                                                           .fontStyle,
  //                                                 ),
  //                                                 letterSpacing: 0.0,
  //                                                 fontWeight:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontWeight,
  //                                                 fontStyle:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontStyle,
  //                                               ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   Padding(
  //                                     padding: EdgeInsetsDirectional.fromSTEB(
  //                                         0.0, 4.0, 0.0, 4.0),
  //                                     child: Row(
  //                                       mainAxisSize: MainAxisSize.max,
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.spaceBetween,
  //                                       children: [
  //                                         Text(
  //                                           'Saturday',
  //                                           style: FlutterFlowTheme.of(context)
  //                                               .bodyMedium
  //                                               .override(
  //                                                 font: GoogleFonts.inter(
  //                                                   fontWeight:
  //                                                       FlutterFlowTheme.of(
  //                                                               context)
  //                                                           .bodyMedium
  //                                                           .fontWeight,
  //                                                   fontStyle:
  //                                                       FlutterFlowTheme.of(
  //                                                               context)
  //                                                           .bodyMedium
  //                                                           .fontStyle,
  //                                                 ),
  //                                                 letterSpacing: 0.0,
  //                                                 fontWeight:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontWeight,
  //                                                 fontStyle:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontStyle,
  //                                               ),
  //                                         ),
  //                                         Text(
  //                                           '10:00 AM - 6:00 PM IST',
  //                                           style: FlutterFlowTheme.of(context)
  //                                               .bodyMedium
  //                                               .override(
  //                                                 font: GoogleFonts.inter(
  //                                                   fontWeight:
  //                                                       FlutterFlowTheme.of(
  //                                                               context)
  //                                                           .bodyMedium
  //                                                           .fontWeight,
  //                                                   fontStyle:
  //                                                       FlutterFlowTheme.of(
  //                                                               context)
  //                                                           .bodyMedium
  //                                                           .fontStyle,
  //                                                 ),
  //                                                 letterSpacing: 0.0,
  //                                                 fontWeight:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontWeight,
  //                                                 fontStyle:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontStyle,
  //                                               ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   Padding(
  //                                     padding: EdgeInsetsDirectional.fromSTEB(
  //                                         0.0, 4.0, 0.0, 4.0),
  //                                     child: Row(
  //                                       mainAxisSize: MainAxisSize.max,
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.spaceBetween,
  //                                       children: [
  //                                         Text(
  //                                           'Sunday',
  //                                           style: FlutterFlowTheme.of(context)
  //                                               .bodyMedium
  //                                               .override(
  //                                                 font: GoogleFonts.inter(
  //                                                   fontWeight:
  //                                                       FlutterFlowTheme.of(
  //                                                               context)
  //                                                           .bodyMedium
  //                                                           .fontWeight,
  //                                                   fontStyle:
  //                                                       FlutterFlowTheme.of(
  //                                                               context)
  //                                                           .bodyMedium
  //                                                           .fontStyle,
  //                                                 ),
  //                                                 letterSpacing: 0.0,
  //                                                 fontWeight:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontWeight,
  //                                                 fontStyle:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontStyle,
  //                                               ),
  //                                         ),
  //                                         Text(
  //                                           'Closed',
  //                                           style: FlutterFlowTheme.of(context)
  //                                               .bodyMedium
  //                                               .override(
  //                                                 font: GoogleFonts.inter(
  //                                                   fontWeight:
  //                                                       FlutterFlowTheme.of(
  //                                                               context)
  //                                                           .bodyMedium
  //                                                           .fontWeight,
  //                                                   fontStyle:
  //                                                       FlutterFlowTheme.of(
  //                                                               context)
  //                                                           .bodyMedium
  //                                                           .fontStyle,
  //                                                 ),
  //                                                 letterSpacing: 0.0,
  //                                                 fontWeight:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontWeight,
  //                                                 fontStyle:
  //                                                     FlutterFlowTheme.of(
  //                                                             context)
  //                                                         .bodyMedium
  //                                                         .fontStyle,
  //                                               ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderRadius: 30.0,
          icon: Icon(Icons.arrow_back_rounded, color: FlutterFlowTheme.of(context).primaryText),
          onPressed: () => context.pop(),
        ),
        title: Text('Support', style: FlutterFlowTheme.of(context).headlineMedium),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text('How can we help you today?', style: FlutterFlowTheme.of(context).bodyLarge),
              ),

              // ✅ Live Chat
              _buildSupportCard(
                icon: Icons.chat_bubble_outline,
                iconColor: FlutterFlowTheme.of(context).primary,
                bgColor: Color(0xFFE6F5FF),
                title: 'Live Chat Support',
                subtitle: 'Chat with our support team in real-time',
                onTap: () => launchUrl(Uri.parse('https://your-live-chat-link.com')), // Replace with actual
              ),

              SizedBox(height: 16.0),

              // ✅ WhatsApp
              _buildSupportCard(
                iconData: FontAwesomeIcons.whatsapp,
                iconColor: Color(0xFF25D366),
                bgColor: Color(0xFFE8F8E8),
                title: 'WhatsApp Support',
                subtitle: 'Message us on WhatsApp for quick assistance',
                onTap: () => launchUrl(Uri.parse('https://wa.me/919876543210')), // Replace number
              ),

              SizedBox(height: 16.0),

              // ✅ Email
              _buildSupportCard(
                icon: Icons.email_outlined,
                iconColor: Color(0xFF5C6BC0),
                bgColor: Color(0xFFF0F0FF),
                title: 'Email Support',
                subtitle: 'support@traviaconnect.com',
                onTap: () => launchUrl(Uri(scheme: 'mailto', path: 'support@traviaconnect.com')),
              ),

              SizedBox(height: 16.0),

              // ✅ Phone
              _buildSupportCard(
                icon: Icons.phone,
                iconColor: Colors.orange,
                bgColor: Color(0xFFFFF0E6),
                title: 'Phone Support',
                subtitle: '+91 98765 43210', // Replace number
                onTap: () => launchUrl(Uri(scheme: 'tel', path: '+919876543210')),
              ),

              SizedBox(height: 24.0),

              // ✅ Support Hours
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).containerColour,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [BoxShadow(blurRadius: 4, color: Color(0x10000000))],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Support Hours', style: FlutterFlowTheme.of(context).titleMedium.override(fontWeight: FontWeight.w600)),
                      SizedBox(height: 8.0),

                      Divider(height: 1, thickness: 1),
                      SizedBox(height: 8.0),

                      _buildHourRow('Monday - Friday', '9:00 AM - 8:00 PM IST'),
                      _buildHourRow('Saturday', '10:00 AM - 6:00 PM IST'),
                      _buildHourRow('Sunday', 'Closed'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.0),

            ],
          ),
        ),
      ),
    );
  }

// ✅ Helper Method 1
  Widget _buildSupportCard({
    IconData? icon,
    IconData? iconData,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).containerColour,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [BoxShadow(blurRadius: 4, color: Color(0x10000000))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
                  child: icon != null
                      ? Icon(icon, color: iconColor, size: 24)
                      : FaIcon(iconData!, color: iconColor, size: 24),
                ),
                SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: FlutterFlowTheme.of(context).titleMedium.override(fontWeight: FontWeight.w600)),
                      SizedBox(height: 4),
                      Text(subtitle, style: FlutterFlowTheme.of(context).bodyMedium.override(color: FlutterFlowTheme.of(context).secondaryText)),
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

// ✅ Helper Method 2
  Widget _buildHourRow(String day, String time) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: FlutterFlowTheme.of(context).bodyMedium),
          Text(time, style: FlutterFlowTheme.of(context).bodyMedium),
        ],
      ),
    );
  }

}
