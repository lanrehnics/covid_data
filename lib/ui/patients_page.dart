import 'package:coviddata/blocs/covid_bloc.dart';
import 'package:coviddata/config.dart';
import 'package:coviddata/events/covid_event.dart';
import 'package:coviddata/mix/ui_tools_mixin.dart';
import 'package:coviddata/models/patient.dart';
import 'package:coviddata/states/covid_state.dart';
import 'package:coviddata/ui/add_patient_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neumorphic/neumorphic.dart';

class PatientsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PatientsPage();
  }
}

class _PatientsPage extends State<PatientsPage> with UIToolMixin {
  CovidBloc _covidBloc;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Patient> patients = [];

  @override
  void initState() {
    _covidBloc = new CovidBloc();
    _covidBloc.add(CovidEvent.fetchPatients());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: Text("Patients"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddPatientPage()))
            .then((value) =>
                value ? _covidBloc.add(CovidEvent.fetchPatients()) : null),
        child: Icon(Icons.add),
      ),
      body: BlocListener(
        bloc: _covidBloc,
        listener: (context, state) {
          if (state is Error) {
            showMessage(_scaffoldKey, state.message);
          }
        },
        child: BlocBuilder<CovidBloc, CovidState>(
            bloc: _covidBloc,
            builder: (context, state) {
              if (state is Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is PatientsLoaded) {
                patients = state.patientResponse.patients;
              }

              return patients.isEmpty
                  ? Center(child: Text("List is empty"))
                  : ListView(
                      children: <Widget>[
                        ...patients.map((p) => buildEachPatientData(p)).toList()
                      ],
                    );
            }),
      ),
    );
  }

  Widget buildEachPatientData(Patient p) {
    return new Container(
      child: NeuCard(
        curveType: CurveType.concave,
        // Elevation relative to parent. Main constituent of Neumorphism
        bevel: 12,
        decoration:
            NeumorphicDecoration(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          child: Column(
            children: <Widget>[
              buildEntry(Config.FirstName, p?.firstName ?? "N/A"),
              buildEntry(Config.LastName, p?.lastName ?? "N/A"),
              buildEntry(Config.Street, p?.street ?? "N/A"),
              buildEntry(Config.City, p?.city ?? "N/A"),
              buildEntry(Config.State, p?.state ?? "N/A"),
              buildEntry(Config.Gender, p?.gender ?? "N/A"),
              buildEntry(Config.Latitude, p?.lat ?? "N/A"),
              buildEntry(Config.Longitude, p?.lng ?? "N/A")
            ],
          ),
          padding: EdgeInsets.all(15),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }

  Widget buildEntry(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        Text(value,
            style: TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis)
      ],
    );
  }
}
