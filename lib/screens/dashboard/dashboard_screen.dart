import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//main layout
class DashboardScreen extends StatefulWidget {
  final Widget child;

  const DashboardScreen({super.key, required this.child});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isHover = false;
  double _railWidth = 72;
  bool sideBarExtended = false;
  bool isPined = false;
  @override
  void initState() {
    isHover = true;
    _railWidth = 150;
    sideBarExtended = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MouseRegion(
              onEnter: (_) => setState(() {
                if (isPined) {
                  isHover = true;
                  _railWidth = 150;
                }
              }),
              onExit: (_) => setState(() {
                if (isPined) {
                  isHover = false;
                  _railWidth = 72;
                }
              }),
              child: AnimatedContainer(
                onEnd: () {
                  setState(() {
                    sideBarExtended = !sideBarExtended;
                  });
                },
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: _railWidth,
                child: NavigationRail(
                  extended: _railWidth > 72,
                  backgroundColor: Colors.grey[200],
                  selectedIndex: _calculateSelectedIndex(context),
                  onDestinationSelected: (index) =>
                      _onItemTapped(index, context),
                  destinations: [
                    NavigationRailDestination(
                      icon: const Icon(Icons.home),
                      label: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: sideBarExtended ? 1.0 : 0.0,
                        child: sideBarExtended && isHover
                            ? const Text('خانه')
                            : null,
                      ),
                    ),
                    NavigationRailDestination(
                      icon: const Icon(Icons.person),
                      label: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: sideBarExtended ? 1.0 : 0.0,
                        child: sideBarExtended && isHover
                            ? const Text('پروفایل')
                            : null,
                      ),
                    ),
                    NavigationRailDestination(
                      icon: const Icon(Icons.settings),
                      label: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: sideBarExtended ? 1.0 : 0.0,
                        child: sideBarExtended && isHover
                            ? const Text('تنظیمات')
                            : null,
                      ),
                    ),
                    NavigationRailDestination(
                      icon: const Icon(Icons.notifications),
                      label: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: sideBarExtended ? 1.0 : 0.0,
                        child: sideBarExtended && isHover
                            ? const Text('اعلان‌ها')
                            : null,
                      ),
                    ),
                    NavigationRailDestination(
                      icon: isPined
                          ? const Icon(Icons.push_pin_outlined)
                          : const Icon(Icons.push_pin),
                      label: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: sideBarExtended ? 1.0 : 0.0,
                        child: sideBarExtended && isHover
                            ? const Text('پین کردن')
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: widget.child),
          ],
        ),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;
    switch (path) {
      case '/':
        return 0;
      case '/profile':
        return 1;
      case '/settings':
        return 2;
      case '/notifications':
        return 3;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/profile');
        break;
      case 2:
        context.go('/settings');
        break;
      case 3:
        context.go('/notifications');
        break;
      case 4:
        setState(() {
          isPined = !isPined;
          setState(() {
            if (!isPined) {
              isHover = true;
              _railWidth = 150;
            } else {
              isHover = false;
              _railWidth = 72;
            }
          });
        });
        break;
    }
  }
}
