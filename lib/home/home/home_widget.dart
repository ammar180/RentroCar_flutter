import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/home/car_card/car_card_widget.dart';
import '/home/car_card_big/car_card_big_widget.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with RouteAware {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    _model.searchBarFieldTextController ??= TextEditingController()
      ..addListener(() {
        debugLogWidgetClass(_model);
      });
    _model.searchBarFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = DebugModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }
    debugLogGlobalProperty(context);
  }

  @override
  void didPopNext() {
    if (mounted && DebugFlutterFlowModelContext.maybeOf(context) == null) {
      setState(() => _model.isRouteVisible = true);
      debugLogWidgetClass(_model);
    }
  }

  @override
  void didPush() {
    if (mounted && DebugFlutterFlowModelContext.maybeOf(context) == null) {
      setState(() => _model.isRouteVisible = true);
      debugLogWidgetClass(_model);
    }
  }

  @override
  void didPop() {
    _model.isRouteVisible = false;
  }

  @override
  void didPushNext() {
    _model.isRouteVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    DebugFlutterFlowModelContext.maybeOf(context)
        ?.parentModelCallback
        ?.call(_model);
    _model.carCard2Models.clear();
    _model.carCardBigModels.clear();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/rentrocar-log.png',
                      width: 40.0,
                      height: 40.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'es5hjj8s' /* RentroCar */,
                    ),
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'Roboto Mono',
                          letterSpacing: 0.0,
                        ),
                  ),
                ].divide(SizedBox(width: 10.0)),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                child: TextFormField(
                  controller: _model.searchBarFieldTextController,
                  focusNode: _model.searchBarFieldFocusNode,
                  onFieldSubmitted: (_) async {
                    _model.carsCollection = await queryCarRecordOnce(
                      queryBuilder: (carRecord) => carRecord
                          .where(
                            'make',
                            isEqualTo: _model.searchBarFieldTextController.text,
                          )
                          .where(
                            'isVisible',
                            isEqualTo: true,
                          ),
                    );
                    _model.searchedCars =
                        _model.carsCollection!.toList().cast<CarRecord>();
                    safeSetState(() {});

                    safeSetState(() {});
                  },
                  autofocus: false,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.search,
                  obscureText: false,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: FFLocalizations.of(context).getText(
                      '10oubq9w' /* Search any Car.... */,
                    ),
                    hintStyle: FlutterFlowTheme.of(context).labelSmall.override(
                          fontFamily: 'Open Sans',
                          letterSpacing: 0.0,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x8914181B),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primaryText,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    contentPadding: EdgeInsets.all(14.0),
                    prefixIcon: Icon(
                      Icons.search_sharp,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 20.0,
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Open Sans',
                        letterSpacing: 0.0,
                        lineHeight: 2.0,
                      ),
                  maxLength: 25,
                  buildCounter: (context,
                          {required currentLength,
                          required isFocused,
                          maxLength}) =>
                      null,
                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                  validator: _model.searchBarFieldTextControllerValidator
                      .asValidator(context),
                ),
              ),
              StreamBuilder<List<CarRecord>>(
                stream: queryCarRecord(
                  queryBuilder: (carRecord) => carRecord.orderBy('rate'),
                  limit: 10,
                ),
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
                  List<CarRecord> containerCarRecordList = snapshot.data!;

                  _model.debugBackendQueries[
                          'containerCarRecordList_Container_vmnwgw2o${containerCarRecordList.length > 100 ? ' (first 100)' : ''}'] =
                      debugSerializeParam(
                    containerCarRecordList.take(100),
                    ParamType.Document,
                    isList: true,
                    link:
                        'https://app.flutterflow.io/project/rentro-car-74c8w5?tab=uiBuilder&page=home',
                    name: 'car',
                    nullable: false,
                  );
                  debugLogWidgetClass(_model);

                  return Container(
                    height: MediaQuery.sizeOf(context).height * 0.655,
                    decoration: BoxDecoration(),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  '51if56xb' /* Most Popular Cars */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      fontFamily: 'Open Sans',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              Container(
                                height: 250,
                                decoration: BoxDecoration(),
                                child: StreamBuilder<List<CarRecord>>(
                                  stream: queryCarRecord(
                                    queryBuilder: (carRecord) =>
                                        carRecord.where(
                                      'isVisible',
                                      isEqualTo: true,
                                    ),
                                    limit: 10,
                                  ),
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
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<CarRecord> listViewCarRecordList =
                                        snapshot.data!;

                                    _model.debugBackendQueries[
                                            'listViewCarRecordList_Row_4tw0z3vj${listViewCarRecordList.length > 100 ? ' (first 100)' : ''}'] =
                                        debugSerializeParam(
                                      listViewCarRecordList.take(100),
                                      ParamType.Document,
                                      isList: true,
                                      link:
                                          'https://app.flutterflow.io/project/rentro-car-74c8w5?tab=uiBuilder&page=home',
                                      name: 'car',
                                      nullable: false,
                                    );
                                    debugLogWidgetClass(_model);

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: listViewCarRecordList.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(width: 10.0),
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewCarRecord =
                                            listViewCarRecordList[
                                                listViewIndex];
                                        return Builder(builder: (_) {
                                          return DebugFlutterFlowModelContext(
                                            rootModel: _model.rootModel,
                                            parentModelCallback: (m) {
                                              _model.carCard2Models[
                                                  'Keymm9_${listViewIndex}_of_${listViewCarRecordList.length}'] = m;
                                            },
                                            child: CarCardWidget(
                                              key: Key(
                                                  'Keymm9_${listViewIndex}_of_${listViewCarRecordList.length}'),
                                              car: listViewCarRecord,
                                            ),
                                          );
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ].divide(SizedBox(height: 12.0)),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'uddkj6ai' /* Top Rated Cars */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'Open Sans',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                              Builder(
                                builder: (context) {
                                  final carDocument =
                                      _model.searchedCars.isNotEmpty
                                          ? _model.searchedCars
                                          : containerCarRecordList
                                              .where((e) => e.isVisible)
                                              .toList();
                                  _model.debugGeneratorVariables[
                                          'carDocument${carDocument.length > 100 ? ' (first 100)' : ''}'] =
                                      debugSerializeParam(
                                    carDocument.take(100),
                                    ParamType.Document,
                                    isList: true,
                                    link:
                                        'https://app.flutterflow.io/project/rentro-car-74c8w5?tab=uiBuilder&page=home',
                                    name: 'car',
                                    nullable: false,
                                  );
                                  debugLogWidgetClass(_model);

                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(carDocument.length,
                                        (carDocumentIndex) {
                                      final carDocumentItem =
                                          carDocument[carDocumentIndex];
                                      return Builder(builder: (_) {
                                        return DebugFlutterFlowModelContext(
                                          rootModel: _model.rootModel,
                                          parentModelCallback: (m) {
                                            _model.carCardBigModels[
                                                'Key2pd_${carDocumentIndex}_of_${carDocument.length}'] = m;
                                          },
                                          child: CarCardBigWidget(
                                            key: Key(
                                                'Key2pd_${carDocumentIndex}_of_${carDocument.length}'),
                                            carParam: carDocumentItem,
                                          ),
                                        );
                                      });
                                    }).divide(SizedBox(height: 10.0)),
                                  );
                                },
                              ),
                            ].divide(SizedBox(height: 10.0)),
                          ),
                        ].divide(SizedBox(height: 10.0)),
                      ),
                    ),
                  );
                },
              ),
            ].divide(SizedBox(height: 30.0)),
          ),
        ),
      ),
    );
  }
}
