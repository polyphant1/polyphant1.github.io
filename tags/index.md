---
layout: page
permalink: /tags/
title: Tags
---

{% capture tags %}{% for tag in site.tags %}{{ tag[0] }}|{% endfor %}{% endcapture %}
{% assign sortedtags = tags | split:'|' | sort %}

{% for tag in sortedtags %}
<a href="#{{ tag }}">{{ tag }}</a>{{ tag.description }}
{% endfor %}

{% include page_divider.html %}


{% for tag in sortedtags %}
<!--div id="{{ tag }}"-->
<h3><a href="{{ tag }}" name="{{ tag }}">{{ tag }}</a></h3>
<!--/div-->
<ul class="list-unstyled">
{% for post in site.tags[tag] %}
<li><a href="{{ post.url }}">{{ post.title }}</a></li>
{% endfor %}
</ul>
{% endfor %}
