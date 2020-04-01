// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class CovidEvent extends Equatable {
  const CovidEvent(this._type);

  factory CovidEvent.fetchPatients() = FetchPatients;

  factory CovidEvent.fetchState() = FetchState;

  factory CovidEvent.recordPatient({@required Patient data}) = RecordPatient;

  final _CovidEvent _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(FetchPatients) fetchPatients,
      @required R Function(FetchState) fetchState,
      @required R Function(RecordPatient) recordPatient}) {
    switch (this._type) {
      case _CovidEvent.FetchPatients:
        return fetchPatients(this as FetchPatients);
      case _CovidEvent.FetchState:
        return fetchState(this as FetchState);
      case _CovidEvent.RecordPatient:
        return recordPatient(this as RecordPatient);
    }
  }

  @override
  List get props => null;
}

@immutable
class FetchPatients extends CovidEvent {
  const FetchPatients._() : super(_CovidEvent.FetchPatients);

  factory FetchPatients() {
    _instance ??= FetchPatients._();
    return _instance;
  }

  static FetchPatients _instance;
}

@immutable
class FetchState extends CovidEvent {
  const FetchState._() : super(_CovidEvent.FetchState);

  factory FetchState() {
    _instance ??= FetchState._();
    return _instance;
  }

  static FetchState _instance;
}

@immutable
class RecordPatient extends CovidEvent {
  const RecordPatient({@required this.data}) : super(_CovidEvent.RecordPatient);

  final Patient data;

  @override
  String toString() => 'RecordPatient(data:${this.data})';
  @override
  List get props => [data];
}
