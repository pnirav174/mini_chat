import 'package:flutter/material.dart';
import 'package:mini_chat/screens/history_tab.dart';
import 'package:mini_chat/screens/users_tab.dart';
import 'package:mini_chat/services/chat_provider.dart';
import 'package:mini_chat/widgets/custom_tab_switcher.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleAddUser() {
    // Add dummy user
    final name = "User ${context.read<ChatProvider>().users.length}";
    context.read<ChatProvider>().addUser(name);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('User added: $name')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              pinned: false,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              title: SizedBox(
                width: 250,
                child: CustomTabSwitcher(
                  selectedIndex: _tabController.index,
                  onIndexChanged: (index) {
                    _tabController.animateTo(index);
                  },
                ),
              ),
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(6),
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  height: 1,
                  color: Colors.grey,
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: const [UsersTab(), HistoryTab()],
        ),
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF2962FF),
              foregroundColor: Colors.white,
              shape: const CircleBorder(),
              onPressed: _handleAddUser,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
