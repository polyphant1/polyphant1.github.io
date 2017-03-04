---
layout: post
title: "Slidify"
comments: true
date: "Thursday, February 18, 2016"
tags:
- Technology
excerpt: Coding up presentations using R's slidify package
---

A couple of days ago I got to do some outreach in a pub, and earnt a free pint for my efforts. PubhD is a neat outreach project set up by grad students at the University of Sussex that takes PhD researchers, puts them in front of lager touting punters, and gets them to explain their research. The idea is to make bleeding edge research more accessible to the public, bringing it to a friendlier, more relaxed setting. The whole atmosphere was warm and convivial, and there was an opportunity for audience Q&A which brought up some great questions.

When prepping for the presentation I had a bit of dilemma though; I'm a Linux user, and Libre office presentations don't tend to play nice with Mac or Windows, which I expected the organisers to have. To avoid this compatibility nightmare I decided to try something I discovered a few months back. [Slidify](http://slidify.org/) lets you create slick presentations using just R markdown. They can be exported to PDF or HTML, the latter allowing you to include interactive elements such as embedded videos or quizzes.

The source code for my presentation is shown below.

{% gist ad535e31239c7159bec4 %}
