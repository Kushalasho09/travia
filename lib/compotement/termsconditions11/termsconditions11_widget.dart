import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'termsconditions11_model.dart';
export 'termsconditions11_model.dart';

typedef NewTermsconditions11Widget = Termsconditions11Widget;

class Termsconditions11Widget extends StatefulWidget {
  const Termsconditions11Widget({super.key});

  @override
  State<Termsconditions11Widget> createState() =>
      _Termsconditions11WidgetState();
}

class _Termsconditions11WidgetState extends State<Termsconditions11Widget> {
  late Termsconditions11Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Termsconditions11Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required List<String> bulletPoints,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFEAECEF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF6EE),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFFEE7B4D),
                  size: 16.0,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          ...bulletPoints.map((point) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6.0),
                    width: 5.0,
                    height: 5.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF9CA3AF),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      point,
                      style: GoogleFonts.inter(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF4B5563),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 20.0,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Drag Handle Bar
          const SizedBox(height: 12.0),
          Container(
            width: 44.0,
            height: 4.5,
            decoration: BoxDecoration(
              color: const Color(0xFFD1D5DB),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          const SizedBox(height: 16.0),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0ECFD),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Icon(
                    Icons.verified_user_rounded,
                    color: Color(0xFF6C4DF6),
                    size: 22.0,
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Terms & Safety Policies',
                        style: GoogleFonts.inter(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      Text(
                        'Please review before confirming your ride',
                        style: GoogleFonts.inter(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Color(0xFF9CA3AF)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const Divider(height: 24.0, color: Color(0xFFF1F5F9)),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overview Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14.0),
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF6EE),
                      borderRadius: BorderRadius.circular(14.0),
                      border: Border.all(color: const Color(0xFFFFD9C2)),
                    ),
                    child: Text(
                      'Travia is a community-driven facilitator connecting travelers with parcel senders. Travia does not own or operate transportation services and acts solely as an introductory discovery platform.',
                      style: GoogleFonts.inter(
                        fontSize: 12.5,
                        color: const Color(0xFF9A3412),
                        height: 1.4,
                      ),
                    ),
                  ),

                  _buildSectionCard(
                    icon: Icons.shield_outlined,
                    title: '1. No Delivery Liability',
                    bulletPoints: [
                      'Travia is not a courier service, cargo agent, or logistics contractor.',
                      'All carriage arrangements are formed directly between sender and traveler at their own mutual discretion.',
                      'Travia is not liable for parcel loss, transit damage, route delays, or non-delivery.',
                    ],
                  ),

                  _buildSectionCard(
                    icon: Icons.assignment_outlined,
                    title: '2. User Responsibilities',
                    bulletPoints: [
                      'Senders must accurately declare contents, delicacy, and dimensions beforehand.',
                      'Travelers have the right to inspect package exteriors and refuse prohibited goods.',
                      'Both parties must verify identity and contact numbers prior to handover.',
                    ],
                  ),

                  _buildSectionCard(
                    icon: Icons.block_rounded,
                    title: '3. Prohibited & Illegal Items',
                    bulletPoints: [
                      'Strict prohibition on hazardous substances, flammable liquids, contraband, and illegal materials.',
                      'Any suspicious or unlawful parcel will immediately be reported to law enforcement.',
                    ],
                  ),

                  _buildSectionCard(
                    icon: Icons.handshake_outlined,
                    title: '4. Direct Communication & Coordination',
                    bulletPoints: [
                      'Pick-up location, drop address, and parcel handover times should be coordinated on confirmed call.',
                      'Ensure timely arrival (at least 10 minutes prior to scheduled departure).',
                    ],
                  ),

                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),

          // Bottom Action Button
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
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFEE7B4D),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33EE7B4D),
                      blurRadius: 10.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'I Understand & Accept',
                    style: GoogleFonts.inter(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
