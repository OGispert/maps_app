part of 'gps_bloc.dart';

class GpsState extends Equatable {
  const GpsState({
    required this.isGPSEnable,
    required this.isGPSPermissionGranted,
  });

  final bool isGPSEnable;
  final bool isGPSPermissionGranted;

  bool get isAllGranted => isGPSEnable && isGPSPermissionGranted;

  GpsState copyWith({bool? isGPSEnable, bool? isGPSPermissionGranted}) =>
      GpsState(
        isGPSEnable: isGPSEnable ?? this.isGPSEnable,
        isGPSPermissionGranted:
            isGPSPermissionGranted ?? this.isGPSPermissionGranted,
      );

  @override
  List<Object> get props => [isGPSEnable, isGPSPermissionGranted];
}
