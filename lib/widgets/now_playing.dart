import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

import '../blocs/now_playing_bloc.dart';
import '../models/movie.dart';
import '../models/movie_response.dart';
import '../styles/theme.dart' as style;

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key});

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  PageController pageController = PageController(
    viewportFraction: 1,
    keepPage: true,
  );

  @override
  void initState() {
    super.initState();
    nowPlayingBloc.getNowPlaying();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<MovieResponse>(
    stream: nowPlayingBloc.subject.stream,
    builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data!.error.isNotEmpty) {
          return _buildErrorWidget(snapshot.data!.error);
        }
        return _buildNowPlayingWidget(snapshot.data!);
      } else if (snapshot.hasError) {
        return _buildErrorWidget(snapshot.error.toString());
      } else {
        return _buildLoadingWidget();
      }
    },
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
  
  Widget _buildNowPlayingWidget(MovieResponse data) {
    List<Movie> movies = data.movies;

    if (movies.isEmpty) {
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
          length: movies.take(5).length,
          child: PageView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: movies.take(5).length,
            itemBuilder: (context, index) => Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: NetworkImage("https://image.tmdb.org/t/p/original/${movies[index].backPoster}"),
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
                          movies[index].title,
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
  }
}
