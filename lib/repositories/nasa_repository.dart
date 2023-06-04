import 'package:creative_fabrica/models/mars_rover_model.dart';
import 'package:dio/dio.dart';

class NasaApiClient {
  NasaApiClient() {
    var tokenOptions = BaseOptions(
        receiveTimeout: const Duration(seconds: 20),
        connectTimeout: const Duration(seconds: 20),
        contentType: Headers.jsonContentType,
        queryParameters: {
          "api_key": "jjvh7aaIoiNQMUOZW3kjVPgz0o63Oya3XjGMY7Pn"
        });
    _dio = Dio(tokenOptions);
  }

  late Dio _dio;

  Future<MarsRoverPhotos> getMarsRoverPhotos() async {
    final uriResponse = await _dio.get(
        "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos",
        queryParameters: {"sol": 1000});
    if (uriResponse.statusCode == 200) {
      return MarsRoverPhotos.fromJson(uriResponse.data);
    } else {
      throw Exception("Unexpected Error Occurred");
    }
  }
}
