# TCPSocket

**Status:** Historical Racecar table/library reference. **Modern fields and methods have not been verified by a live table inspection.**

**Live name scan:** `TCPSocket` was observed to have Lua type `table` in November 2026. Its individual methods were not invoked by that survey.

## Historical purpose

socket class

## Historically described methods

The archived `TCPSocket` page describes an asynchronous socket API, with callback handlers for connection, reading and writing.

**Method names mentioned:** `Connect`, `Listen`, `Accept`, `SetConnectHandler`, `SetReadHandler`, `SetWriteHandler`, `Send`, `Recv`, `GetSocketError`, `GetPeerName`.

Historically, `Connect` is non-blocking and connection completion is signaled through a write handler. Check actual behavior before depending on this description.

## Evidence and limitations

- [Racecar table/library page](https://www.vo-wiki.com/racecar2/index.php/TCPSocket)
- Historical claims may be incomplete or outdated. Observe live keys and method values before assigning modern type or behavioral confidence.
