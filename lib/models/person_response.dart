import 'person.dart';

class PersonResponse {
  final List<Person> persons;
  final String error;

  PersonResponse({
    required this.persons,
    required this.error,
  });
  
  PersonResponse.fromJson(Map<String, dynamic> json) :
    persons = (json["results"] as List).map((e) => Person.fromJson(e)).toList(),
    error = "";

  PersonResponse.withError(String errorVal) :
    persons = [],
    error = errorVal;
}
