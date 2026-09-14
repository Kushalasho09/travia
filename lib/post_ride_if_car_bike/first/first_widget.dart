import '/components/publish_ride_progress_header.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'first_model.dart';
export 'first_model.dart';

class FirstWidget extends StatefulWidget {
  const FirstWidget({super.key});

  static String routeName = 'first';
  static String routePath = '/first';

  @override
  State<FirstWidget> createState() => _FirstWidgetState();
}

class _FirstWidgetState extends State<FirstWidget> {
  late FirstModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FirstModel());
    _model.isCarryPassangerValue ??= 'Yes';
    _model.carryParcelValue ??= 'Yes';
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _proceedNext() {
    if (_model.isCarryPassangerValue == null || _model.carryParcelValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose your preferences for passengers and parcels.'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    FFAppState().isPassengers = _model.isCarryPassangerValue!;
    safeSetState(() {});

    final key = '${_model.isCarryPassangerValue}-${_model.carryParcelValue}';
    final routeMap = {
      'Yes-Yes': SecondWidget.routeName,
      'No-Yes': ThirdWidget.routeName,
      'Yes-No': Pansanger5BWidget.routeName,
      'No-No': ThirdWidget.routeName,
    };

    final destinationRoute = routeMap[key] ?? SecondWidget.routeName;
    context.pushNamed(destinationRoute);
  }

  Widget _buildToggleOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String? currentValue,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: const Color(0xFFEAECEF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 16.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42.0,
                height: 42.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF6EE),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFFEE7B4D),
                  size: 22.0,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => onChanged('Yes'),
                  borderRadius: BorderRadius.circular(14.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: BoxDecoration(
                      color: currentValue == 'Yes'
                          ? const Color(0xFFFFF6EE)
                          : const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(14.0),
                      border: Border.all(
                        color: currentValue == 'Yes'
                            ? const Color(0xFFEE7B4D)
                            : const Color(0xFFE5E7EB),
                        width: currentValue == 'Yes' ? 1.5 : 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 18.0,
                          color: currentValue == 'Yes'
                              ? const Color(0xFFEE7B4D)
                              : const Color(0xFF9CA3AF),
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          'Yes, Offer',
                          style: GoogleFonts.inter(
                            fontSize: 13.5,
                            fontWeight: currentValue == 'Yes' ? FontWeight.w700 : FontWeight.w500,
                            color: currentValue == 'Yes'
                                ? const Color(0xFFEE7B4D)
                                : const Color(0xFF4B5563),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: InkWell(
                  onTap: () => onChanged('No'),
                  borderRadius: BorderRadius.circular(14.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: BoxDecoration(
                      color: currentValue == 'No'
                          ? const Color(0xFFFFF6EE)
                          : const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(14.0),
                      border: Border.all(
                        color: currentValue == 'No'
                            ? const Color(0xFFEE7B4D)
                            : const Color(0xFFE5E7EB),
                        width: currentValue == 'No' ? 1.5 : 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cancel_rounded,
                          size: 18.0,
                          color: currentValue == 'No'
                              ? const Color(0xFFEE7B4D)
                              : const Color(0xFF9CA3AF),
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          'No, Don\'t Offer',
                          style: GoogleFonts.inter(
                            fontSize: 13.5,
                            fontWeight: currentValue == 'No' ? FontWeight.w700 : FontWeight.w500,
                            color: currentValue == 'No'
                                ? const Color(0xFFEE7B4D)
                                : const Color(0xFF4B5563),
                          ),
                        ),
                      ],
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

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

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
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 48.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF1F2937),
              size: 24.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Publish Ride',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
              fontSize: 18.0,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Step Progress Header
                      const PublishRideProgressHeader(
                        currentStep: 5,
                        totalSteps: 8,
                        title: 'Trip Travel Options',
                        subtitle: 'Select if you want to share seats with passengers or carry parcels.',
                        badgeText: 'STEP 5 OF 8',
                      ),

                      // Passenger Carpool Card
                      _buildToggleOptionCard(
                        icon: Icons.airline_seat_recline_normal_rounded,
                        title: 'Share Ride with Passengers',
                        subtitle: 'Allow travelers heading to your destination to book empty seats.',
                        currentValue: _model.isCarryPassangerValue,
                        onChanged: (val) {
                          setState(() {
                            _model.isCarryPassangerValue = val;
                            _model.isPassangerAllowed = val;
                          });
                        },
                      ),

                      // Parcel Delivery Card
                      _buildToggleOptionCard(
                        icon: Icons.inventory_2_outlined,
                        title: 'Carry Parcels & Packages',
                        subtitle: 'Monetize extra car boot or bag space by transporting legal items.',
                        currentValue: _model.carryParcelValue,
                        onChanged: (val) {
                          setState(() {
                            _model.carryParcelValue = val;
                          });
                        },
                      ),

                      // Info Notice Box
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF7F2),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: const Color(0xFFD6EFE1)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.lightbulb_outline_rounded,
                              color: Color(0xFF10B981),
                              size: 20.0,
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Text(
                                'Offering both carpooling and parcels maximizes your cost recovery on highway trips.',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF065F46),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  height: 1.35,
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

              // Bottom Fixed Action Button Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFF1F5F9),
                      width: 1.0,
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: _proceedNext,
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    width: double.infinity,
                    height: 52.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEE7B4D),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33EE7B4D),
                          blurRadius: 12.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue',
                          style: GoogleFonts.inter(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20.0,
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
    );
  }
}
