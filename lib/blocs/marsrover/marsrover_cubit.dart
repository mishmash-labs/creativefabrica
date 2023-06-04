import 'package:bloc/bloc.dart';
import 'package:creative_fabrica/models/mars_rover_model.dart';
import 'package:creative_fabrica/repositories/nasa_repository.dart';
import 'package:meta/meta.dart';

part 'marsrover_state.dart';

class MarsroverCubit extends Cubit<MarsroverState> {
  MarsroverCubit() : super(LoadingRover());
  final NasaApiClient _apiClient = NasaApiClient();

  void getMarsRoverPhotos() async {
    try {
      MarsRoverPhotos roverPhotos = await _apiClient.getMarsRoverPhotos();
      emit(LoadedRover(roverPhotos));
    } catch (e) {
      emit(FailedRover(e.toString()));
    }
  }
}
