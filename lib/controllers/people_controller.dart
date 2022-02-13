import '../models/people_model.dart';
import '../repositories/repository.dart';

class PeopleController {
  late Repository _repository;
  PeopleController() {
    _repository = Repository();
  }

  Future<void> insertPeople(PeopleModel peopleModel) {
    return _repository.insertPeople('tbPeople', peopleModel);
  }

  Future<List<PeopleModel>> selectPeople() async {
    var response = await _repository.selectPeople('tbPeople') as List;
    List<PeopleModel> peopleList = [];
    response.map((value) {
      return peopleList.add(PeopleModel.fromJson(value));
    }).toList();
    return peopleList;
  }

  Future<void> deletePeople(int peopleId) {
    return _repository.deletePeople('tbPeople', peopleId);
  }

  Future<void> updatePeople(PeopleModel peopleModel) {
    return _repository.updatePeople(
      'tbPeople',
      peopleModel.toJson(),
      peopleModel.id,
    );
  }
}
