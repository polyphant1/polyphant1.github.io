---
layout: page
permalink: /tags/
title: Tags
---

{% capture tags %}{% for tag in site.tags %}{{ tag[0] }}|{% endfor %}{% endcapture %}
{% assign sortedtags = tags | split:'|' | sort %}

{% for tag in sortedtags %}
<a name="{{ tag }}"></a>
<h2>{{ tag }}</h2>
<ul class="list-unstyled">
{% for post in site.tags[tag] %}
<li><a href="{{ post.url }}">{{ post.title }}</a></li>
{% endfor %}
</ul>
{% endfor %}
