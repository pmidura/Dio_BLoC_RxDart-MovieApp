import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../blocs/persons/persons_cubit.dart';
import '../../../models/person/person.dart';
import '../../../repos/movie_repo.dart';
import '../../../styles/theme.dart' as style;
import '../../additional_widgets/error.dart';
import '../../additional_widgets/loading.dart';

class PersonsView extends StatelessWidget {
  const PersonsView({super.key, required this.movieRepo});

  final MovieRepo movieRepo;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PersonsCubit>().state;
    final List<Person> persons = state.persons;

    switch (state.status) {
      case ListStatus.loading:
        return loadingWidget();
      case ListStatus.failure:
        return errorWidget(state.status.toString());
      case ListStatus.success:
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
                children: [
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
      default:
        return loadingWidget();
    }
  }
}
