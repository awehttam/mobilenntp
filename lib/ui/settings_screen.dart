import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/providers.dart';
import 'widgets.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const _intervals = <int, String>{
    0: 'Off',
    5: 'Every 5 minutes',
    15: 'Every 15 minutes',
    30: 'Every 30 minutes',
    60: 'Every hour',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final status = ref.watch(syncStatusProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: settings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (s) => ListView(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Text('Background sync'),
            ),
            for (final entry in _intervals.entries)
              RadioListTile<int>(
                title: Text(entry.value),
                value: entry.key,
                groupValue: s.syncIntervalMinutes,
                onChanged: (v) => ref
                    .read(databaseProvider)
                    .setSyncIntervalMinutes(v ?? 0),
              ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text(
                'Sync runs while the app is open and once when it is reopened. '
                'It refreshes headers for every subscribed group.',
                style: TextStyle(fontSize: 12),
              ),
            ),
            const Divider(height: 32),
            ListTile(
              leading: status.running
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.sync),
              title: Text(status.running
                  ? 'Syncing ${status.done}/${status.total}…'
                  : 'Sync all now'),
              subtitle: Text(
                status.lastError != null
                    ? 'Last error: ${status.lastError}'
                    : status.lastRun != null
                        ? 'Last synced ${formatRelative(status.lastRun!)}'
                        : 'Not synced yet',
              ),
              onTap: status.running
                  ? null
                  : () => ref.read(syncServiceProvider).syncAll(),
            ),
          ],
        ),
      ),
    );
  }
}
