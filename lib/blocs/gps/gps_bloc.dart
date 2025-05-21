import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsSubscription;

  GpsBloc()
    : super(const GpsState(isGPSEnable: false, isGPSPermissionGranted: false)) {
    on<GPSPermissionEvent>(
      (event, emit) => emit(
        state.copyWith(
          isGPSEnable: event.isGPSEnable,
          isGPSPermissionGranted: event.isGPSPermissionGranted,
        ),
      ),
    );

    _init();
  }

  Future<void> _init() async {
    final permissions = await Future.wait([_isGPSEnabled(), _isGranted()]);

    add(
      GPSPermissionEvent(
        isGPSEnable: permissions[0],
        isGPSPermissionGranted: permissions[1],
      ),
    );
  }

  Future<bool> _isGranted() async {
    return Permission.location.isGranted;
  }

  Future<bool> _isGPSEnabled() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();

    gpsSubscription = Geolocator.getServiceStatusStream().listen((event) {
      add(
        GPSPermissionEvent(
          isGPSEnable: event.index == 1,
          isGPSPermissionGranted: state.isGPSPermissionGranted,
        ),
      );
    });

    return isEnabled;
  }

  Future<void> requestGPSAccess() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        add(
          GPSPermissionEvent(
            isGPSEnable: state.isGPSEnable,
            isGPSPermissionGranted: true,
          ),
        );
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        add(
          GPSPermissionEvent(
            isGPSEnable: state.isGPSEnable,
            isGPSPermissionGranted: false,
          ),
        );
        openAppSettings();
    }
  }

  @override
  Future<void> close() {
    gpsSubscription?.cancel();
    return super.close();
  }
}
