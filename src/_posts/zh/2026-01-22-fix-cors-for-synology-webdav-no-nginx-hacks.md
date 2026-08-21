---
layout: post
category: lab
title: 修复群晖 WebDAV 的 CORS 问题，不改 Nginx
lang: zh
date: 2026-01-22
slug: fix-cors-for-synology-webdav-no-nginx-hacks
machine_translated: true
---

如何解决使用群晖 WebDAV 服务器时浏览器应用遇到的 CORS 超时问题。这个方案用 HAProxy 来可靠地处理 CORS 预检请求，避免 Nginx 配置文件被意外覆盖的痛苦。

**前提条件**：SSH 访问权限、已安装 Docker 或 HAProxy。

**解决方案**：HAProxy 3.2 在请求到达 WebDAV 后端之前拦截 OPTIONS 请求

---

群晖自带的 WebDAV 服务器和原生客户端配合得很好，但和浏览器应用一起用就会出问题，因为 CORS 预检（`OPTIONS`）请求会超时，返回 `504` 错误。

这是因为 WebDAV 后端没有正确处理浏览器的预检请求。

## 现有的解决方案

### Nginx 临时修改

一个常见的办法是修改 Nginx 配置文件来绕过问题。但问题在于？这些文件是 DSM 管理的，在你改设置、重启、更新 DSM，有时甚至只是重启一下系统后，都可能被覆盖掉。

最惨的是，你的改动了在没有任何通知的情况下就消失了。突然之间 WebDAV 集成就不工作了，你得拼命回忆几个月前到底改了什么。恢复这些配置既耗时又不可靠。和这个机制对着干既不明智也不可持续。

### 搭建专门的 WebDAV 服务器

搭建像 Nextcloud 或 Apache 这样的专用 WebDAV 服务器确实可以，但如果只是为了解决 CORS 问题，这就有点杀鸡用牛刀了。

你可能不想为了这么点事就搭建和维护另一个带认证的完整 WebDAV 服务器。

### 内置反向代理

虽然群晖的反向代理可以添加自定义响应头，但它不能终止或短路 CORS 预检请求。`OPTIONS` 请求还是会转发到后端，然后卡在那里直到超时。

## 解决方案

在内置 WebDAV 前面加个专门的反向代理来处理 CORS，这已经很接近完美了，但如果你不想为反向代理单独配置 SSL 证书，继续往下看。

```
浏览器 / 网页应用 (HTTPS)
   ↓
群晖反向代理 (TLS 终止)
   ↓
HAProxy (Docker，仅 HTTP，处理 CORS)
   ↓
群晖 WebDAV 服务器 (127.0.0.1:5005)
```

我知道为了这么个简单需求搞这么多看起来有点夸张，但它在维护方面赢了：你只需要配置一次，然后就不用管了，即使 DSM 更新它也能继续工作。

HAProxy 配置：

```
frontend webdav_in
    bind *:指定端口号
    mode http

   acl is_preflight method OPTIONS

   # 处理 CORS 预检
   http-request return status 204 hdr Access-Control-Allow-Origin https://app.example.com hdr Access-Control-Allow-Methods "GET, PUT, POST, DELETE, PROPFIND, OPTIONS" hdr Access-Control-Allow-Headers "Authorization, Content-Type, Depth" hdr Access-Control-Allow-Credentials true hdr Access-Control-Max-Age 86400 if is_preflight

   # 总是在实际响应中添加 CORS 头
   http-response set-header Access-Control-Allow-Origin https://app.example.com
   http-response set-header Access-Control-Allow-Credentials true

   default_backend webdav_backend

backend webdav_backend
    mode http
    server webdav 127.0.0.1:5005
```

把这个保存为 `haproxy.cfg`，然后用 Docker 运行 HAProxy：

```bash
docker run -d --name haproxy-webdav --network host -v /path/to/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro haproxy:3.2
```

记得用 `--network host`，这样 HAProxy 才能访问到 localhost 上的 WebDAV 服务器，或者根据你的环境修改 `127.0.0.1:5005`。

## 测试 CORS

用简单的 curl 命令验证 CORS 是否工作：

```bash
curl -I -X PROPFIND https://your-synology:PORT/ \
  -H "Origin: https://app.example.com" \
  -u 'user:password'
```

你应该能在响应中看到这样的头：

```
access-control-allow-origin: https://app.example.com
access-control-allow-credentials: true
```

---

**P.S. 如果群晖的人看到这个：能否请你帮忙提高一下 WebDAV 的 CORS 支持优先级？这样用户就不用看这篇文章来折腾了。谢谢！:)**
