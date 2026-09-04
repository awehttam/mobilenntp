# mobilenntp

A cross-platform (Flutter) Usenet newsreader focused on **reading and posting text
newsgroups**. Multiple servers, offline caching, threaded discussions. No binary
downloads, NZB handling, or file search.

Runs on Android, iOS, Windows, macOS, and Linux from a single codebase.

## Features

- **Multiple servers** — add any number of NNTP servers, each with its own
  connection settings and posting identity.
- **Secure connections** — plain or SSL/TLS (`AUTHINFO USER/PASS`), with an
  optional "allow invalid certificates" escape hatch. Passwords are stored in the
  platform keystore (`flutter_secure_storage`), never in the database.
- **Group browser** — download the server's full group list, search it by name or
  description, subscribe/unsubscribe with one tap.
- **Threaded reading** — JWZ-style `References`/`In-Reply-To` threading, with flat
  (newest-first) and unread-only views as alternatives.
- **Text-first article view** — MIME-aware decoding (RFC 2047 headers,
  quoted-printable / base64 bodies, charset conversion, `multipart/alternative`
  → `text/plain`), quote-level coloring, signature detection, selectable
  monospace text, in-thread navigation.
- **Posting** — new articles and replies (quoted body, correct `References` /
  `In-Reply-To`), cross-posting, per-server `From` identity.
- **Offline cache** — headers and fetched bodies are cached in SQLite (`drift`);
  read/unread and starred state persist. Old unstarred articles are pruned
  automatically.
- **Periodic sync** — configurable interval (off / 5 / 15 / 30 / 60 min) that
  refreshes every subscription while the app is open, plus a catch-up sync when
  the app returns to the foreground. Pull-to-refresh and "Sync all now" trigger
  it manually.

> Background sync is a **foreground** scheduler. Syncing while the app is
> suspended or killed would require platform background-task APIs
> (`workmanager` / BGTaskScheduler) and is not yet implemented.

## Getting started

Requires the Flutter SDK (Dart 3.8+).

```bash
flutter pub get
dart run build_runner build      # generate drift database code
flutter run -d <device>          # windows | macos | linux | <android id> | <ios id>
```

After changing anything in `lib/data/database.dart`, re-run the `build_runner`
command to regenerate `database.g.dart`.

### First run

1. **Servers** tab → **Add server**: display name, host, port (563 for TLS is
   filled in automatically), and — under **Identity** — the email address used in
   your `From` header (required before you can post). Use **Test connection** to
   verify.
2. **Groups** tab → **Add groups**: pick the server, wait for the group list to
   download, search, and subscribe.
3. Open a subscription to sync and read. The compose button posts a new article;
   **Reply** from an open article quotes it.
4. **Settings** (gear icon on the Groups screen) configures the sync interval.

## Project layout

| Path | Responsibility |
| --- | --- |
| `lib/nntp/` | Pure-Dart NNTP client (RFC 3977), MIME decoding, wire models |
| `lib/data/` | `drift` database, credential store, connection pool, repository, sync service |
| `lib/logic/` | Reference threading, reply quoting |
| `lib/state/` | Riverpod providers |
| `lib/ui/` | Screens and widgets |
| `test/` | Unit tests for MIME decoding, date parsing, overview parsing, threading |

```bash
flutter analyze
flutter test
```

## Platform notes

- **Android** — `INTERNET` permission is declared in the manifest.
- **macOS** — `com.apple.security.network.client` entitlement is set for debug and
  release.
- **Windows / Linux** — no extra configuration.
