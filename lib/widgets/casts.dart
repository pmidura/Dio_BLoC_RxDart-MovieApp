import 'package:flutter/material.dart';

import '../blocs/casts_bloc.dart';
import '../models/cast.dart';
import '../models/cast_response.dart';
import '../styles/theme.dart' as style;

class Casts extends StatefulWidget {
  final int id;

  const Casts({
    super.key,
    required this.id,
  });

  @override
  State<Casts> createState() => _CastsState();
}

class _CastsState extends State<Casts> {
  @override
  void initState() {
    super.initState();
    castsBloc.getCasts(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    castsBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      const Padding(
        padding: EdgeInsets.only(left: 10.0, top: 20.0),
        child: Text(
          "CASTS",
          style: TextStyle(
            color: style.Colors.titleColor,
            fontWeight: FontWeight.w500,
            fontSize: 12.0,
          ),
        ),
      ),
      const SizedBox(height: 5.0),
      StreamBuilder<CastResponse>(
        stream: castsBloc.subject.stream,
        builder: (context, AsyncSnapshot<CastResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.error.isNotEmpty) {
              return _buildErrorWidget(snapshot.data!.error);
            }
            return _buildCastsWidget(snapshot.data!);
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

  Widget _buildCastsWidget(CastResponse data) {
    List<Cast> casts = data.casts;

    return Container(
      height: 140.0,
      padding: const EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: casts.length,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.only(top: 10.0, right: 8.0),
          width: 100.0,
          child: GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://image.tmdb.org/t/p/w300/${casts[index].img}"),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  casts[index].name,
                  maxLines: 2,
                  style: const TextStyle(
                    height: 1.4,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 9.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  casts[index].character,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: style.Colors.titleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 7.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
