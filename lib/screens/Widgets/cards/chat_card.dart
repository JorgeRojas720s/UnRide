import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/repository/client_chat/models/client_chat.dart';

class ChatCard extends StatefulWidget {
  final ClientChat chat;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ChatCard({
    super.key,
    required this.chat,
    required this.onTap,
    required this.onDelete,
  });

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _deleteOpacityAnimation;

  bool _isSliding = false;
  double _currentSlideOffset = 0.0;
  static const double _deleteThreshold = 0.5;
  static const double _sensitivity = 0.002;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _deleteOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    _slideController.stop();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final delta = details.delta.dx / screenWidth;

    setState(() {
      _currentSlideOffset += delta;
      _currentSlideOffset = _currentSlideOffset.clamp(0.0, 1.0);

      if (_currentSlideOffset > 0.1) {
        _isSliding = true;
      }
    });

    _slideController.value = _currentSlideOffset;
  }

  void _onPanEnd(DragEndDetails details) {
    if (_currentSlideOffset >= _deleteThreshold) {
      _slideController.forward().then((_) {
        widget.onDelete();
      });
    } else {
      _slideController.reverse().then((_) {
        setState(() {
          _isSliding = false;
          _currentSlideOffset = 0.0;
        });
      });
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Ahora';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m';
    } else if (difference.inDays < 1) {
      return DateFormat('HH:mm').format(dateTime);
    } else if (difference.inDays < 7) {
      final weekdays = ['', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
      return weekdays[dateTime.weekday];
    } else {
      return DateFormat('dd/MM').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Stack(
        children: [
          // Fondo de eliminación
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _deleteOpacityAnimation,
              builder:
                  (context, child) => Container(
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(
                        _deleteOpacityAnimation.value * 0.1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: Colors.red.withOpacity(
                            _deleteOpacityAnimation.value,
                          ),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Eliminar',
                          style: TextStyle(
                            color: Colors.red.withOpacity(
                              _deleteOpacityAnimation.value,
                            ),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
            ),
          ),

          // Tarjeta principal
          GestureDetector(
            onTap: _isSliding ? null : widget.onTap,
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: SlideTransition(
              position: _slideAnimation,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBackground,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow:
                      _isSliding
                          ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(2, 2),
                            ),
                          ]
                          : null,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _isSliding ? null : widget.onTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          // Avatar con indicador de estado
                          Stack(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28),
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primary,
                                      AppColors.accentPink,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child:
                                    widget.chat.userAvatar != null
                                        ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            28,
                                          ),
                                          child: Image.network(
                                            widget.chat.userAvatar!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                        : const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                              ),
                              if (widget.chat.isOnline)
                                Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: AppColors.scaffoldBackground,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(width: 12),

                          // Información del chat
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.chat.userName,
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 16,
                                          fontWeight:
                                              widget.chat.hasNewMessage
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          _formatTime(
                                            widget.chat.lastMessageTime,
                                          ),
                                          style: TextStyle(
                                            color:
                                                widget.chat.hasNewMessage
                                                    ? AppColors.primary
                                                    : AppColors.textSecondary,
                                            fontSize: 14,
                                            fontWeight:
                                                widget.chat.hasNewMessage
                                                    ? FontWeight.w500
                                                    : FontWeight.w400,
                                          ),
                                        ),
                                        if (widget.chat.hasNewMessage) ...[
                                          const SizedBox(width: 8),
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: const BoxDecoration(
                                              color: AppColors.primary,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  widget.chat.lastMessage,
                                  style: TextStyle(
                                    color:
                                        widget.chat.hasNewMessage
                                            ? AppColors.textPrimary
                                            : AppColors.textSecondary,
                                    fontSize: 14,
                                    fontWeight:
                                        widget.chat.hasNewMessage
                                            ? FontWeight.w500
                                            : FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
