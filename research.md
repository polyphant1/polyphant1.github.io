---
layout: page
permalink: /research/
title: Research
---

Below are some brief summaries of research areas I am currently working in, or have recently worked on.

<ul>
<li><a href="#Galaxy Protoclusters">Galaxy Protoclusters</a></li>
<li><a href="#Numerical Simulations">Numerical Simulations</a></li>
<li><a href="#Spectral Energy Distribution Modelling">Spectral Energy Distribution Modelling</a></li>
<li><a href="#Machine Learning & Astronomy">Machine Learning & Astronomy</a></li>
<!-- <li><a href="#Extreme Value Statistics">Extreme Value Statistics</a></li> -->
</ul>

{% include page_divider.html %}

<!-- <h2><a href="High Redshift Galaxy Evolution" name="High Redshift Galaxy Evolution">High Redshift Galaxy Evolution</a></h2> -->

<h2><a name="Galaxy Protoclusters">Galaxy Protoclusters</a></h2>

Galaxy clusters are the largest collapsed objects in the universe, comprising of a highly evolved galaxy population embedded in a hot, rarefied InterCluster Medium (ICM). Their pre-collapse progenitors, known as galaxy *protoclusters*, are host to some of the most extreme objects (in terms of mass, star formation rate and nuclear activity) at these early times.
Protoclusters are of significant interest for understanding the environmental dependence of galaxy evolution at early times, as well as the build-up, enrichment and heating of the ICM.

<img class="small" src="/images/dm_example.png" title="Simulated Protocluster">
<p style="text-align:center; font-style:italic">The dark matter distribution in a Protocluster at $z \sim 5$ simulated with the EAGLE code</p>
<!-- <img class="small" src="/images/gas_test_zoom_1_r_1.gif" title="Simulated Protocluster">
<p style="text-align:center; font-style:italic">Gas distribution in a Protocluster at $z \sim 5$ simulated with the EAGLE code</p> -->

Protoclusters do not yet host a hot, rarefied, X-ray emitting intercluster medium, and so are primarily identified through 3D galaxy overdensities. In a recently accepted paper (<a href="http://adsabs.harvard.edu/cgi-bin/bib_query?arXiv:1710.02148" target="blank">Lovell et al. 2018</a>) I studied in detail the relationship between galaxy overdensity and the presence and descendant mass of protoclusters in the <a href="http://galformod.mpa-garching.mpg.de/public/LGalaxies/" target="blank">L-galaxies</a> semi-analytic model.
The motivation for this work was to explore the systematic issues that have the greatest impact on protocluster identification; protoclusters are typically identified through surface overdensities of galaxies seen in narrow band photometric surveys, which are then compared to simulations in order to evaluate their protocluster probability and estimate their descendant mass.
I developed a more rigorous method for generating these statistics that takes in to account the completeness and purity of the protocluster galaxy population, the galaxy distribution shape, redshift space distortions and redshift uncertainties, as well as the coincidence of AGN with protoclusters.

<h2><a name="Numerical Simulations">Numerical Simulations</a></h2>

Cosmological hydrodynamic simulations have, in recent years, become capable of matching key distribution functions in the local universe, such as those of stellar mass and star formation rate. However, high resolution, large volume simulations  have rarely been tested in the high redshift ($z > 5$) regime, particularly in the most overdense environments.
Creating models that fit both high redshift and low redshift observables self consistently is a significant challenge, but key to understanding the properties of galaxies in the first billion years of the universe's history, and how this affects their latter evolution.
Such models are also necessary to make detailed predictions, and plan observations, for upcoming space based instruments, such as JWST, WFIRST and Euclid.

<img class="small" src="/images/gas_test_zoom_1_r_1_p_245.png" title="Simulated Protocluster (Gas)">
<p style="text-align:center; font-style:italic">The distribution of gas in a Protocluster at $z \sim 5$, simulated with the EAGLE code</p>

I have worked extensively on <a href="http://icc.dur.ac.uk/Eagle/" target="blank">EAGLE</a>, a state-of-the-art cosmological hydrodynamic simulation that has been tuned to a small number of distribution functions in the local universe; results at high redshifts represent predictions of the model.
I have led a new simulation project during this period, First Light And Reionisation Epoch Simulations (FLARES), a new suite of 'zoom' simulations, using a modified version of the EAGLE physics code, of regions selected at high redshift.

<h2><a name="Spectral Energy Distribution Modelling">Spectral Energy Distribution Modelling</a></h2>

<!-- A significant part of my doctoral studies has involved SED modelling of galaxies from hydrodynamic simulations in order to perform a close comparison with observations. -->
Since hydrodynamic simulations do not resolve individual stars or HII regions a number of subgrid models and assumptions must be employed to accurately determine the galaxy SED, which can have a significant impact on the predicted emission.
One example is the choice of stellar population synthesis (SPS) model, which links the initial mass, age and metallicity of a star particle in the simulation ($M_{*} \sim 10^{6} \, M_{\odot}$) to its intrinsic SED.
In recent years a number of advanced SPS models have been developed, including the effects of binary interactions, post-AGB stars and nebular emission.
We demonstrated in <a href="https://arxiv.org/abs/1512.032142" target="blank">Wilkins et al. 2016</a> that the production efficiency of ionising radiation can vary by up to a factor of 4 due to the choice of SPS model, and it can also have a significant effect on predicted magnitudes in the rest-frame UV for high-$z$ objects.

<img class="vsmall" src="/images/spectra_example_z8.png" title="Spectra Example">
<p style="text-align:center; font-style:italic">Median SED of galaxies in the EAGLE simulation at $z = 8$, both intrinsic and dust attenuated, with JWST NIRCAM filters overlayed</p>

The dust contribution at high redshift is also highly uncertain, but is key for predicting realistic observed spectra. Dust modelling can vary significantly in sophistication, from simple screen models linked to the mass and metallicity of star forming gas, to full radiative transfer solutions taking account of the spatial distribution of dust and the orientation of the observer.
Nebular emission is another important component in the SED of high-$z$ galaxies. It is obviously necessary for predicting the presence and strength of individual emission lines, but such lines can also have a significant impact on broad band magnitudes.

I have recently been performing detailed modelling of the spectral energy distributions (SEDs) of galaxies in hydrodynamic simulations in order to carry out close comparisons with HST observations of the rest-frame UV luminosity, and make predictions for JWST.

<h2><a name="Machine Learning & Astronomy">Machine Learning & Astronomy</a></h2>

I am keenly interested in the interface between simulations and machine learning methods. Whilst numerical models obviously do not represent the true universe, they do model the complex non-linear spatial and time dependent interactions of populations of objects. This can be important for accurately predicting intrinsic properties, something that traditional spectral energy distribution (SED) fitting techniques do not take into account. Training machines to learn these relationships, then applying these to observations, can provide unique predictions that complement existing techniques.

I recently worked with Prof. Viviana Acquaviva at City University New York applying this method to the prediction of Star Formation Histories (SFH) in the SDSS catalogue. We trained a Convolutional Neural Network to learn the relationship between spectra and SFH in the EAGLE and Illustris simulations.

<!-- <h2><a name="Extreme Value Statistics">Extreme Value Statistics</a></h2>

During my Masters I worked with <a href="https://telescoper.wordpress.com/" target="blank">Prof. Peter Coles</a> and <a href="http://www.jb.man.ac.uk/~harrison/" target="blank">Dr. Ian Harrison</a> on <a href="https://www.ncl.ucar.edu/Applications/extreme_value.shtml" target="blank">Extreme Value Statistics</a>, a technique for predicting the most extreme objects in a distribution. I studied the EVS predictions for the halo masses of galaxy clusters and compared to numerical simulation predictions, as well as EVS predictions for the largest voids in the universe, utilising excursion set theory.

<img class="vsmall" src="/images/masters_project_ss.png" title="WebbUK">
<p style="text-align:center; font-style:italic">The dark matter distribution in a small volume containing a massive cluster, simulated using the <a href="http://enzo-project.org/" target="blank">ENZO</a> code</p> -->
