import 'package:maps_app/blocs/gps_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            return !state.isGPSEnable ? _EnableGPSMessage() : _AccessButton();
          },
        ),
      ),
    );
  }
}

class _EnableGPSMessage extends StatelessWidget {
  const _EnableGPSMessage();

  @override
  Widget build(BuildContext context) {
    return Text(
      'You must enable your GPS location.',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'GPS access is required.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        FilledButton(
          style: ButtonStyle(splashFactory: NoSplash.splashFactory),
          onPressed: () {
            final bloc = BlocProvider.of<GpsBloc>(context);
            bloc.requestGPSAccess();
          },
          child: Text(
            'Request Access',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
