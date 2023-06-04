import 'package:creative_fabrica/blocs/auth/auth_cubit.dart';
import 'package:creative_fabrica/blocs/marsrover/marsrover_cubit.dart';
import 'package:creative_fabrica/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) =>
                          MarsroverCubit()..getMarsRoverPhotos(),
                      child: const HomePage(),
                    )));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
            ));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Unauthenticated) {
            return Center(
              child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).loginAnonymously();
                  },
                  child: const Text("Login Anonymously")),
            );
          } else {
            return const Text("meow");
          }
        },
      ),
    );
  }
}
