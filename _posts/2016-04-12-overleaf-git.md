---
layout: post
title: "Using Overleaf with Git"
comments: true
date: "Tuesday, April 12, 2016"
tags:
- Technology
excerpt: Overleaf + git = online Latex induced happiness
---

I've had my eye out for an online Latex editor since first starting to learn the markup language back in my undergraduate. Latex is tricky to serve through the browser since compiling it can actually be quite computationally expensive, and supporting the array of packages must be a bit of a challenge. Recently though there have been a few brave start ups who've created slick interfaces for editing Latex files on the go. I settled on [Overleaf](https://www.overleaf.com/) for it's killer USP - Git integration.

Overleaf isn't the only online latex editor that provides a git interface (see [sharelatex](sharelatex.com)), but it's the only one so far that doesn't tie you to a particular git host, or charge you for the privilege. You can clone a private Overleaf repo to your local computer, and then push to a host such as Github if you wish.

This might seem pedantic, but its perfect for my particular use case. I want to save multiple documents to a single private repository - private repos on Github ain't free, and I like having all my documents in a single place for convenience.

You can do this by cloning each document in to the same folder as an existing private repository. You can then add this cloned directory to the parent repository - **just make sure that you leave a trailing slash after the cloned folder directory when calling `add`**. This way it gets added as a 'fake' submodule, rather than using the actual submodule functionality of git (which can become a little complex, especially for such a simple use case as this). You can then pull or push changes from within the sub repo to the Overleaf origin, and add any changes to the parent repo when you're done. So you save on having separate private repos, and benefit from having all your documents in one place.

Add in Zotero integration, which quickly grabs all your bib references in to a `.bib` file, and this is a really powerful editing environment. I only wish that [some of the feature requests](http://support.overleaf.com/forums/137318-feedback/suggestions/4295795-display-structure-panel) that have been around for over three years would at least *appear* to have had progress made on them, otherwise I'd be throwing my money at it. As it is, I'm holding out just to make sure the project is still being actively developed.
