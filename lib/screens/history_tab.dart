import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_chat/services/chat_provider.dart';
import 'package:mini_chat/widgets/avatar_circle.dart';
import 'package:provider/provider.dart';
import 'package:mini_chat/screens/chat_screen.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String _formatTime(DateTime time) {
    return DateFormat.jm().format(time);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final sessions = context.watch<ChatProvider>().chatSessions;

    if (sessions.isEmpty) {
      return const Center(child: Text("No chat history yet"));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        return ListTile(
          leading: AvatarCircle(initials: session.user.initials),
          title: Text(session.user.name),
          subtitle: Text(
            session.lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatTime(session.lastActive),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: session.unreadCount > 0
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              if (session.unreadCount > 0) ...[
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${session.unreadCount}',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  userId: session.user.id,
                  userName: session.user.name,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
