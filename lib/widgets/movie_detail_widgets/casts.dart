import 'package:dio_bloc_rxdart_movie_app/blocs/casts/casts_cubit.dart';
import 'package:dio_bloc_rxdart_movie_app/repos/movie_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class Casts extends StatelessWidget {
  final int movieId;
  final MovieRepo movieRepo;

  const Casts({
    super.key,
    required this.movieId,
    required this.movieRepo,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => CastsCubit(
      repo: context.read<MovieRepo>(),
    )..fetchCasts(movieId),
    child: CastsView(
      movieId: movieId,
      movieRepo: movieRepo,
    ),
  );
}

class CastsView extends StatelessWidget {
  final int movieId;
  final MovieRepo movieRepo;

  const CastsView({
    super.key,
    required this.movieId,
    required this.movieRepo,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CastsCubit>().state;

    switch (state.status) {
      case ListStatus.loading:
        return _buildLoadingWidget();
      case ListStatus.failure:
        return _buildErrorWidget(state.status.toString());
      case ListStatus.success:
        return SizedBox(
          height: 200.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.casts.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 10.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Stack(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.black87,
                          highlightColor: Colors.white54,
                          enabled: true,
                          child: const SizedBox(
                            height: 120.0,
                            child: AspectRatio(
                              aspectRatio: 2 / 3,
                              child: Icon(
                                FontAwesomeIcons.userLarge,
                                color: Colors.black26,
                                size: 40.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 120.0,
                          child: Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: 2 / 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: FadeInImage.memoryNetwork(
                                    fit: BoxFit.cover,
                                    placeholderErrorBuilder: (context, error, stackTrace) => const Icon(
                                      Icons.person,
                                      color: Colors.black26,
                                    ),
                                    imageErrorBuilder: (context, error, stackTrace) => const Icon(
                                      Icons.person,
                                      color: Colors.black26,
                                    ),
                                    placeholder: kTransparentImage,
                                    image: "https://image.tmdb.org/t/p/w300/${state.casts[index].img}",
                                  ),
                                ),
                              ),
                              AspectRatio(
                                aspectRatio: 2 / 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.2),
                                        Colors.black.withOpacity(0.5),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [0, 1],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ), 
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Positioned(
                    child: SizedBox(
                      width: 80.0,
                      child: Text(
                        state.casts[index].name,
                        style: const TextStyle(
                          fontSize: 11.0,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      default:
        return _buildLoadingWidget();
    }
  }
  
  Widget _buildLoadingWidget() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
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
}
