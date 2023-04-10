import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_indicator/page_indicator.dart';

import '../../blocs/now_playing/now_playing_cubit.dart';
import '../../repos/movie_repo.dart';
import '../../styles/theme.dart' as style;

class NowPlayingView extends StatelessWidget {
  NowPlayingView({super.key, required this.movieRepo});

  final MovieRepo movieRepo;

  final PageController pageController = PageController(
    viewportFraction: 1,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NowPlayingCubit>().state;

    switch (state.status) {
      case ListStatus.loading:
        return _buildLoadingWidget();
      case ListStatus.failure:
        return _buildErrorWidget(state.status.toString());
      case ListStatus.success:
        if (state.movies.isEmpty) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Text("No movies"),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: 220,
            child: PageIndicatorContainer(
              align: IndicatorAlign.bottom,
              indicatorSpace: 8.0,
              padding: const EdgeInsets.all(5.0),
              indicatorColor: style.Colors.titleColor,
              indicatorSelectorColor: style.Colors.secondColor,
              shape: IndicatorShape.circle(size: 5.0),
              length: state.movies.take(5).length,
              child: PageView.builder(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                itemCount: state.movies.take(5).length,
                itemBuilder: (context, index) => Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: NetworkImage("https://image.tmdb.org/t/p/original/${state.movies[index].backPoster}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            style.Colors.mainColor.withOpacity(1.0),
                            style.Colors.mainColor.withOpacity(0.0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: const [
                            0.0,
                            0.9,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30.0,
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        width: 250.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              state.movies[index].title,
                              style: const TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      default:
        return _buildLoadingWidget();
    }
  }
  
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
}
