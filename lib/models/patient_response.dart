import 'package:coviddata/models/patient.dart';

class PatientResponse {
  List<Patient> patients;
  Pageable pageable;
  int totalPages;
  int totalElements;
  bool last;
  Sort sort;
  int number;
  int numberOfElements;
  bool first;
  int size;
  bool empty;

  PatientResponse(
      {this.patients,
      this.pageable,
      this.totalPages,
      this.totalElements,
      this.last,
      this.sort,
      this.number,
      this.numberOfElements,
      this.first,
      this.size,
      this.empty});

  PatientResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      patients = new List<Patient>();
      json['content'].forEach((v) {
        patients.add(new Patient.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    last = json['last'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    number = json['number'];
    numberOfElements = json['numberOfElements'];
    first = json['first'];
    size = json['size'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patients != null) {
      data['content'] = this.patients.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable.toJson();
    }
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['last'] = this.last;
    if (this.sort != null) {
      data['sort'] = this.sort.toJson();
    }
    data['number'] = this.number;
    data['numberOfElements'] = this.numberOfElements;
    data['first'] = this.first;
    data['size'] = this.size;
    data['empty'] = this.empty;
    return data;
  }
}

class Pageable {
  Sort sort;
  int pageNumber;
  int pageSize;
  int offset;
  bool paged;
  bool unpaged;

  Pageable(
      {this.sort,
      this.pageNumber,
      this.pageSize,
      this.offset,
      this.paged,
      this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    offset = json['offset'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sort != null) {
      data['sort'] = this.sort.toJson();
    }
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['offset'] = this.offset;
    data['paged'] = this.paged;
    data['unpaged'] = this.unpaged;
    return data;
  }
}

class Sort {
  bool sorted;
  bool unsorted;
  bool empty;

  Sort({this.sorted, this.unsorted, this.empty});

  Sort.fromJson(Map<String, dynamic> json) {
    sorted = json['sorted'];
    unsorted = json['unsorted'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sorted'] = this.sorted;
    data['unsorted'] = this.unsorted;
    data['empty'] = this.empty;
    return data;
  }
}
