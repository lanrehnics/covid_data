class StateResponse {
  List<NigeriaState> states;

  StateResponse({this.states});

  StateResponse.fromJson(List json) {
    states = new List<NigeriaState>();
    json.forEach((v) {
      states.add(new NigeriaState.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.states != null) {
      data['states'] = this.states.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NigeriaState {
  String name;
  int id;

  NigeriaState({this.name, this.id});

  NigeriaState.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
