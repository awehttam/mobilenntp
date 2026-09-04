import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state/providers.dart';
import 'ui/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MobileNntpApp()));
}

class MobileNntpApp extends StatelessWidget {
  const MobileNntpApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF3A6EA5);
    return MaterialApp(
      title: 'mobilenntp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const _SyncCoordinator(child: HomeScreen()),
    );
  }
}

/// Keeps the periodic sync scheduler in step with the saved interval and runs a
/// catch-up sync whenever the app resumes.
class _SyncCoordinator extends ConsumerStatefulWidget {
  final Widget child;
  const _SyncCoordinator({required this.child});

  @override
  ConsumerState<_SyncCoordinator> createState() => _SyncCoordinatorState();
}

class _SyncCoordinatorState extends ConsumerState<_SyncCoordinator>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(syncServiceProvider).maybeCatchUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider).valueOrNull;
    if (settings != null) {
      ref.read(syncServiceProvider).applyInterval(settings.syncIntervalMinutes);
    }
    return widget.child;
  }
}
