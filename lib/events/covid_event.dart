import 'package:coviddata/models/patient.dart';
import 'package:super_enum/super_enum.dart';

part 'covid_event.g.dart';

@superEnum
enum _CovidEvent {
  @object
  FetchPatients,

  @object
  FetchState,

  @Data(fields: [DataField('data', Patient)])
  RecordPatient
}
