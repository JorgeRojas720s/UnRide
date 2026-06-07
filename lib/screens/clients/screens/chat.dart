import 'package:flutter/material.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/repository/client_chat/models/client_chat.dart';
import 'package:un_ride/screens/Widgets/cards/chat_card.dart';
import 'package:un_ride/screens/Widgets/layaout/chat/individual_chat_screen.dart';
import 'package:un_ride/screens/clients/screens/chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<ClientChat> _chats = [];
  List<ClientChat> _filteredChats = [];
  bool _isSearching = false;
  ClientChat? _recentlyDeletedChat;
  int? _recentlyDeletedIndex;

  @override
  void initState() {
    super.initState();
    _loadStaticChats();
    _filteredChats = _chats;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadStaticChats() {
    _chats = [
      ClientChat(
        id: '1',
        userName: 'María González',
        userAvatar: null,
        lastMessage: 'Hola, ¿confirmas el viaje para mañana?',
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        hasNewMessage: true,
        isOnline: true,
      ),
      ClientChat(
        id: '2',
        userName: 'Carlos Rodríguez',
        userAvatar: null,
        lastMessage: 'Perfecto, nos vemos en el punto de encuentro',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
        hasNewMessage: false,
        isOnline: false,
      ),
      ClientChat(
        id: '3',
        userName: 'Ana Jiménez',
        userAvatar: null,
        lastMessage: '¿Podemos cambiar la hora del viaje?',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 4)),
        hasNewMessage: true,
        isOnline: true,
      ),
      ClientChat(
        id: '4',
        userName: 'Luis Morales',
        userAvatar: null,
        lastMessage: 'Gracias por el viaje, todo excelente',
        lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
        hasNewMessage: false,
        isOnline: false,
      ),
      ClientChat(
        id: '5',
        userName: 'Sofia Vargas',
        userAvatar: null,
        lastMessage: 'Disculpa, llegué tarde. ¿Sigues ahí?',
        lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
        hasNewMessage: true,
        isOnline: true,
      ),
    ];

    _chats.sort((a, b) {
      if (a.hasNewMessage && !b.hasNewMessage) return -1;
      if (!a.hasNewMessage && b.hasNewMessage) return 1;
      return b.lastMessageTime.compareTo(a.lastMessageTime);
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        _filteredChats = _chats;
        _isSearching = false;
      } else {
        _isSearching = true;
        _filteredChats =
            _chats
                .where(
                  (chat) =>
                      chat.userName.toLowerCase().contains(
                        value.toLowerCase(),
                      ) ||
                      chat.lastMessage.toLowerCase().contains(
                        value.toLowerCase(),
                      ),
                )
                .toList();
      }
    });
  }

  void _markAsRead(String chatId) {
    setState(() {
      final chatIndex = _chats.indexWhere((chat) => chat.id == chatId);
      if (chatIndex != -1) {
        _chats[chatIndex] = _chats[chatIndex].copyWith(hasNewMessage: false);
        _updateFilteredChats();
      }
    });
  }

  void _updateFilteredChats() {
    if (_isSearching) {
      _filteredChats =
          _chats
              .where(
                (chat) =>
                    chat.userName.toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    ) ||
                    chat.lastMessage.toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    ),
              )
              .toList();
    } else {
      _filteredChats = List.from(_chats);
    }
  }

  void _deleteChat(String chatId) {
    final chatToDelete = _chats.firstWhere((chat) => chat.id == chatId);
    final originalIndex = _chats.indexWhere((chat) => chat.id == chatId);

    setState(() {
      _recentlyDeletedChat = chatToDelete;
      _recentlyDeletedIndex = originalIndex;

      _chats.removeWhere((chat) => chat.id == chatId);

      _updateFilteredChats();
    });

    final snackBar = SnackBar(
      content: const Text('Chat eliminado'),
      backgroundColor: AppColors.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(16),
      action: SnackBarAction(
        label: 'Deshacer',
        textColor: Colors.white,
        onPressed: () {
          if (_recentlyDeletedChat != null && _recentlyDeletedIndex != null) {
            setState(() {
              _chats.insert(_recentlyDeletedIndex!, _recentlyDeletedChat!);
              _updateFilteredChats();
              _recentlyDeletedChat = null;
              _recentlyDeletedIndex = null;
            });
          }
        },
      ),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar).closed.then((reason) {
        if (reason != SnackBarClosedReason.action) {
          setState(() {
            _recentlyDeletedChat = null;
            _recentlyDeletedIndex = null;
          });
        }
      });
  }

  void _openChat(ClientChat chat) {
    _markAsRead(chat.id);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => IndividualChatScreen(chat: chat)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        title: const Text(
          'Mensajes',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 60,
      ),
      body: Column(
        children: [
          // Buscador
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Buscar mensajes...',
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                ),
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                        )
                        : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),

          // Lista de chats
          Expanded(
            child:
                _filteredChats.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                      itemCount: _filteredChats.length,
                      itemBuilder: (context, index) {
                        final chat = _filteredChats[index];
                        return ChatCard(
                          key: ValueKey(chat.id),
                          chat: chat,
                          onTap: () => _openChat(chat),
                          onDelete: () => _deleteChat(chat.id),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _isSearching ? Icons.search_off : Icons.chat_bubble_outline,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            _isSearching ? 'No se encontraron mensajes' : 'No hay mensajes',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _isSearching
                ? 'Intenta con otros términos de búsqueda'
                : 'Tus conversaciones aparecerán aquí',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
