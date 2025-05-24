import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final VoidCallback onClose;
  final Function(String) onItemSelected;

  const CustomDrawer({
    Key? key,
    required this.onClose,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header del drawer
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Settings and activity',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: widget.onClose,
                    ),
                  ],
                ),
              ),

              // Contenido del drawer
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMenuItem(
                        icon: Icons.people_alt_outlined,
                        title: 'Clients Home',
                        onTap: () => widget.onItemSelected('clients'),
                      ),

                      const Divider(
                        color: Colors.grey,
                        height: 32,
                        thickness: 0.5,
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          'How you use the app',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),

                      // Saved
                      _buildMenuItem(
                        icon: Icons.bookmark_border,
                        title: 'Saved',
                        onTap: () => widget.onItemSelected('saved'),
                      ),

                      // Archive (marcado como seleccionado)
                      _buildMenuItem(
                        icon: Icons.history,
                        title: 'Archive',
                        isSelected: true,
                        onTap: () => widget.onItemSelected('archive'),
                      ),

                      // Your activity
                      _buildMenuItem(
                        icon: Icons.show_chart,
                        title: 'Your activity',
                        onTap: () => widget.onItemSelected('activity'),
                      ),

                      // Notifications
                      _buildMenuItem(
                        icon: Icons.notifications_none,
                        title: 'Notifications',
                        onTap: () => widget.onItemSelected('notifications'),
                      ),

                      // Time management
                      _buildMenuItem(
                        icon: Icons.access_time,
                        title: 'Time management',
                        onTap: () => widget.onItemSelected('time'),
                      ),

                      const Divider(
                        color: Colors.grey,
                        height: 32,
                        thickness: 0.5,
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        child: Text(
                          'For professionals',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),

                      // Insights
                      _buildMenuItem(
                        icon: Icons.bar_chart,
                        title: 'Insights',
                        onTap: () => widget.onItemSelected('insights'),
                      ),

                      // Meta Verified
                      _buildMenuItem(
                        icon: Icons.verified,
                        title: 'Meta Verified',
                        trailingText: 'Not subscribed',
                        onTap: () => widget.onItemSelected('verified'),
                      ),

                      // Scheduled content
                      _buildMenuItem(
                        icon: Icons.schedule,
                        title: 'Scheduled content',
                        onTap: () => widget.onItemSelected('scheduled'),
                      ),

                      // Creator tools and controls
                      _buildMenuItem(
                        icon: Icons.tune,
                        title: 'Creator tools and controls',
                        onTap: () => widget.onItemSelected('creator'),
                      ),

                      const Divider(
                        color: Colors.grey,
                        height: 32,
                        thickness: 0.5,
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    bool isSelected = false,
    String? trailingText,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: isSelected ? Colors.blue : Colors.white,
        size: 28,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.white,
          fontSize: 18,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing:
          trailingText != null
              ? Text(
                trailingText,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              )
              : null,
    );
  }
}
