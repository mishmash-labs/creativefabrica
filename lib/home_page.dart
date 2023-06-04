import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_fabrica/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'blocs/marsrover/marsrover_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Mars Rover"),
      ),
      body: BlocBuilder<MarsroverCubit, MarsroverState>(
        builder: (context, state) {
          if (state is LoadingRover) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedRover) {
            final DateFormat formatter = DateFormat('dd MMMM y');
            return ListView.builder(
              itemBuilder: (context, index) {
                var data = state.roverPhotos.photos[index];
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: data.imgSrc,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  title: Text(
                      "${data.rover.name} - ${formatter.format(data.earthDate)} "),
                  subtitle: Text(data.camera.fullName),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailsPage(photoData: data),
                    ));
                  },
                );
              },
            );
          } else if (state is FailedRover) {
            return Center(child: Text(state.error));
          }
          return Container();
        },
      ),
    );
  }
}
