import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/screens/Widgets/animations/no_posts.dart';
import 'package:un_ride/screens/Widgets/cards/card_client.dart';

import '../../../blocs/client_post/bloc/client_post_bloc.dart';

class ClientPostBody extends StatelessWidget {
  const ClientPostBody({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ClientPostBloc>().add(LoadClientsPosts());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
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
    );
  }
}
