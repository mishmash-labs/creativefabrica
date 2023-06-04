import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_fabrica/models/mars_rover_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.photoData});

  final Photo photoData;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMMM y');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Photo Details"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          CachedNetworkImage(
            imageUrl: photoData.imgSrc,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(height: 8),
          _DataRow(title: "Rover Name", data: photoData.rover.name),
          const SizedBox(height: 8),
          _DataRow(title: "Rover Status", data: photoData.rover.status),
          const SizedBox(height: 8),
          _DataRow(
              title: "Rover Launch Date",
              data: formatter.format(photoData.rover.launchDate)),
          const SizedBox(height: 8),
          _DataRow(
              title: "Rover Landing Date",
              data: formatter.format(photoData.rover.landingDate)),
          const SizedBox(height: 8),
          _DataRow(
              title: "Date Taken", data: formatter.format(photoData.earthDate)),
          const SizedBox(height: 8),
          _DataRow(title: "Camera Name", data: photoData.camera.fullName),
          const SizedBox(height: 8),
          _DataRow(title: "Camera Abbreviation", data: photoData.camera.name),
        ],
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({required this.title, required this.data});

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(data)],
      ),
    );
  }
}
