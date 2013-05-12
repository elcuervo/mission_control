# Mission Control

Completely stupid websocket server.

Ok, here is the thing. Most of the times you just need send a message to any
other peer connected to a given channel but not to the one who originated it.

So that's what Mission Control does. No user identification (beyond knowing to
which channel are connected), no plain HTTP interface (just WS).

Useful for signaling. Created to be used with Anchorman

```bash
ruby app.rb -c config.rb
```
