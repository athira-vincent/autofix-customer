class StatesMdl {
  List<StateDetails>? stateData;

  StatesMdl({this.stateData});

  factory StatesMdl.fromJson(Map<String, dynamic> json) {
    var list = json['states'] as List;
    List<StateDetails> _countryList =
        list.map((i) => StateDetails.fromJson(i)).toList();
    return StatesMdl(stateData: _countryList);
  }
}

class StateDetails {
  String? name;
  String? id;
  StateDetails({this.name, this.id});
  factory StateDetails.fromJson(Map<String, dynamic> json) {
    return StateDetails(
      name: json['name'],
      id: json['id'],
    );
  }
}
