import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/blocs/client_post/bloc/client_post_bloc.dart';
import 'package:un_ride/screens/Widgets/widgets.dart';

class ClientsHome extends StatefulWidget {
  const ClientsHome({super.key});

  @override
  State<ClientsHome> createState() => _ClientsHomeState();
}

class _ClientsHomeState extends State<ClientsHome> {
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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Stack(
        children: [
          BlocBuilder<ClientPostBloc, ClientPostState>(
            builder: (context, state) {
              if (state.status == ClientPostStatus.loading) {
                print("👾👾👾👾👾👾👾👾👾👾");
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == ClientPostStatus.success) {
                print("😏😏😏😏😏😏😏😏");
                final posts = state.posts;
                if (posts.length == 0) {
                  print("🐕🐕🐕🐕");
                  return Center(
                    child: Text(
                      "No hay posts",
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return ClientPostCard(
                      origin: post.origin,
                      destination: post.destination,
                      description: post.description,
                      suggestedAmount: post.suggestedAmount,
                      travelDate: post.travelDate,
                      travelTime: post.travelTime,
                    );
                  },
                );
              } else if (state.status == ClientPostStatus.error) {
                print("❌❌❌❌❌❌❌");
                return Center(child: Text("Error al cargar posts"));
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      onRefresh: () => _onRefresh(context),
    );
  }
}
