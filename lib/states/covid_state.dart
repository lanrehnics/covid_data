import 'package:coviddata/models/patient.dart';
import 'package:coviddata/models/patient_response.dart';
import 'package:coviddata/models/state_response.dart';
import 'package:super_enum/super_enum.dart';

part 'covid_state.g.dart';

@superEnum
enum _CovidState {
  @object
  Initial,

  @object
  Loading,

  @Data(fields: [DataField('patientResponse', PatientResponse)])
  PatientsLoaded,

  @Data(fields: [DataField('stateResponse', StateResponse)])
  StatesLoaded,

  @Data(fields: [DataField('patient', Patient)])
  PatientCreated,

  @Data(fields: [DataField('message', String)])
  Error,
}
