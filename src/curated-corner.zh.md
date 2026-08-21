---
layout: page
title: 🌱 推荐区
lang: zh
slug: curated-corner
permalink: /zh/curated-corner/
redirect_from: /zh/curated-corner
date: 2024-08-21
show_collection_feed: curated_corner
machine_translated: true
description: 下周不会过时的推荐资源 🌱。
---

{% assign current_lang = page.lang | default: site.default_lang -%}
{%- assign recent_resources = site.curated_corner | where: "lang", current_lang | sort: "date" | reverse -%}

## 🕒 最近更新

{% for p in recent_resources limit: 5 %}
- [{{ p.title }}]({{ p.url }})
{% endfor %}

---

<details>
<summary>注意：我与以下任何内容<strong>均无任何关联</strong>。</summary>

<p>请自行判断，如发现任何不当之处，欢迎随时告诉我。</p>

</details>


{%- assign sorted_categories = "👾 数字,👂 听,👁️ 看,🧠 体验,🗂️ 其他" | split: "," -%}

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
