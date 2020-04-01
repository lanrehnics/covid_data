import 'package:coviddata/config.dart';
import 'package:coviddata/models/patient.dart';
import 'package:coviddata/models/patient_response.dart';
import 'package:coviddata/models/state_response.dart';
import 'package:coviddata/utillities/NetworkUtilz.dart';
import 'package:geolocator/geolocator.dart';

class Repository {
  NetworkUtilz networkUtilz;

  Repository({this.networkUtilz}) : assert(networkUtilz != null);

  Future<PatientResponse> fetchPatients() async {
    PatientResponse patientResponse;
    try {
      var res = await networkUtilz.dioGet(Config.PATIENTS);
      if (res?.statusCode == 200) {
        patientResponse = PatientResponse.fromJson(res.data);
      } else {
        throw res.data["error"];
      }
    } catch (error) {
      throw error;
    }
    return patientResponse;
  }

  Future<StateResponse> fetchStates() async {
    StateResponse stateResponse;
    try {
      var res = await networkUtilz.dioGet(Config.STATE);
      if (res?.statusCode == 200) {
        stateResponse = StateResponse.fromJson(res.data);
      } else {
        throw res.data["error"];
      }
    } catch (error) {
      throw error;
    }
    return stateResponse;
  }

  Future<Patient> recordPatient(Patient patient) async {
    try {
      Position position = await getCurrentLocByGeoLocator();
      patient
        ..lat = position.latitude.toString()
        ..lng = position.longitude.toString();

      var res = await networkUtilz.dioPost(Config.PATIENTS, patient.toJson());
      if (res?.statusCode == 201) {
        patient = Patient.fromJson(res.data);
      } else {
        throw res.data["error"];
      }
    } catch (error) {
      throw error;
    }
    return patient;
  }

  Future<Position> getCurrentLocByGeoLocator() async {
    Position position = Position(longitude: 3.3679965, latitude: 6.5212402);
    try {
      position = await Geolocator().getCurrentPosition();
    } catch (e) {}
    return position;
  }
}
