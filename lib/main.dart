import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../repos/movie_repo.dart';
import '../screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF151C26),
    ),
  );

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );
  
  final movieRepo = MovieRepo();

  runApp(MyApp(movieRepo: movieRepo));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.movieRepo});

  final MovieRepo movieRepo;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(movieRepo: movieRepo),
    );
  }
}
