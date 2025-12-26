import 'package:flutter/material.dart';
import 'package:mini_chat/widgets/avatar_circle.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  final String? avatarInitials;
  final void Function(String)? onLongPress;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isSender,
    this.avatarInitials,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final String time = "10:30 AM";

    final words = RegExp(
      r'\S+|\n|[^\S\n]+',
    ).allMatches(text).map((m) => m.group(0)!).toList();
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: isSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isSender
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isSender && avatarInitials != null) ...[
                AvatarCircle(initials: avatarInitials!, radius: 18),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 60,
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSender
                          ? const Color(0xFF2962FF)
                          : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.only(
                        topLeft: isSender
                            ? const Radius.circular(15)
                            : const Radius.circular(5),
                        topRight: isSender
                            ? const Radius.circular(5)
                            : const Radius.circular(15),
                        bottomLeft: const Radius.circular(15),
                        bottomRight: const Radius.circular(15),
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: words.map((token) {
                          // If it's a newline, we can just return a TextSpan with \n
                          if (token == '\n') {
                            return const TextSpan(text: '\n');
                          }

                          // If it's a word, use WidgetSpan to keep your GestureDetector
                          return WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: GestureDetector(
                              onLongPress: () => onLongPress?.call(token),
                              child: Text(
                                token,
                                style: TextStyle(
                                  color: isSender
                                      ? Colors.white
                                      : colorScheme.onSurface,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              if (isSender && avatarInitials != null) ...[
                const SizedBox(width: 8),
                AvatarCircle(
                  initials: avatarInitials!,
                  gradientType: AvatarGradientType.purple,
                  radius: 20,
                ),
              ],
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 50, right: 50),
            child: Text(
              time,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          ),
        ],
      ),
    );
  }
}
