import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription? locationSubscription;

  LocationBloc() : super(LocationState()) {
    on<LocationEvent>((event, emit) {});
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();

    print(position);
  }

  void startFollowingUser() {
    locationSubscription = Geolocator.getPositionStream().listen((event) {
      print(event);
    });
  }

  void stopFollowingUser() {
    locationSubscription?.cancel();
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
