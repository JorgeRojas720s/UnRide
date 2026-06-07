import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/blocs/driver_post/bloc/driver_post_bloc.dart';
import 'package:un_ride/screens/Widgets/animations/no_posts.dart';
import 'package:un_ride/screens/Widgets/cards/card_client.dart';
import 'package:un_ride/screens/Widgets/cards/card_drivers.dart';

class DriverPostBody extends StatelessWidget {
  final bool showMenuButton;
  final Function(String? postId, dynamic post)? onEditPost;
  final Function(String? postId)? onDeletePost;

  const DriverPostBody({
    super.key,
    this.showMenuButton = false,
    this.onEditPost,
    this.onDeletePost,
  });

  Future<void> _onRefresh(BuildContext context) async {
    context.read<DriverPostBloc>().add(LoadDriversPosts());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      child: BlocBuilder<DriverPostBloc, DriverPostState>(
        builder: (context, state) {
          if (state.status == DriverPostStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == DriverPostStatus.success) {
            final posts = state.posts;
            if (posts.isEmpty) {
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
                  print("📍📍📍📍📍📍📍📍📍");
                  print(post.postId);
                  return DriverPostCard(
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
                    allowsPets: post.allowsPets,
                    allowsLuggage: post.allowsLuggage,
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
          } else if (state.status == DriverPostStatus.error) {
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
