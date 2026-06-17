import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../services/api_service.dart';

class ChatRoomScreen extends StatefulWidget {
  final int messageId;
  final String senderName;
  final String senderImage;
  final bool isOnline;

  const ChatRoomScreen({
    super.key,
    required this.messageId,
    required this.senderName,
    required this.senderImage,
    this.isOnline = false,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = true;
  List<ChatDetail> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  Future<void> _loadChats() async {
    try {
      setState(() => _isLoading = true);
      final data = await ApiService.getChatDetails(widget.messageId);
      setState(() {
        _messages = data.map((e) => ChatDetail.fromJson(e as Map<String, dynamic>)).toList();
        _isLoading = false;
      });
      _scrollToBottom();
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _sendMessage() async {
    if (_msgController.text.trim().isEmpty) return;

    final text = _msgController.text.trim();
    _msgController.clear();

    // Optimistic update
    setState(() {
      _messages.add(ChatDetail(
        id: DateTime.now().millisecondsSinceEpoch,
        text: text,
        isMe: true,
        time: 'Sekarang',
      ));
    });
    _scrollToBottom();

    try {
      await ApiService.sendChat(widget.messageId, text);
    } catch (_) {
      // Gagal kirim - bisa tampilkan error tapi pesan tetap visible
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryPurple = const Color(0xFF7A58E6);
    final Color darkText = const Color(0xFF2D3142);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: darkText, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: widget.senderImage.isNotEmpty ? NetworkImage(widget.senderImage) : null,
                    child: widget.senderImage.isEmpty ? const Icon(Icons.person_rounded, color: Colors.grey) : null,
                  ),
                  if (widget.isOnline)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFF22C55E),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.senderName,
                      style: TextStyle(color: darkText, fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.isOnline ? 'Online' : 'Offline',
                      style: TextStyle(
                        color: widget.isOnline ? const Color(0xFF22C55E) : Colors.grey.shade500,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(icon: Icon(Icons.call_rounded, color: primaryPurple), onPressed: () {}),
            IconButton(icon: Icon(Icons.more_vert_rounded, color: darkText), onPressed: () {}),
            const SizedBox(width: 8),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(height: 1, color: Colors.grey.shade200),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF7A58E6)))
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      return _buildMessageBubble(
                        text: msg.text,
                        isMe: msg.isMe,
                        time: msg.time,
                        primaryPurple: primaryPurple,
                        darkText: darkText,
                      );
                    },
                  ),
          ),
          _buildMessageInputArea(primaryPurple),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({
    required String text,
    required bool isMe,
    required String time,
    required Color primaryPurple,
    required Color darkText,
  }) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? primaryPurple : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: isMe ? const Radius.circular(20) : const Radius.circular(5),
                  bottomRight: isMe ? const Radius.circular(5) : const Radius.circular(20),
                ),
                boxShadow: isMe
                    ? []
                    : [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Text(
                text,
                style: TextStyle(color: isMe ? Colors.white : darkText, fontSize: 14, height: 1.4),
              ),
            ),
            const SizedBox(height: 6),
            Text(time, style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInputArea(Color primaryPurple) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, -5))],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.attach_file_rounded, color: Colors.grey.shade500), onPressed: () {}),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _msgController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendMessage(),
                  decoration: const InputDecoration(
                    hintText: 'Ketik pesan...',
                    hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryPurple,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: primaryPurple.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}