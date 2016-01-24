---
layout: post
title:  "Single Node Performance Optimisation"
comments: true
date: "Sunday, January 24, 2016"
tags:
- Physics
- Technology
excerpt: "Summary of a few days spent in Swansea attending a course on optimising code for supercomputers"
---

This week I spent a couple of days in Swansea attending a course titled *Single Node Performance Optimisation*, the name of which may already be sending you fleeing for your bookmark bar. It was essentially a break down of how to be a better programmer for supercomputer applications, and turned out to be one of the most worthwhile courses I've been on since starting my Ph.D. The course broke down as follows:

- **Node Architecture** An overview of how nodes are structured, including shared memory, different levels of cache, and the processor architecture itself.
- **Profiling** Guide to a range of profiling techniques, for isolating bad performing code
- **Optimising with the Compiler** Using optimisation flags and compiler information to gain further performance
- **Vectorisation** Exploiting the vector arrangement of modern processors to carry out multiple concurrent operations
- **Optimising for the memory hierarchy** Using the different levels of Cache in a given node better
- **Optimising multi-threaded code** How to take full advantage of OpenMP and MPI both within individual and across multiple nodes

The course was run by <a href="https://www.archer.ac.uk/about-archer/" target="blank">Archer</a>, the latest UK National Supercomputing Service. If you're an academic doing any kind of HPC work in the UK, these guys are worth talking to; they do a number of courses from beginner to advanced, and can provide access to their dedicated supercomputing resources, though I'm not sure what it'll cost you.
