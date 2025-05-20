part of 'gps_bloc.dart';

sealed class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class GPSPermissionEvent extends GpsEvent {
  final bool isGPSEnable;
  final bool isGPSPermissionGranted;

  const GPSPermissionEvent({
    required this.isGPSEnable,
    required this.isGPSPermissionGranted,
  });
}
