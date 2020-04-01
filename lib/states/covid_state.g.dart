// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_state.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class CovidState extends Equatable {
  const CovidState(this._type);

  factory CovidState.initial() = Initial;

  factory CovidState.loading() = Loading;

  factory CovidState.patientsLoaded(
      {@required PatientResponse patientResponse}) = PatientsLoaded;

  factory CovidState.statesLoaded({@required StateResponse stateResponse}) =
      StatesLoaded;

  factory CovidState.patientCreated({@required Patient patient}) =
      PatientCreated;

  factory CovidState.error({@required String message}) = Error;

  final _CovidState _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Initial) initial,
      @required R Function(Loading) loading,
      @required R Function(PatientsLoaded) patientsLoaded,
      @required R Function(StatesLoaded) statesLoaded,
      @required R Function(PatientCreated) patientCreated,
      @required R Function(Error) error}) {
    switch (this._type) {
      case _CovidState.Initial:
        return initial(this as Initial);
      case _CovidState.Loading:
        return loading(this as Loading);
      case _CovidState.PatientsLoaded:
        return patientsLoaded(this as PatientsLoaded);
      case _CovidState.StatesLoaded:
        return statesLoaded(this as StatesLoaded);
      case _CovidState.PatientCreated:
        return patientCreated(this as PatientCreated);
      case _CovidState.Error:
        return error(this as Error);
    }
  }

  @override
  List get props => null;
}

@immutable
class Initial extends CovidState {
  const Initial._() : super(_CovidState.Initial);

  factory Initial() {
    _instance ??= Initial._();
    return _instance;
  }

  static Initial _instance;
}

@immutable
class Loading extends CovidState {
  const Loading._() : super(_CovidState.Loading);

  factory Loading() {
    _instance ??= Loading._();
    return _instance;
  }

  static Loading _instance;
}

@immutable
class PatientsLoaded extends CovidState {
  const PatientsLoaded({@required this.patientResponse})
      : super(_CovidState.PatientsLoaded);

  final PatientResponse patientResponse;

  @override
  String toString() =>
      'PatientsLoaded(patientResponse:${this.patientResponse})';
  @override
  List get props => [patientResponse];
}

@immutable
class StatesLoaded extends CovidState {
  const StatesLoaded({@required this.stateResponse})
      : super(_CovidState.StatesLoaded);

  final StateResponse stateResponse;

  @override
  String toString() => 'StatesLoaded(stateResponse:${this.stateResponse})';
  @override
  List get props => [stateResponse];
}

@immutable
class PatientCreated extends CovidState {
  const PatientCreated({@required this.patient})
      : super(_CovidState.PatientCreated);

  final Patient patient;

  @override
  String toString() => 'PatientCreated(patient:${this.patient})';
  @override
  List get props => [patient];
}

@immutable
class Error extends CovidState {
  const Error({@required this.message}) : super(_CovidState.Error);

  final String message;

  @override
  String toString() => 'Error(message:${this.message})';
  @override
  List get props => [message];
}
