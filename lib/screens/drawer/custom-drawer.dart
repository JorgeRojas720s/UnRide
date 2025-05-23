import 'package:flutter/material.dart';
import 'package:un_ride/screens/clients/clients_home.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool _isDrawerOpen = false;
  String _currentScreen = 'clients';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    if (_isDrawerOpen) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  void _navigateTo(String screen) {
    if (_currentScreen != screen) {
      setState(() {
        _currentScreen = screen;
      });
    }
    _toggleDrawer();
  }

  Widget _getCurrentScreen() {
    switch (_currentScreen) {
      case 'clients':
        return ClientsHome(onMenuPressed: _toggleDrawer);
      case 'saved':
        return _buildGenericScreen('Saved Content', Icons.bookmark);
      case 'archive':
        return _buildGenericScreen('Archive Content', Icons.history);
      case 'activity':
        return _buildGenericScreen('Your Activity', Icons.show_chart);
      case 'notifications':
        return _buildGenericScreen('Notifications', Icons.notifications);
      case 'time':
        return _buildGenericScreen('Time Management', Icons.access_time);
      case 'insights':
        return _buildGenericScreen('Insights', Icons.bar_chart);
      case 'verified':
        return _buildGenericScreen('Meta Verified', Icons.verified);
      case 'scheduled':
        return _buildGenericScreen('Scheduled Content', Icons.schedule);
      case 'creator':
        return _buildGenericScreen('Creator Tools', Icons.tune);
      case 'privacy':
        return _buildGenericScreen('Account Privacy', Icons.lock_outline);
      case 'friends':
        return _buildGenericScreen('Close Friends', Icons.star_border);
      case 'home':
      default:
        return ClientsHome(onMenuPressed: _toggleDrawer);
    }
  }

  Widget _buildGenericScreen(String title, IconData icon) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: _toggleDrawer,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 48),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _getCurrentScreen(),

          AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return _isDrawerOpen
                  ? Positioned.fill(
                    child: Stack(
                      children: [
                        // Semi-transparent overlay
                        Positioned.fill(
                          child: GestureDetector(
                            onTap: _toggleDrawer,
                            child: Container(
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ),

                        // The sliding drawer content (full screen)
                        Transform.translate(
                          offset: Offset(
                            MediaQuery.of(context).size.width *
                                _slideAnimation.value,
                            0,
                          ),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              color: Colors.black,
                              child: SafeArea(
                                // Here we use a Column with a SingleChildScrollView to fix the overflow
                                child: Column(
                                  children: [
                                    // Fixed header that doesn't scroll
                                    _buildDrawerHeader(),
                                    // Scrollable content
                                    Expanded(child: _buildDrawerContent()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Padding(
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
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
            onPressed: _toggleDrawer,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerContent() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMenuOption(
            Icons.people_alt_outlined,
            'Clients Home',
            onTap: () => _navigateTo('clients'),
            isHighlighted: _currentScreen == 'clients',
          ),

          const Divider(color: Colors.grey, height: 32, thickness: 0.5),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Text(
              'How you use the app',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ),
          _buildMenuOption(
            Icons.bookmark_border,
            'Saved',
            onTap: () => _navigateTo('saved'),
            isHighlighted: _currentScreen == 'saved',
          ),
          _buildMenuOption(
            Icons.history,
            'Archive',
            onTap: () => _navigateTo('archive'),
            isHighlighted: _currentScreen == 'archive',
          ),
          _buildMenuOption(
            Icons.show_chart,
            'Your activity',
            onTap: () => _navigateTo('activity'),
            isHighlighted: _currentScreen == 'activity',
          ),
          _buildMenuOption(
            Icons.notifications_none,
            'Notifications',
            onTap: () => _navigateTo('notifications'),
            isHighlighted: _currentScreen == 'notifications',
          ),
          _buildMenuOption(
            Icons.access_time,
            'Time management',
            onTap: () => _navigateTo('time'),
            isHighlighted: _currentScreen == 'time',
          ),

          const Divider(color: Colors.grey, height: 32, thickness: 0.5),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Text(
              'For professionals',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ),
          _buildMenuOption(
            Icons.bar_chart,
            'Insights',
            onTap: () => _navigateTo('insights'),
            isHighlighted: _currentScreen == 'insights',
          ),
          _buildMenuOption(
            Icons.verified,
            'Meta Verified',
            onTap: () => _navigateTo('verified'),
            trailingText: 'Not subscribed',
            isHighlighted: _currentScreen == 'verified',
          ),
          _buildMenuOption(
            Icons.schedule,
            'Scheduled content',
            onTap: () => _navigateTo('scheduled'),
            isHighlighted: _currentScreen == 'scheduled',
          ),
          _buildMenuOption(
            Icons.tune,
            'Creator tools and controls',
            onTap: () => _navigateTo('creator'),
            isHighlighted: _currentScreen == 'creator',
          ),

          const Divider(color: Colors.grey, height: 32, thickness: 0.5),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Text(
              'Who can see your content',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ),
          _buildMenuOption(
            Icons.lock_outline,
            'Account privacy',
            onTap: () => _navigateTo('privacy'),
            trailingText: 'Public',
            isHighlighted: _currentScreen == 'privacy',
          ),
          _buildMenuOption(
            Icons.star_border,
            'Close Friends',
            onTap: () => _navigateTo('friends'),
            trailingText: '16',
            isHighlighted: _currentScreen == 'friends',
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMenuOption(
    IconData icon,
    String title, {
    required VoidCallback onTap,
    String? trailingText,
    bool isHighlighted = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color:
            isHighlighted ? Colors.grey.withOpacity(0.2) : Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: isHighlighted ? Colors.blue : Colors.white,
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isHighlighted ? Colors.blue : Colors.white,
                  fontSize: 18,
                  fontWeight:
                      isHighlighted ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (trailingText != null)
              Text(
                trailingText,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            Icon(
              Icons.chevron_right,
              color: isHighlighted ? Colors.blue : Colors.grey,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }
}
