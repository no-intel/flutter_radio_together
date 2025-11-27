import 'dart:math' as math;

import 'package:flutter/material.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  bool isPlaying = false;
  double volume = 70;
  bool isMuted = false;
  String messageText = '';
  final ScrollController _scrollController = ScrollController();

  final currentStation = {
    'name': 'Chill Vibes Radio',
    'nowPlaying': 'Summer Nights - The Wave',
    'listeners': 1234,
  };

  final List<ChatMessageData> messages = [
    ChatMessageData(
      id: '1',
      user: '음악러버',
      text: '이 노래 진짜 좋네요! 🎵',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      avatar: '🎧',
      isMe: false,
    ),
    ChatMessageData(
      id: '2',
      user: 'DJ_민수',
      text: '오늘 선곡 어떠신가요?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
      avatar: '🎤',
      isMe: false,
    ),
    ChatMessageData(
      id: '3',
      user: '밤하늘',
      text: '밤에 듣기 딱 좋은 분위기예요',
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      avatar: '⭐',
      isMe: false,
    ),
    ChatMessageData(
      id: '4',
      user: '커피한잔',
      text: '커피 마시면서 듣고 있어요 ☕',
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      avatar: '☕',
      isMe: false,
    ),
  ];

  void _sendMessage() {
    if (messageText.trim().isEmpty) return;

    setState(() {
      messages.add(
        ChatMessageData(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          user: '나',
          text: messageText,
          timestamp: DateTime.now(),
          avatar: '😊',
          isMe: true,
        ),
      );
      messageText = '';
    });

    // 새 메시지로 스크롤
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // gray-50
      body: Column(
        children: [
          // AppBar with gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF9333EA), // purple-600
                  Color(0xFF4F46E5), // indigo-600
                  Color(0xFF2563EB), // blue-600
                ],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // AppBar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        // Back button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        // More options button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                // TODO: 더보기 메뉴
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Radio Player
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      children: [
                        // Station Info
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentStation['name'] as String,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${currentStation['listeners']} 청취자',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(
                                Icons.radio,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Album Art + Controls
                        Row(
                          children: [
                            // Album Art / Visualizer
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFC084FC), // purple-400
                                    Color(0xFFF0ABFC), // pink-400
                                    Color(0xFFFB923C), // orange-400
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: isPlaying
                                  ? _AudioVisualizer()
                                  : Icon(
                                      Icons.radio,
                                      color: Colors.white.withOpacity(0.4),
                                      size: 40,
                                    ),
                            ),
                            const SizedBox(width: 12),

                            // Now Playing & Controls
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '지금 재생 중',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    currentStation['nowPlaying'] as String,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),

                                  // Playback Controls
                                  Row(
                                    children: [
                                      // Skip Back
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.skip_previous,
                                          color: Colors.white.withOpacity(0.8),
                                          size: 20,
                                        ),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                      const SizedBox(width: 8),

                                      // Play/Pause
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.3,
                                              ),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                isPlaying = !isPlaying;
                                              });
                                            },
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Icon(
                                                isPlaying
                                                    ? Icons.pause
                                                    : Icons.play_arrow,
                                                color: const Color(0xFF9333EA),
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),

                                      // Skip Forward
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.skip_next,
                                          color: Colors.white.withOpacity(0.8),
                                          size: 20,
                                        ),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                      const Spacer(),

                                      // Volume Control
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isMuted = !isMuted;
                                          });
                                        },
                                        icon: Icon(
                                          (isMuted || volume == 0)
                                              ? Icons.volume_off
                                              : Icons.volume_up,
                                          color: Colors.white.withOpacity(0.8),
                                          size: 16,
                                        ),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                      const SizedBox(width: 6),
                                      SizedBox(
                                        width: 64,
                                        child: SliderTheme(
                                          data: SliderThemeData(
                                            trackHeight: 4,
                                            thumbShape:
                                                const RoundSliderThumbShape(
                                                  enabledThumbRadius: 5,
                                                ),
                                            overlayShape:
                                                const RoundSliderOverlayShape(
                                                  overlayRadius: 12,
                                                ),
                                          ),
                                          child: Slider(
                                            value: isMuted ? 0 : volume,
                                            min: 0,
                                            max: 100,
                                            activeColor: Colors.white,
                                            inactiveColor: Colors.white
                                                .withOpacity(0.3),
                                            onChanged: (value) {
                                              setState(() {
                                                volume = value;
                                                if (value > 0) isMuted = false;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Chat Interface
          Expanded(
            child: Column(
              children: [
                // Chat Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline,
                        color: Color(0xFF9333EA),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '실시간 채팅',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF111827),
                            ),
                          ),
                          Text(
                            '${messages.length}명이 대화 중',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Messages
                Expanded(
                  child: Container(
                    color: const Color(0xFFF9FAFB),
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _ChatMessageWidget(message: messages[index]),
                        );
                      },
                    ),
                  ),
                ),

                // Input
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                messageText = value;
                              });
                            },
                            onSubmitted: (_) => _sendMessage(),
                            decoration: const InputDecoration(
                              hintText: '메시지를 입력하세요...',
                              hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF9333EA), Color(0xFF4F46E5)],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: messageText.trim().isEmpty
                                ? null
                                : _sendMessage,
                            borderRadius: BorderRadius.circular(24),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.send,
                                color: messageText.trim().isEmpty
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Audio Visualizer Widget
class _AudioVisualizer extends StatefulWidget {
  @override
  State<_AudioVisualizer> createState() => _AudioVisualizerState();
}

class _AudioVisualizerState extends State<_AudioVisualizer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(5, (index) {
            final random = math.Random(index);
            final height = 30.0 + random.nextDouble() * 70.0;
            return Container(
              width: 4,
              height: height * (0.3 + _controller.value * 0.7),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        );
      },
    );
  }
}

// Chat Message Widget
class _ChatMessageWidget extends StatelessWidget {
  final ChatMessageData message;

  const _ChatMessageWidget({required this.message});

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: message.isMe
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!message.isMe) ...[
          // Avatar
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFC084FC), Color(0xFFF0ABFC)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(message.avatar, style: const TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Column(
            crossAxisAlignment: message.isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              // User name and time
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.user,
                      style: TextStyle(
                        fontSize: 12,
                        color: message.isMe
                            ? const Color(0xFF9333EA)
                            : const Color(0xFF374151),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatTime(message.timestamp),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),
              // Message bubble
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: message.isMe
                      ? const LinearGradient(
                          colors: [Color(0xFF9333EA), Color(0xFF4F46E5)],
                        )
                      : null,
                  color: message.isMe ? null : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(message.isMe ? 16 : 4),
                    topRight: Radius.circular(message.isMe ? 4 : 16),
                    bottomLeft: const Radius.circular(16),
                    bottomRight: const Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    fontSize: 14,
                    color: message.isMe
                        ? Colors.white
                        : const Color(0xFF111827),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (message.isMe) ...[
          const SizedBox(width: 8),
          // Avatar
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFC084FC), Color(0xFFF0ABFC)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(message.avatar, style: const TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ],
    );
  }
}

// Chat Message Data Model
class ChatMessageData {
  final String id;
  final String user;
  final String text;
  final DateTime timestamp;
  final String avatar;
  final bool isMe;

  ChatMessageData({
    required this.id,
    required this.user,
    required this.text,
    required this.timestamp,
    required this.avatar,
    required this.isMe,
  });
}
