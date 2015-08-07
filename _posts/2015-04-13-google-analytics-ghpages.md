---
layout: post
title: "Adding Google Analytics to GitHub Pages"
comments: true
date: "Monday, April 13, 2015"
categories: github_pages
featured_image: /images/hdf.gif
---

Quick post today on how to add Google Analytics tracking to your GitHub pages site. First, head over to [Google Analytics](http://www.google.com/analytics/) and sign up. After entering your details and green lighting the T&C's you'll be directed to an admin page. This will give you the tracking code that you need to add to each page of your site. Mine, anonymised, is below:

```html
<script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
    ga('create', 'UA-########-#', 'auto');
    ga('send', 'pageview');
</script>
```
<br>

Jekyll makes adding this easy; create a HTML file in your *\_includes* folder containing this code. I named mine google\_analytics.html. Then add the following to your default layout, `_layouts/default.html`: 

```
{% raw %}{% include google_analytics.html %}{% endraw %}
```

Within a few hours Google Analytics should pick up the change, and you'll be capturing session times, demographics, and other useful information on visitors to your site. 

Thanks to [Joshua Lande](http://joshualande.com/jekyll-github-pages-poole/) for his original post.