---
layout: page
title: ✨ 工坊
lang: zh
slug: projects
permalink: /zh/projects/
redirect_from:
  - /zh/projects
  - /zh/creation
date: 2023-08-27
description: 这些我为自己打磨的东西（没准你也能用）。
machine_translated: false
---

{%- assign current_lang = page.lang | default: site.default_lang -%}

<div class="projects-grid">
{% assign projects = site.projects | where: "lang", current_lang | where: "is_index", true | sort: "date" | reverse %}
{% for p in projects %}
<div class="project-card">
<a href="{{ p.url }}">
  {% if p.app_store_icon %}
  <div class="project-image">
    <img class="project-icon-apple icon--small" src="{{ p.app_store_icon }}" alt="{{ p.title }}">
  </div>
  {% else %}
  {% if p.icon %}
  <div class="project-image">
    <img class="project-icon icon--small" src="{{ p.icon }}" alt="{{ p.title }}">
  </div>
  {% endif %}
  {% endif %}
  <div class="project-title">{{ p.title }}</div>
  {% if p.description %}
  <div class="project-description">
    {{ p.description }}
  </div>
  {% endif %}
</a>
</div>
{% endfor %}
</div>
