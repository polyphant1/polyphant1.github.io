---
layout: post
title:  "Using GitHub pages to make a blog in less than 3 hours"
comments: true
date:   2015-01-16 12:00:00
categories: github disqus web development
---

As a first blog post I thought I'd start by walking through how I made this site and blog post using the wonderful GitHub pages, Cloud9 and Jekyll, and how you can do the same. All you need is a browser - no local development environment necessary.

First up, you're going to need a github account. Each account gets one github site. Once you're signed up you need to create a new repository with the following naming convention: *username*.github.io, where *username* is your github username. The naming convention tells GitHub that you want to use the repository as a website. This repository will eventually contain all the code needed for your site, and any changes within the repository will immediately be visible on the site.

At this point many guides will lead you away down the local ruby installation road, with all of its OS dependent intricacies and version headaches. If the operations details bore you, check out **Cloud9**. It gives you access to a fully featured development environment in your browser, all hooked up to a virtual machine in the background with everything you need pre-installed. It's almost *too* easy.

Sign in to Cloud9, then link to your GitHub account; doing this at the start is the least painful way of getting the two talking to each other. Once they're linked, a list of your GitHub repositories should appear on your Cloud9 dashboard. Select the one you created earlier and click the 'CLONE TO EDIT' button. You should now be presented with the Cloud9 IDE.




