---
layout: page
title: Christopher Lovell
---

<a href="/assets/profile.jpg" data-lightbox="profile.jpg" data-title="Moi">
  <img class="small img-circle" src="/assets/profile.jpg" title="Moi">
</a>

I'm Christopher Lovell, a doctoral student in Astronomy & Astrophysics at the University of Sussex. I currently live in London.

<br>{% include page_divider.html %}
<h2 style="text-align:center">Research</h2>

My research is about understanding how galaxies form and evolve. I do this using simulations, typically of a patch of the universe containing many thousands of galaxies. Combining the data from these simulations with observations of distant galaxies in the early universe helps us understand how these beautiful, evocative objects are born.

I'm also interested in how techniques from the growing field of Data Science, such as Machine Learning, can be used in Astronomy to expose relationships and patterns otherwise obscured using traditional techniques.

<br>{% include page_divider.html %}
<h2 style="text-align:center">Writing</h2>

Additional to this blog I also write for <a href="http://astrobites.org/" target="blank">Astrobites</a>, where postgraduates in Astronomy and Astrophysics write about the latest research papers in a more accessible format for undergraduates or the public in general. You can read my posts <a href="http://astrobites.com/author/clovell/" target="blank">here</a>.

<br>{% include page_divider.html %}
<h2 style="text-align:center" id="about-social">Social</h2>

<center>
{% for social in site.social %}
{% if social.url != null %}
<a href="{{ social.url }}" target="blank"><i class="fa fa-{{ social.icon }}"></i></a>
{% endif %}
{% endfor %}
</center>
<br>

The source code for this site, as well as all of my other public projects, can be found on <a href="https://github.com/christopherlovell" target="blank">GitHub</a>. When I remember to update it you can read my posts on <a href="https://medium.com/@chrislovell" target="blank">Medium</a>.

I'm active on Stack Exchange, mostly in the Astronomy and Stack Overflow sites; the flair below links to my profile. I record my reading habits on <a href="https://www.goodreads.com/christopherlovell" target="blank">Goodreads</a>.

<br><a href="http://stackexchange.com/users/1902550/christopherlovell"><img src="http://stackexchange.com/users/flair/1902550.png" width="208" height="58" alt="profile for christopherlovell on Stack Exchange, a network of free, community-driven Q&amp;A sites" title="profile for christopherlovell on Stack Exchange, a network of free, community-driven Q&amp;A sites" /></a>

<br>{% include page_divider.html %}
<h2 style="text-align:center">Measured Beauty</h2>

<a href="http://measuredbeauty.com/" target="blank">Measured Beauty</a> is an art project started in early 2016 that aims to reveal the abstract beauty hidden in scientific research. Read more <a href="http://measuredbeauty.com/about/" target="blank">here</a>.


<br>{% include page_divider.html %}

This site is built on <a href="https://pages.github.com/" target="source">GitHub pages</a> using <a href="http://jekyllrb.com/" target="source">Jekyll</a>; you can find details on how to recreate it using Cloud9 <a href="{% post_url 2015-01-31-meta-post %}" target="source">here</a>. The design is based on <a href="https://github.com/bencentra/centrarium" target="blank">Centrarium</a>, a template by Ben Centra.
