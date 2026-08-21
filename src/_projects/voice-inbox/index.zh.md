---
layout: project
title: 语音收件箱（Voice Inbox）
lang: zh
slug: voice-inbox
permalink: /zh/projects/voice-inbox/
redirect_from: /zh/projects/voice-inbox
date: 2023-08-27
website: https://voiceinbox.com
is_index: true
app_store_icon: https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/ae/a5/fa/aea5fafa-a62a-88ae-75df-7876b6a6a20e/AppIcon-0-1x_U007ephone-0-85-220-0.png/512x512bb.jpg
---

Voice Inbox 是您随时随地记录想法的得力助手。它将您的语音转化为准确的文字，并将其添加到您的日记中。


它不是又一个觊觎你数据的笔记或日记应用。它帮助您在其他应用（如 Obsidian）上更轻松地进行这些操作，同时让您保留对自己数据的所有权。


{%- assign current_lang = page.lang | default: site.default_lang -%}

{% assign posts = site.projects | where_exp: "post", "post.is_index != true" | where: "lang", current_lang | sort: "date" | reverse %}
{% for p in posts %}
{% assign project_name = p.path | split: "/" | slice: 1 | first %}
{% if project_name == "voice-inbox" %}
- [{{ p.title }}]({{ p.url }})
{% endif %}
{% endfor %}
