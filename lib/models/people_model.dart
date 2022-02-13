class PeopleModel {
  final int id;
  final String name;
  final String gender;
  final String address;

  PeopleModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.address,
  });

  factory PeopleModel.fromJson(Map<String, dynamic> json) {
    return PeopleModel(
      id: json['id'] as int,
      name: json['name'] as String,
      gender: json['gender'] as String,
      address: json['address'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'address': address,
    };
  }
}
