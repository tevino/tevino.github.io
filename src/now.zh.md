---
layout: page
title: ⏳ 近况
lang: zh
slug: now
permalink: /zh/now/
redirect_from: /zh/now
show_collection_feed: now
description: 这是一个“近况页“，我在这里写下我会告诉一年未见的朋友的东西。
---

{%- assign current_lang = page.lang | default: site.default_lang -%}
{% assign now = site.now | where: "lang", current_lang | sort: "date" | reverse | first %}

<p class="post-meta">
<a href="{{ now.url }}">
<time class="dt-published" datetime="{{ page.date | date_to_xmlschema }}" itemprop="datePublished">
{{ now.date | date: site.date_format }}
</time>
</a>

{%- if now.machine_translated -%}
 {% include translation-warning.html -%}
{%- endif -%}
</p>

{{ now.content }}


## 归档

{% assign nows = site.now | where: "lang", current_lang | sort: "date" | reverse %}
{% for n in nows %}
{% if forloop.first == false %}
- [{{ n.date | date: site.date_format }}]({{ n.url }})
{% endif %}
{% endfor %}
