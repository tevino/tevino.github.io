---
layout: project
title: Voice Inbox
lang: en
slug: voice-inbox
permalink: /en/projects/voice-inbox/
redirect_from:
    - /projects/voice-inbox
    - /projects/voice-inbox/
date: 2023-08-27
website: https://voiceinbox.com
is_index: true
app_store_icon: https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/ae/a5/fa/aea5fafa-a62a-88ae-75df-7876b6a6a20e/AppIcon-0-1x_U007ephone-0-85-220-0.png/512x512bb.jpg
---

Voice Inbox is your go-to for jotting down your thoughts anytime, anywhere. It turns your spoken words into accurate text and adds them to your journal.


It's not yet another note-taking or journaling app that craves your data. It's an app that helps you do them more easily on other apps (like Obsidian), while preserving your ownership of your data.


{%- assign current_lang = page.lang | default: site.default_lang -%}

{% assign posts = site.projects | where_exp: "post", "post.is_index != true" | where: "lang", current_lang | sort: "date" | reverse %}
{% for p in posts %}
{% assign project_name = p.path | split: "/" | slice: 1 | first %}
{% if project_name == "voice-inbox" %}
- [{{ p.title }}]({{ p.url }})
{% endif %}
{% endfor %}
