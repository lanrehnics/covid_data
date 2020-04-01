import 'package:coviddata/blocs/covid_bloc.dart';
import 'package:coviddata/config.dart';
import 'package:coviddata/events/covid_event.dart';
import 'package:coviddata/mix/ui_tools_mixin.dart';
import 'package:coviddata/models/patient.dart';
import 'package:coviddata/models/state_response.dart';
import 'package:coviddata/states/covid_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:progress_indicator_button/progress_button.dart';

class AddPatientPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddPatientPage();
  }
}

class _AddPatientPage extends State<AddPatientPage> with UIToolMixin {
  var _form = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> genderDropDown;
  List<DropdownMenuItem<String>> stateDropDown;
  ValueNotifier<String> genderNotifier = ValueNotifier(Config.genderList[0]);
  ValueNotifier<String> stateNotifier = ValueNotifier(Config.SelectState);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController _animationController;

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController streetNameController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();

  CovidBloc _covidBloc;

  @override
  void initState() {
    _covidBloc = new CovidBloc();
    _covidBloc.add(CovidEvent.fetchState());
    loadGender();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(title: Text("Add Patient")),
        body: BlocListener(
          bloc: _covidBloc,
          listener: (context, state) {
            if (state is Error) {
              showMessage(_scaffoldKey, state.message);
              _animationController?.reverse();
            }

            if (state is PatientCreated) {
              showMessage(_scaffoldKey, "Patient Added", color: Colors.green);
              _animationController
                  .reverse()
                  .whenComplete(() => Navigator.of(context).pop(true));
            }
          },
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6)))),
                    child: Form(
                        key: _form,
                        child: Column(
                          children: <Widget>[
                            buildInput(firstNameController,
                                hint: Config.FirstName),
                            height(),
                            buildInput(lastNameController,
                                hint: Config.LastName),
                            height(),
                            buildInput(cityController, hint: Config.City),
                            height(),
                            buildInput(streetNameController,
                                hint: Config.Street),
                            height(),
                            buildGender(),
                            height(),
                            BlocBuilder<CovidBloc, CovidState>(
                              bloc: _covidBloc,
                              builder: (context, state) {
                                Widget loadingWidget = SizedBox(
                                  height: 0,
                                );
                                if (state is Loading) {
                                  loadingWidget = SizedBox(
                                      height: 0.5,
                                      child: LinearProgressIndicator());
                                }

                                if (state is StatesLoaded) {
                                  loadState(state.stateResponse.states);
                                }

                                return Column(
                                  children: <Widget>[
                                    buildStates(),
                                    loadingWidget
                                  ],
                                );
                              },
                            ),
                            height(),
                            height(),
                            ProgressButton(
                              color: Theme.of(context).accentColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              onPressed: (AnimationController controller) {
                                if (!_form.currentState.validate()) {
                                  return;
                                }
                                _form.currentState.save();
                                _animationController = controller;
                                controller.forward();
                                addPatientRecord();
                              },
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ]),
          )),
        ));
  }

  void addPatientRecord() {
    Patient patient = new Patient();
    patient
      ..firstName = firstNameController.text
      ..lastName = lastNameController.text
      ..city = cityController.text
      ..street = streetNameController.text
      ..state = stateNotifier.value
      ..gender = genderNotifier.value.toUpperCase();

    _covidBloc.add(RecordPatient(data: patient));
  }

  Widget buildInput(TextEditingController controller, {String hint}) {
    return new Container(
      child: NeuCard(
        curveType: CurveType.concave,
        bevel: 12,
        decoration:
            NeumorphicDecoration(borderRadius: BorderRadius.circular(8)),
        child: new TextFormField(
            controller: controller,
            decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            }),
        padding: EdgeInsets.all(5),
      ),
    );
  }

  Widget buildGender() {
    return new Container(
      child: NeuCard(
        curveType: CurveType.concave,
        bevel: 12,
        decoration:
            NeumorphicDecoration(borderRadius: BorderRadius.circular(8)),
        child: ValueListenableBuilder(
          valueListenable: genderNotifier,
          builder: (context, String value, child) {
            return DropdownButtonHideUnderline(
                child: DropdownButton(
              items: genderDropDown,
              onChanged: (String s) {
                genderNotifier.value = s;
              },
              isExpanded: true,
              value: value,
              isDense: true,
            ));
          },
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      ),
    );
  }

  Widget buildStates() {
    return new Container(
      child: NeuCard(
        curveType: CurveType.concave,
        bevel: 12,
        decoration:
            NeumorphicDecoration(borderRadius: BorderRadius.circular(8)),
        child: ValueListenableBuilder(
          valueListenable: stateNotifier,
          builder: (context, String value, child) {
            return stateDropDown != null
                ? DropdownButtonHideUnderline(
                    child: DropdownButton(
                    items: stateDropDown,
                    onChanged: (String s) {
                      stateNotifier.value = s;
                    },
                    isExpanded: true,
                    value: value,
                    isDense: true,
                  ))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Loading States...",
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      )
                    ],
                  );
          },
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      ),
    );
  }

  Widget height() {
    return new SizedBox(
      height: 15,
    );
  }

  loadGender() {
    genderDropDown = Config.genderList
        .sublist(1)
        .map((String reason) => DropdownMenuItem<String>(
              value: reason,
              child: Row(
                children: <Widget>[Text(reason)],
              ),
            ))
        .toList();

    genderDropDown.insert(
        0,
        DropdownMenuItem<String>(
          value: Config.genderList[0],
          child: Row(
            children: <Widget>[
              Text(Config.genderList[0], style: TextStyle(color: Colors.grey))
            ],
          ),
        ));
  }

  loadState(List<NigeriaState> states) {
    stateDropDown = states
        .map((s) => DropdownMenuItem<String>(
              value: s.name,
              child: Row(
                children: <Widget>[Text(s.name)],
              ),
            ))
        .toList();

    stateDropDown.insert(
        0,
        DropdownMenuItem<String>(
          value: Config.SelectState,
          child: Row(
            children: <Widget>[
              Text(Config.SelectState, style: TextStyle(color: Colors.grey))
            ],
          ),
        ));
  }
}
