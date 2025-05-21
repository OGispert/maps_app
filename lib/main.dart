import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/app_blocs.dart';
import 'package:maps_app/screens/screens.dart';

void main() => runApp(
  MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => GpsBloc()),
      BlocProvider(create: (context) => LocationBloc()),
    ],
    child: const MapsApp(),
  ),
);

class MapsApp extends StatelessWidget {
  const MapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(255, 103, 189, 232),
        useMaterial3: true,
      ),
      title: 'MapsApp',
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
    );
  }
}
