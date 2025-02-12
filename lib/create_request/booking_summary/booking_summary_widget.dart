import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/alert_dialog_widget.dart';
import '/create_request/checkout_dialog/checkout_dialog_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'booking_summary_model.dart';
export 'booking_summary_model.dart';

/// Page Name: Request to Book
/// Description:
/// This page allows users to review their booking details before confirming a
/// car rental.
///
/// It includes key information such as the selected car, trip dates, pickup
/// location, and payment summary.
///
/// UI Structure:
/// AppBar (Top Navigation)
///
/// Left-aligned Back Button (← Icon).
/// Center-aligned Title: "Request to Book".
/// Car Information Section
///
/// Car Image (Rounded Thumbnail, Left-Aligned).
/// Car Model Name ("Tesla Roadster"), bold font.
/// Car Owner Label in a smaller font.
/// Rating & Trip Count
/// Star icon ⭐ 5.00 (bold)
/// 139 Trips (lighter font).
/// Rental Price (EGP28.32/day) in bold.
/// Trip Date & Time Section
///
/// Start Date & Time (Left-Aligned) → End Date & Time (Right-Aligned).
/// Displayed in a pill-shaped card with a subtle shadow.
/// Pickup & Return Location
///
/// Pin Icon 📍
/// Location Details (e.g., "Giza, 6October city, D center Zahraa October").
/// Payment Details Section
///
/// Card Container with rounded corners and subtle shadow.
/// Breakdown of Pricing:
/// "720 X 7 days" → "5,040" (Regular font).
/// Total Amount: "EGP 5,040" (Bold).
/// Styling & Design Preferences:
/// Minimalist, clean UI with white background.
/// Soft rounded edges for input fields and cards.
/// Blue and black color scheme for contrast.
/// Consistent spacing between elements.
/// Mobile-friendly and responsive layout.
class BookingSummaryWidget extends StatefulWidget {
  const BookingSummaryWidget({
    super.key,
    required this.tripDocument,
    this.bookedCar,
  });

  final TripRecord? tripDocument;
  final CarRecord? bookedCar;

  @override
  State<BookingSummaryWidget> createState() => _BookingSummaryWidgetState();
}

class _BookingSummaryWidgetState extends State<BookingSummaryWidget> {
  late BookingSummaryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookingSummaryModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.fullPrice = valueOrDefault<double>(
            widget.tripDocument?.totalPrice,
            5050.0,
          ) +
          valueOrDefault<double>(
            (FFAppConstants.serviceProvantage / 100) *
                widget.tripDocument!.totalPrice,
            1026.0,
          ) +
          FFAppConstants.insuranceDeposit;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(43.0),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            leading: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24.0,
              ),
            ),
            title: Text(
              'Request Car Booking',
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: 'Open Sans',
                    letterSpacing: 0.0,
                  ),
            ),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                child: FlutterFlowIconButton(
                  borderRadius: 8.0,
                  buttonSize: 40.0,
                  fillColor: FlutterFlowTheme.of(context).secondary,
                  icon: Icon(
                    Icons.delete_rounded,
                    color: FlutterFlowTheme.of(context).info,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    await widget.tripDocument!.reference.delete();
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).success,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      widget.tripDocument?.status?.name,
                      'unConfirmed',
                    ),
                    style: FlutterFlowTheme.of(context).labelSmall.override(
                          fontFamily: 'Open Sans',
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          fontSize: 10.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ),
            ],
            centerTitle: false,
            elevation: 0.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Builder(
                      builder: (context) {
                        if (widget.bookedCar != null) {
                          return Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    valueOrDefault<String>(
                                      widget.bookedCar?.carPhotos.firstOrNull,
                                      'https://images.unsplash.com/photo-1510903117032-f1596c327647?w=800&h=800',
                                    ),
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          '${widget.bookedCar?.make} ${widget.bookedCar?.model}',
                                          'BYD F3',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              fontFamily: 'Open Sans',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.star_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 20.0,
                                          ),
                                          Text(
                                            formatNumber(
                                              widget.bookedCar!.rate,
                                              formatType: FormatType.custom,
                                              format: '#.#',
                                              locale: '',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          Text(
                                            '(139 trips)',
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                      Text(
                                        formatNumber(
                                          widget.bookedCar!.rentalFare,
                                          formatType: FormatType.custom,
                                          format: 'EGP # / day',
                                          locale: '',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Open Sans',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ].divide(SizedBox(height: 8.0)),
                                  ),
                                ),
                              ].divide(SizedBox(width: 16.0)),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.all(12.0),
                            child: StreamBuilder<CarRecord>(
                              stream: CarRecord.getDocument(
                                  widget.tripDocument!.borrowedCar!),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                final rowCarRecord = snapshot.data!;

                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.network(
                                        valueOrDefault<String>(
                                          rowCarRecord.carPhotos.firstOrNull,
                                          'https://images.unsplash.com/photo-1510903117032-f1596c327647?w=800&h=800',
                                        ),
                                        width: 100.0,
                                        height: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            valueOrDefault<String>(
                                              '${rowCarRecord.make} ${rowCarRecord.model}',
                                              'BYD F3',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                Icons.star_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 20.0,
                                              ),
                                              Text(
                                                rowCarRecord.rate.toString(),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                              Text(
                                                '(139 trips)',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodySmall
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      letterSpacing: 0.0,
                                                    ),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                          Text(
                                            formatNumber(
                                              rowCarRecord.rentalFare,
                                              formatType: FormatType.custom,
                                              format: 'EGP #/ day',
                                              locale: '',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 8.0)),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 16.0)),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                if (widget.tripDocument?.status == Status.payDone)
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        context.pushNamed('preparingInterview');
                      },
                      text: 'Show Contract !',
                      options: FFButtonOptions(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Open Sans',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Trip Dates',
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'Open Sans',
                                  letterSpacing: 0.0,
                                ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Start Date',
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Text(
                                    valueOrDefault<String>(
                                      dateTimeFormat(
                                        "yMMMd",
                                        widget.tripDocument?.startDate,
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      ),
                                      'Oct 15, 2025',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Open Sans',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Text(
                                    valueOrDefault<String>(
                                      dateTimeFormat(
                                        "jm",
                                        widget.tripDocument?.startDate,
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      ),
                                      '10:00 AM',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 4.0)),
                              ),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'End Date',
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Text(
                                    valueOrDefault<String>(
                                      dateTimeFormat(
                                        "yMMMd",
                                        widget.tripDocument?.endDate,
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      ),
                                      'Oct 15, 2025',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Open Sans',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Text(
                                    valueOrDefault<String>(
                                      dateTimeFormat(
                                        "jm",
                                        widget.tripDocument?.endDate,
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      ),
                                      '10:00 AM',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 4.0)),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                    ),
                  ),
                ),
                if (widget.tripDocument?.status == Status.payDone)
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: StreamBuilder<UsersRecord>(
                          stream: UsersRecord.getDocument(
                              widget.tripDocument!.carOwner!),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }

                            final columnUsersRecord = snapshot.data!;

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Renting and Contact Info (payed only)',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.person_sharp,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 24.0,
                                    ),
                                    Expanded(
                                      child:
                                          StreamBuilder<List<LocationRecord>>(
                                        stream: queryLocationRecord(
                                          queryBuilder: (locationRecord) =>
                                              locationRecord.where(
                                            'user',
                                            isEqualTo:
                                                widget.tripDocument?.carOwner,
                                          ),
                                          singleRecord: true,
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<LocationRecord>
                                              textLocationRecordList =
                                              snapshot.data!;
                                          // Return an empty Container when the item does not exist.
                                          if (snapshot.data!.isEmpty) {
                                            return Container();
                                          }
                                          final textLocationRecord =
                                              textLocationRecordList.isNotEmpty
                                                  ? textLocationRecordList.first
                                                  : null;

                                          return Text(
                                            columnUsersRecord.displayName,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  letterSpacing: 0.0,
                                                ),
                                          );
                                        },
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.phone_sharp,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 24.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        columnUsersRecord.phoneNumber,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Open Sans',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                    Builder(
                                      builder: (context) => FFButtonWidget(
                                        onPressed: () async {
                                          await launchURL(
                                              'https://api.whatsapp.com/send?autoload=1&app_absent=0&phone=2${columnUsersRecord.phoneNumber}&text');
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(dialogContext)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: AlertDialogWidget(
                                                    title: 'Open whatsapp ',
                                                    description:
                                                        'The application will redirect you to whatsapp to contact Car Owner, Are you sure?',
                                                    confirmCallback: () async {
                                                      await launchURL(
                                                          'https://api.whatsapp.com/send?autoload=1&app_absent=0&phone=2${columnUsersRecord.phoneNumber}&text');
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        text: 'Contact Now',
                                        icon: Icon(
                                          Icons.wechat_sharp,
                                          size: 15.0,
                                        ),
                                        options: FFButtonOptions(
                                          height: 36.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 10.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: Color(0xFF25D366),
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: Colors.white,
                                                    letterSpacing: 0.0,
                                                  ),
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.location_on_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 24.0,
                                    ),
                                    Expanded(
                                      child:
                                          StreamBuilder<List<LocationRecord>>(
                                        stream: queryLocationRecord(
                                          queryBuilder: (locationRecord) =>
                                              locationRecord.where(
                                            'user',
                                            isEqualTo:
                                                widget.tripDocument?.carOwner,
                                          ),
                                          singleRecord: true,
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<LocationRecord>
                                              textLocationRecordList =
                                              snapshot.data!;
                                          // Return an empty Container when the item does not exist.
                                          if (snapshot.data!.isEmpty) {
                                            return Container();
                                          }
                                          final textLocationRecord =
                                              textLocationRecordList.isNotEmpty
                                                  ? textLocationRecordList.first
                                                  : null;

                                          return Text(
                                            valueOrDefault<String>(
                                              '${textLocationRecord?.government}, ${textLocationRecord?.city}, ${textLocationRecord?.street}',
                                              'Giza, 6October city, D center Zahraa October',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  letterSpacing: 0.0,
                                                ),
                                          );
                                        },
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Payment Summary',
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'Open Sans',
                                  letterSpacing: 0.0,
                                ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${widget.bookedCar?.rentalFare.toString()}  × ${functions.calculateDaysCount(widget.tripDocument!.startDate!.secondsSinceEpoch, widget.tripDocument!.endDate!.secondsSinceEpoch).toString()} days',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  widget.tripDocument?.totalPrice.toString(),
                                  '5,040',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'servise price: 25% (first 6 months)',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  ((FFAppConstants.serviceProvantage / 100) *
                                          widget.tripDocument!.totalPrice)
                                      .toString(),
                                  '1,260',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'insurance deposit\n (back after renting ends):',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              Flexible(
                                child: Text(
                                  FFAppConstants.insuranceDeposit.toString(),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.0,
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Amount',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              Text(
                                _model.fullPrice.toString(),
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                    ),
                  ),
                ),
                if (widget.tripDocument?.status == Status.notConfirmed)
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await widget.tripDocument!.reference
                            .update(createTripRecordData(
                          status: Status.pending,
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Request Send Successfully',
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).success,
                          ),
                        );

                        context.pushNamed('MyCars');
                      },
                      text: 'Confirm Booking',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 56.0,
                        padding: EdgeInsets.all(8.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Open Sans',
                                  color: FlutterFlowTheme.of(context).info,
                                  letterSpacing: 0.0,
                                ),
                        elevation: 2.0,
                      ),
                    ),
                  ),
                if (widget.tripDocument?.status == Status.accepted)
                  Builder(
                    builder: (context) => Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return Dialog(
                                elevation: 0,
                                insetPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                alignment: AlignmentDirectional(0.0, 0.0)
                                    .resolve(Directionality.of(context)),
                                child: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(dialogContext).unfocus();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  child: CheckoutDialogWidget(
                                    totalRent: _model.fullPrice,
                                    tripRef: widget.tripDocument!.reference,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        text: 'Pay Now!',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 41.79,
                          padding: EdgeInsets.all(8.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Open Sans',
                                    color: FlutterFlowTheme.of(context).info,
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 2.0,
                        ),
                      ),
                    ),
                  ),
              ].divide(SizedBox(height: 24.0)),
            ),
          ),
        ),
      ),
    );
  }
}
