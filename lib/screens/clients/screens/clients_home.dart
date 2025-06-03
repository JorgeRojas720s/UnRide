import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/blocs/client_post/bloc/client_post_bloc.dart';
import 'package:un_ride/screens/Widgets/animations/no_posts.dart';
import 'package:un_ride/screens/Widgets/widgets.dart';

class ClientsHome extends StatefulWidget {
  const ClientsHome({super.key});

  @override
  State<ClientsHome> createState() => _ClientsHomeState();
}

class _ClientsHomeState extends State<ClientsHome> {
  bool _isDriverMode = false;
  bool _canSwitchToDriver =
      true; // You'll need to determine this based on your business logic

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientPostBloc>().add(LoadClientPosts());
    });
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ClientPostBloc>().add(LoadClientPosts());
  }

  void _toggleRole(bool isDriver) {
    setState(() {
      _isDriverMode = isDriver;
    });
    // Add your role switching logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text(
          "Un Ride",
          style: TextStyle(color: AppColors.textPrimary),
        ),
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: RoleSwitchButton(
              isDriverMode: _isDriverMode,
              onChanged: _toggleRole,
              canSwitchToDriver: _canSwitchToDriver,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: BlocBuilder<ClientPostBloc, ClientPostState>(
          builder: (context, state) {
            if (state.status == ClientPostStatus.loading) {
              print("👾👾👾👾👾👾👾👾👾👾");
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == ClientPostStatus.success) {
              print("😏😏😏😏😏😏😏😏");
              final posts = state.posts;
              if (posts.isEmpty) {
                print("🐕🐕🐕🐕");
                return const Center(child: NoPosts());
              }
              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return ClientPostCard(
                    origin: post.origin,
                    destination: post.destination,
                    description: post.description,
                    passengers: post.passengers,
                    suggestedAmount: post.suggestedAmount,
                    travelDate: post.travelDate,
                    travelTime: post.travelTime,
                  );
                },
              );
            } else if (state.status == ClientPostStatus.error) {
              print("❌❌❌❌❌❌❌");
              return const Center(
                child: Text(
                  "Error al cargar posts",
                  style: TextStyle(color: AppColors.textPrimary),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
