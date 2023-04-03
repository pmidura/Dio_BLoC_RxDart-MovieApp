import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../blocs/persons_bloc.dart';
import '../models/person.dart';
import '../models/person_response.dart';
import '../styles/theme.dart' as style;

class Persons extends StatefulWidget {
  const Persons({super.key});

  @override
  State<Persons> createState() => _PersonsState();
}

class _PersonsState extends State<Persons> {
  @override
  void initState() {
    super.initState();
    personsBloc.getPersons();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Padding(
        padding: EdgeInsets.only(left: 10.0, top: 20.0),
        child: Text(
          "TRENDING PERSONS ON THIS WEEK",
          style: TextStyle(
            color: style.Colors.titleColor,
            fontWeight: FontWeight.w500,
            fontSize: 12.0,
          ),
        ),
      ),
      const SizedBox(height: 5.0),
      StreamBuilder<PersonResponse>(
        stream: personsBloc.subject.stream,
        builder: (context, AsyncSnapshot<PersonResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.error.isNotEmpty) {
              return _buildErrorWidget(snapshot.data!.error);
            }
            return _buildPersonsWidget(snapshot.data!);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error.toString());
          } else {
            return _buildLoadingWidget();
          }
        },
      ),
    ],
  );

   Widget _buildLoadingWidget() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(),
        ),
      ],
    ),
  );

  Widget _buildErrorWidget(String error) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ),
  );

  Widget _buildPersonsWidget(PersonResponse data) {
    List<Person> persons = data.persons;

    return Container(
      height: 130.0,
      padding: const EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        itemCount: persons.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          width: 100.0,
          padding: const EdgeInsets.only(top: 10.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              persons[index].profileImg.isEmpty ?
              Container(
                width: 70.0,
                height: 70.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: style.Colors.secondColor,
                ),
                child: const Icon(
                  FontAwesomeIcons.userLarge,
                  color: Colors.white,
                ),
              ) :
              Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("https://image.tmdb.org/t/p/w200/${persons[index].profileImg}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                persons[index].name,
                maxLines: 2,
                style: const TextStyle(
                  height: 1.4,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 9.0,
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                "Trending for ${persons[index].known}",
                style: const TextStyle(
                  color: style.Colors.titleColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 7.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
