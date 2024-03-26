---
layout: page
title: 电影
lang: zh
slug: movies
permalink: /zh/movies
---


{% for movie in site.movies %}
  <section class="list-box">
    <a href="{{ movie.url }}">
        <img title="{{ movie.title }}" alt="{{ movie.title }}" class="movie-cover" src="/assets/cover/{{ movie.cover }}">
    </a>
  </section>
{% endfor %}