---
layout: page
title: 🌱 Curated Corner
lang: en
slug: curated-corner
permalink: /en/curated-corner/
redirect_from:
    - /en/curated-corner
    - /curated-corner
    - /curated-corner/
date: 2024-08-21
show_collection_feed: curated_corner
description: My go-to good stuff 🌱 that won't be irrelevant next week.
---

{% assign current_lang = page.lang | default: site.default_lang -%}
{%- assign recent_resources = site.curated_corner | where: "lang", current_lang | sort: "date" | reverse -%}

## 🕒 Recent updates

{% for p in recent_resources limit: 5 %}
- [{{ p.title }}]({{ p.url }})
{% endfor %}

---

<details>
<summary>Note: I'm <strong>not affiliated</strong> with any of the following in any way.</summary>

Use your own judgment and feel free to let me know if you find anything inappropriate.

</details>


{%- assign sorted_categories = "👾 Digital,👂 Audio,👁️ Visual,🧠 Experiences,🗂️ Everything else" | split: "," -%}

{%- for category in sorted_categories -%}

<details>
<summary><h2>{{ category }}</h2></summary>

{%- assign categorized_resources = site.curated_corner | where: "lang", current_lang | where: "category", category | sort: "date" | reverse -%}
{%- for p in categorized_resources %}

### [{{ p.title }}]({{ p.url }})

{{ p.content | replace: '<a href="http', '<a rel="nofollow noopener" target="_blank" href="http' }}

{%- endfor -%}

</details>

{%- endfor -%}
