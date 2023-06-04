part of 'marsrover_cubit.dart';

@immutable
abstract class MarsroverState {}

class LoadingRover extends MarsroverState {}

class LoadedRover extends MarsroverState {
  final MarsRoverPhotos roverPhotos;

  LoadedRover(this.roverPhotos);
}

class FailedRover extends MarsroverState {
  FailedRover(this.error);

  final String error;
}
