---
layout: page
title: ⏳ Now
lang: en
slug: now
permalink: /en/now/
redirect_from:
    - /now
    - /now/
    - /en/now
show_collection_feed: now
description: This is a "now page", where I write things that I'd tell a friend I hadn't seen in a year.
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


## Archive

{% assign nows = site.now | where: "lang", current_lang | sort: "date" | reverse %}
{% for n in nows %}
{% if forloop.first == false %}
- [{{ n.date | date: site.date_format }}]({{ n.url }})
{% endif %}
{% endfor %}
