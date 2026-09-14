import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'market_ride2_model.dart';
export 'market_ride2_model.dart';

class MarketRide2Widget extends StatefulWidget {
  const MarketRide2Widget({super.key});

  static String routeName = 'marketRide2';
  static String routePath = '/marketRide2';

  @override
  State<MarketRide2Widget> createState() => _MarketRide2WidgetState();
}

class _MarketRide2WidgetState extends State<MarketRide2Widget> {
  late MarketRide2Model _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MarketRide2Model());

    _model.descriptionoftheitemTextController = TextEditingController();
    _model.descriptionoftheitemFocusNode = FocusNode();

    _model.priceTextController = TextEditingController();
    _model.priceFocusNode = FocusNode();

    _model.quantityTextController = TextEditingController();
    _model.quantityFocusNode = FocusNode();

    // Pre-fill from app state if returning
    if (FFAppState().Descriptionoftheitem.isNotEmpty) {
      _model.descriptionoftheitemTextController.text = FFAppState().Descriptionoftheitem;
    }
    if (FFAppState().price.isNotEmpty) {
      _model.priceTextController.text = FFAppState().price;
    }
    if (FFAppState().quantity.isNotEmpty) {
      _model.quantityTextController.text = FFAppState().quantity;
    }
    if (FFAppState().marketPlaceAriveDate != null) {
      _model.datePicked = FFAppState().marketPlaceAriveDate;
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _model.datePicked ?? now,
      firstDate: now,
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFEE7B4D),
              onPrimary: Colors.white,
              onSurface: Color(0xFF1E293B),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) return;
    if (!mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _model.datePicked != null
          ? TimeOfDay.fromDateTime(_model.datePicked!)
          : TimeOfDay.fromDateTime(now),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFEE7B4D),
              onPrimary: Colors.white,
              onSurface: Color(0xFF1E293B),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        _model.datePicked = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  void _validateAndProceed() {
    final description = _model.descriptionoftheitemTextController.text.trim();
    final price = _model.priceTextController.text.trim();
    final quantity = _model.quantityTextController.text.trim();

    if (description.isEmpty || price.isEmpty || quantity.isEmpty || _model.datePicked == null) {
      showDialog(
        context: context,
        builder: (alertDialogContext) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(
            'Missing Details',
            style: GoogleFonts.inter(fontSize: 17.0, fontWeight: FontWeight.w700),
          ),
          content: Text(
            'Please fill in the description, price, quantity, and scheduled arrival date before proceeding.',
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

    FFAppState().Descriptionoftheitem = description;
    FFAppState().price = price;
    FFAppState().quantity = quantity;
    FFAppState().marketPlaceAriveDate = _model.datePicked;
    safeSetState(() {});

    context.pushNamed(MarketRide3Widget.routeName);
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
            'Pricing & Schedule',
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

              // Scrollable Form Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Title
                      Text(
                        'Details & Schedule',
                        style: GoogleFonts.inter(
                          fontSize: 21.0,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Provide pricing, quantity, and your expected arrival date.',
                        style: GoogleFonts.inter(
                          fontSize: 13.0,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // Description Card
                      Container(
                        padding: const EdgeInsets.all(18.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x06000000),
                              blurRadius: 10.0,
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
                                  width: 32.0,
                                  height: 32.0,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFF5ED),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.notes_rounded,
                                    color: Color(0xFFEE7B4D),
                                    size: 18.0,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  'Item Description *',
                                  style: GoogleFonts.inter(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF111827),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(14.0),
                                border: Border.all(color: const Color(0xFFCBD5E1)),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                              child: TextFormField(
                                controller: _model.descriptionoftheitemTextController,
                                focusNode: _model.descriptionoftheitemFocusNode,
                                minLines: 3,
                                maxLines: 5,
                                style: GoogleFonts.inter(fontSize: 14.0, color: const Color(0xFF1E293B)),
                                decoration: InputDecoration(
                                  hintText: 'Describe condition, packaging, special handling notes, or flavors...',
                                  hintStyle: GoogleFonts.inter(fontSize: 13.0, color: const Color(0xFF94A3B8)),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18.0),

                      // Price & Quantity in Side-by-Side Row
                      Row(
                        children: [
                          // Price Input
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x06000000),
                                    blurRadius: 10.0,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price (₹) *',
                                    style: GoogleFonts.inter(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF111827),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF8FAFC),
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(color: const Color(0xFFCBD5E1)),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '₹',
                                          style: GoogleFonts.inter(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFFEE7B4D),
                                          ),
                                        ),
                                        const SizedBox(width: 6.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: _model.priceTextController,
                                            focusNode: _model.priceFocusNode,
                                            keyboardType: TextInputType.number,
                                            style: GoogleFonts.inter(fontSize: 15.0, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                                            decoration: InputDecoration(
                                              hintText: '250',
                                              hintStyle: GoogleFonts.inter(fontSize: 14.0, color: const Color(0xFF94A3B8)),
                                              border: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              focusedErrorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              isDense: true,
                                              contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
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
                          const SizedBox(width: 14.0),

                          // Quantity Input
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x06000000),
                                    blurRadius: 10.0,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Quantity *',
                                    style: GoogleFonts.inter(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF111827),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF8FAFC),
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(color: const Color(0xFFCBD5E1)),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                                    child: TextFormField(
                                      controller: _model.quantityTextController,
                                      focusNode: _model.quantityFocusNode,
                                      style: GoogleFonts.inter(fontSize: 14.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                                      decoration: InputDecoration(
                                        hintText: 'e.g. 2 kg, 5 boxes',
                                        hintStyle: GoogleFonts.inter(fontSize: 13.0, color: const Color(0xFF94A3B8)),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18.0),

                      // Arrival Date & Time Card
                      Container(
                        padding: const EdgeInsets.all(18.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x06000000),
                              blurRadius: 10.0,
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
                                  width: 32.0,
                                  height: 32.0,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEFF6FF),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.calendar_today_rounded,
                                    color: Color(0xFF3B82F6),
                                    size: 17.0,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  'Expected Arrival Date & Time *',
                                  style: GoogleFonts.inter(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF111827),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: _selectDateTime,
                                borderRadius: BorderRadius.circular(14.0),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                                  decoration: BoxDecoration(
                                    color: _model.datePicked != null ? const Color(0xFFFFF5ED) : const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(14.0),
                                    border: Border.all(
                                      color: _model.datePicked != null ? const Color(0xFFEE7B4D) : const Color(0xFFCBD5E1),
                                      width: _model.datePicked != null ? 1.5 : 1.0,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_rounded,
                                        color: _model.datePicked != null ? const Color(0xFFEE7B4D) : const Color(0xFF94A3B8),
                                        size: 20.0,
                                      ),
                                      const SizedBox(width: 12.0),
                                      Expanded(
                                        child: Text(
                                          _model.datePicked != null
                                              ? '${dateTimeFormat('yMMMd', _model.datePicked!)} at ${dateTimeFormat('jm', _model.datePicked!)}'
                                              : 'Tap to pick arrival date and time...',
                                          style: GoogleFonts.inter(
                                            fontSize: 14.0,
                                            fontWeight: _model.datePicked != null ? FontWeight.w700 : FontWeight.normal,
                                            color: _model.datePicked != null ? const Color(0xFF111827) : const Color(0xFF94A3B8),
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.edit_calendar_rounded,
                                        color: _model.datePicked != null ? const Color(0xFFEE7B4D) : const Color(0xFF94A3B8),
                                        size: 18.0,
                                      ),
                                    ],
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
                      onPressed: _validateAndProceed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue to Preview',
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
                'Step 2 of 3',
                style: GoogleFonts.inter(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFEE7B4D),
                ),
              ),
              Text(
                'Pricing & Schedule',
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
                    color: const Color(0xFFE2E8F0),
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
