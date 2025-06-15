import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/blocs/client_post/bloc/client_post_bloc.dart';
import 'package:un_ride/screens/Widgets/animations/no_posts.dart';
import 'package:un_ride/screens/Widgets/cards/card_client.dart';

class ClientPostBody extends StatelessWidget {
  final bool showMenuButton;
  final Function(String? postId, dynamic post)? onEditPost;
  final Function(String? postId)? onDeletePost;

  const ClientPostBody({
    super.key,
    this.showMenuButton = false,
    this.onEditPost,
    this.onDeletePost,
  });

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
            print('lalallllalaaaaaaaaaaaa $posts');
            if (posts.isEmpty) {
              print("🐕🐕🐕🐕");
              return const Center(child: NoPosts());
            }
            return SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),

                // physics: AlwaysScrollableScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  print('0000Psssssssssssss $post');
                  return ClientPostCard(
                    userName: post.name,
                    userSurname: post.surname,
                    phoneNumber: post.phoneNumber,
                    userAvatar: post.profilePictureUrl,
                    origin: post.origin,
                    destination: post.destination,
                    description: post.description,
                    passengers: post.passengers,
                    suggestedAmount: post.suggestedAmount,
                    travelDate: post.travelDate,
                    travelTime: post.travelTime,
                    showMenuButton: showMenuButton,
                    postId: post.postId,
                    onEdit:
                        showMenuButton && onEditPost != null
                            ? () => onEditPost!(post.postId, post)
                            : null,
                    onDelete:
                        showMenuButton && onDeletePost != null
                            ? () => onDeletePost!(post.postId)
                            : null,
                  );
                },
              ),
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
