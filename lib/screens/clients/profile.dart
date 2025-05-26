import 'package:flutter/material.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/screens/Widgets/widgets.dart';
import 'package:un_ride/screens/drawer/custom_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  final String _userName = "Jorge Homosexual";
  final String _userEmail = "jorge.rojas@example.com";
  final String _userPhone = "+57 300 123 4567";
  final String _profileImageUrl = "";
  final double _rating = 4.8;
  final String _memberSince = "Enero 2024";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 100 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset <= 100 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  void _openDrawer() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) => CustomDrawer(
              onClose: () => Navigator.of(context).pop(),
              onItemSelected: _handleDrawerItemSelection,
            ),
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: child,
          );
        },
      ),
    );
  }

  void _handleDrawerItemSelection(String item) {
    Navigator.of(context).pop();

    switch (item) {
      case 'saved':
        _showPlaceholderDialog('Saved');
        break;
      case 'archive':
        _showPlaceholderDialog('Archive');
        break;
      case 'activity':
        _showPlaceholderDialog('Your Activity');
        break;
      case 'notifications':
        _showPlaceholderDialog('Notifications');
        break;
      case 'time':
        _showPlaceholderDialog('Time Management');
        break;
      case 'insights':
        _showPlaceholderDialog('Insights');
        break;
      case 'verified':
        _showPlaceholderDialog('Meta Verified');
        break;
      case 'scheduled':
        _showPlaceholderDialog('Scheduled Content');
        break;
      case 'creator':
        _showPlaceholderDialog('Creator Tools');
        break;
    }
  }

  void _showPlaceholderDialog(String feature) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColors.cardBackground,
            title: Text(
              feature,
              style: TextStyle(color: AppColors.textPrimary),
            ),
            content: Text(
              'Esta función estará disponible próximamente.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK', style: TextStyle(color: AppColors.primary)),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final availableHeight = screenHeight - appBarHeight - statusBarHeight;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: availableHeight * 0.40,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.scaffoldBackground,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.menu, color: AppColors.textPrimary),
                onPressed: _openDrawer,
              ),
            ],
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final maxHeight = constraints.maxHeight;
                final minHeight =
                    kToolbarHeight + MediaQuery.of(context).padding.top;

                return FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.scaffoldBackground,
                          AppColors.secondaryBackground.withOpacity(0.8),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Contenido principal
                        Positioned(
                          top: minHeight,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: 20,
                              ), // Espacio para las stats
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildProfileImage(),
                                  SizedBox(height: 10),
                                  _buildUserName(),
                                  SizedBox(height: 8),
                                  _buildUserEmail(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.scaffoldBackground,
              child: Column(
                children: [
                  _buildProfileDetails(),
                  _buildSectionDivider("Mis Publicaciones"),
                  _buildPostsPlaceholder(),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      //!  bottomNavigationBar: const NavBar(),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.accentPink],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.secondaryBackground,
        ),
        child:
            _profileImageUrl.isEmpty
                ? Icon(Icons.person, size: 60, color: AppColors.textPrimary)
                : ClipOval(
                  child: Image.network(_profileImageUrl, fit: BoxFit.cover),
                ),
      ),
    );
  }

  Widget _buildUserName() {
    return Text(
      _userName,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildUserEmail() {
    return Text(
      _userEmail,
      style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Flexible(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 30,
      width: 1,
      color: AppColors.textSecondary.withOpacity(0.3),
    );
  }

  Widget _buildProfileDetails() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.scaffoldBackground, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(Icons.phone_rounded, "Teléfono", _userPhone),
          SizedBox(height: 16),
          _buildDetailRow(
            Icons.calendar_today_rounded,
            "Miembro desde",
            _memberSince,
          ),
          SizedBox(height: 16),
          _buildDetailRow(Icons.star_rounded, "Calificación", "$_rating ⭐"),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionDivider(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsPlaceholder() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(minHeight: 200, maxHeight: 300),
            decoration: BoxDecoration(
              color: AppColors.cardBackground.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.post_add_rounded,
                      size: 48,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Publicaciones",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
