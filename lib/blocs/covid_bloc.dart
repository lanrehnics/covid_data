import 'package:coviddata/events/covid_event.dart';
import 'package:coviddata/models/patient.dart';
import 'package:coviddata/models/patient_response.dart';
import 'package:coviddata/models/state_response.dart';
import 'package:coviddata/repo/repository.dart';
import 'package:coviddata/states/covid_state.dart';
import 'package:coviddata/utillities/NetworkUtilz.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  Repository repository = new Repository(networkUtilz: NetworkUtilz());

  @override
  CovidState get initialState => CovidState.initial();

  @override
  Stream<CovidState> mapEventToState(CovidEvent event) async* {
    yield CovidState.loading();
    yield* event.when(
        fetchState: (_) => mapToFetchStates(),
        fetchPatients: (_) => mapToFetchPatients(),
        recordPatient: (e) => mapToRecordPatient(e.data));
  }

  Stream<CovidState> mapToFetchStates() async* {
    try {
      final StateResponse stateResponse = await repository.fetchStates();
      yield CovidState.statesLoaded(stateResponse: stateResponse);
    } catch (e) {
      yield CovidState.error(message: e.toString());
    }
  }

  Stream<CovidState> mapToFetchPatients() async* {
    try {
      final PatientResponse patientResponse = await repository.fetchPatients();
      yield CovidState.patientsLoaded(patientResponse: patientResponse);
    } catch (e) {
      yield CovidState.error(message: e.toString());
    }
  }

  Stream<CovidState> mapToRecordPatient(Patient data) async* {
    try {
      final Patient patient = await repository.recordPatient(data);
      yield CovidState.patientCreated(patient: patient);
    } catch (e) {
      yield CovidState.error(message: e.toString());
    }
  }
}
