import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/persons/persons_cubit.dart';
import '../../repos/movie_repo.dart';
import '../../styles/theme.dart' as style;
import 'persons_view.dart';

class Persons extends StatelessWidget {
  const Persons({super.key, required this.movieRepo});

  final MovieRepo movieRepo;

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
      RepositoryProvider.value(
        value: movieRepo,
        child: BlocProvider(
          create: (_) => PersonsCubit(repo: movieRepo)..getPersons(),
          child: PersonsView(movieRepo: movieRepo),
        ),
      ),
    ],
  );
}
