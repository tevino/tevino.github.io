---
layout: post
category: lab
title: Fix CORS for Synology WebDAV, no Nginx hacks
lang: en
date: 2026-01-22
slug: fix-cors-for-synology-webdav-no-nginx-hacks
---

How to fix CORS timeouts when using Synology's WebDAV server with browser-based applications. The solution uses HAProxy to handle CORS preflight requests reliably, avoiding the pain of Nginx configuration files being overwritten unexpectedly.

**Prerequisites**: SSH access, Docker or HAProxy installed.

**Solution**: HAProxy 3.2 intercepting OPTIONS requests before they reach the WebDAV backend

---

Synology's built-in WebDAV server works well with native clients, but fails with browser-based apps due to CORS preflight (`OPTIONS`) requests timing out and resulting in `504`.

This happens because the WebDAV backend does not properly handle browser preflight requests.

## Existing solutions

### Nginx hack
A common solution is to modify the Nginx configuration files as a workaround. The problem? These files are managed by DSM, which might overwrite them after a settings change, restart, DSM update, or sometimes even a reboot.

The worst part is discovering your changes have vanished without notice. Suddenly your WebDAV integration stops working, and you're left trying to remember what exactly you changed months ago. Restoring these configurations is both time-consuming and unreliable. Fighting against this mechanism is neither wise nor sustainable.

### Dedicated WebDAV server

Setting up a dedicated WebDAV server like Nextcloud or Apache works, but if CORS is the only thing that you need, this is an overkill.
You likely won't want to set up and maintain yet another WebDAV server with authentication and everything.


### Built-in reverse proxy

Although Synology’s Reverse Proxy can add custom response headers, it cannot terminate or short-circuit CORS preflight requests.
`OPTIONS` requests are still forwarded to the backend, where they hang and eventually time out.

## Solution

A dedicated reverse proxy to handle CORS before the built-in WebDAV is close to perfect, but if you don't want to configure a dedicated SSL certificate for the reverse proxy, read on.


```
Browser / web apps (HTTPS)
   ↓
Synology Reverse Proxy (TLS termination)
   ↓
HAProxy (Docker, HTTP only, handles CORS)
   ↓
Synology WebDAV Server (127.0.0.1:5005)
```

I know this looks like too much for such a simple requirement, but it wins on the maintenance: you only need to configure this once, and you can forget it, it keeps working across DSM updates.

HAProxy configuration:

```
frontend webdav_in
    bind *:A_DEDICATE_PORT_NUMBER
    mode http

   acl is_preflight method OPTIONS

   # Handle CORS preflight
   http-request return status 204 hdr Access-Control-Allow-Origin https://app.example.com hdr Access-Control-Allow-Methods "GET, PUT, POST, DELETE, PROPFIND, OPTIONS" hdr Access-Control-Allow-Headers "Authorization, Content-Type, Depth" hdr Access-Control-Allow-Credentials true hdr Access-Control-Max-Age 86400 if is_preflight

   # Always add CORS headers to actual responses
   http-response set-header Access-Control-Allow-Origin https://app.example.com
   http-response set-header Access-Control-Allow-Credentials true

   default_backend webdav_backend

backend webdav_backend
    mode http
    server webdav 127.0.0.1:5005
```

Save this as `haproxy.cfg` and run HAProxy with Docker:

```bash
docker run -d --name haproxy-webdav --network host -v /path/to/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro haproxy:3.2
```

Remember to use `--network host` so HAProxy can reach the WebDAV server on localhost, or you need to change the `127.0.0.1:5005` accordingly depending on your environment.

## Testing CORS

Verify CORS is working with a simple curl command:

```bash
curl -I -X PROPFIND https://your-synology:PORT/ \
  -H "Origin: https://app.example.com" \
  -u 'user:password'
```

You should see headers like these in the response:

```
access-control-allow-origin: https://app.example.com
access-control-allow-credentials: true
```

---

**P.S. If anyone from Synology sees this: could you help prioritize better CORS support for WebDAV? So users won't need to read this and tweak. Thank you! :)**

