---
layout: page
permalink: /research/
title: Research
---

Below are some brief summaries of research areas I am currently working in, or have recently worked on. If you're interested in any of these topics and would like to chat further, please <a href="/contact/">get in touch!</a>

<ul>
<li><a href="#SMGs">Sub-millimetre galaxies in simulations</a></li>
<li><a href="#FLARES">First Light And Reionisation Epoch Simulations (FLARES)</a></li>
<li><a href="#Machine Learning & Astronomy">Machine Learning & Astronomy</a></li>
<li><a href="#Galaxy Protoclusters">Galaxy Protoclusters</a></li>
</ul>

{% include page_divider.html %}

<h2><a name="SMGs">Sub-millimetre galaxies in simulations</a></h2>
Sub-millimetre galaxies, or SMGs, are an enigmatic population of galaxies in the early universe that are incredibly bright in sub-millimetre wavelengths, forming huge numbers of stars.
It has been very difficult to model these objects in cosmological simulations whilst still self-consistently matching other observational constraints, such as the galaxy stellar mass function, at $z = 0$, and many authors have proposed alternative modelling approaches, such as a varibale IMF, to explain them.
For a concise summary of the issues faced modelling these objects, see <a href="https://twitter.com/desikanarayanan/status/1277940211285180416" target="_blank">this thread from Desika!</a>

<img class="small" src="/images/simba_render.png" title="SIMBA SMG render">
<p style="text-align:center; font-style:italic">An example SMG showing the gas, stellar and dust distribution, as well as the resolved and integrated $S_{850}$ emission.</p>

Recently (<a href="https://arxiv.org/abs/2006.15156">Lovell et al. 2020; arXiv:2006.15156</a>), we used the <a href="https://arxiv.org/abs/1901.10203">SIMBA</a> simulation combined with the radiative transfer package <a href="https://arxiv.org/abs/2006.10757">Powderday</a> to model the sub-mm emission, and found unprecedented agreement with observationally inferred integrated number counts from single-dish instruments.
We created a lightcone, allowing us to explore the effects of far-field blending, and found minimal impact on the shape or normalisation of the number counts.

<img class="small" src="/images/square_counts.png" title="SIMBA 850 micron counts">
<p style="text-align:center; font-style:italic">$S_{850}$ counts from the SIMBA simulation, compared with observational constraints, as well as predictions from the EAGLE model.</p>


We're currently working on studying the intrinsic properties of these galaxies in the simulation, as well as their progenitors and descendants. 
And we are running high resolution zoom simulations of individual objects in order to study their resolved continuum emission, and make predictions for ALMA.
Stay tuned!

<h2><a name="FLARES">First Light And Reionisation Epoch Simulations (FLARES)</a></h2>

Cosmological hydrodynamic simulations have, in recent years, become capable of matching key distribution functions in the local universe, such as those of stellar mass and star formation rate. 
However, high resolution, large volume simulations  have rarely been tested in the high redshift ($z > 5$) regime, particularly in the most overdense environments.
Creating models that fit both high redshift and low redshift observables self consistently is a significant challenge, but key to understanding the properties of galaxies in the first billion years of the universe's history, and how this affects their latter evolution.
Such models are also necessary to make detailed predictions, and plan observations, for upcoming space based instruments, such as JWST, WFIRST and Euclid.

<img class="small" src="/images/all_components.png" title="FLARES components">
<p style="text-align:center; font-style:italic">The column density of gas, stars and dark matter in the most overdense region in the FLARES sample.</p>

The First Light And Reionisation Epoch Simulations (FLARES) are a suite of 40 'zoom' simulations using a modified version of the <a href="http://icc.dur.ac.uk/Eagle/" target="blank">EAGLE</a> code.
EAGLE is a state-of-the-art cosmological hydrodynamic simulation that has been tuned to a small number of distribution functions in the local universe.
We selected regions at high redshift ($z = 4.67$), with a range of overdensities, from an enormous $(3.2 \, \mathrm{Gpc})^3$ periodic dark matter-only volume, and resimulated these with full hydrodynamics at fiducial EAGLE resolution ($m_{\mathrm{gas}} \sim 10^6 \, \mathrm{M_{\odot} \, yr^{-1}}$).
I led the first release paper (<a href="https://arxiv.org/abs/2004.07283">Lovell et al 2020; arXiv:2004.07283</a>) in which we study the galaxy stellar mass function, star formation rate function and star-forming sequence predictions.
By weighting them appropriately we combine the regions to produce composite distribution functions, significantly extending the dynamic range compared to periodic simulations at similar resolution.
We can also study the environmental dependence of galaxy formation and evolution during the Epoch of Reionisation (EoR).

<img class="small" src="/images/flares_fom.png" title="FLARES figure of merit">
<p style="text-align:center; font-style:italic">Figure of merit showing the distribution of a number of simulations on a plane of dark matter element resolution against simulated volume. FLARES, whilst explicitly simulating a similar volume to similar resolution simulations, has an 'effective' volume 4 orders of magnitude larger when combining the regions.</p>

For further details please check out our dedicated website, <a href="https://flaresimulations.github.io/">flaresimulations.github.io</a>, where you can find data products and visualisations.

<h2><a name="Machine Learning & Astronomy">Machine Learning & Astronomy</a></h2>

I am keenly interested in the interface between simulations and machine learning methods. Whilst numerical models obviously do not represent the true universe, they do model the complex non-linear spatial and time dependent interactions of populations of objects. This can be important for accurately predicting intrinsic properties, something that traditional spectral energy distribution (SED) fitting techniques do not take into account. Training machines to learn these relationships, then applying these to observations, can provide unique predictions that complement existing techniques.

I recently worked with <a href="https://www.drvivianaacquaviva.com/" target="blank">Prof. Viviana Acquaviva</a> at City University New York applying this method to the prediction of Star Formation Histories (SFH) in the SDSS catalogue. We trained a Convolutional Neural Network to learn the relationship between spectra and SFH in the EAGLE and Illustris simulations. The paper is available <a href="https://arxiv.org/abs/1903.10457" target="blank">here</a>, and below is a talk I gave on this research at the Royal Astronomical Society meeting, <a href="https://ras.ac.uk/events-and-meetings/ras-meetings/machine-learning-and-artificial-intelligence-applied-astronomy" target="blank">"Machine Learning and Artificial Intelligence applied to astronomy"</a> in March 2019 (slides available <a href="https://drive.google.com/file/d/1AoFtiu9alxbwuBQ7Dp9ujX9g8XZmTudq/view" target="blank">here</a>)

<a href="https://www.youtube.com/watch?v=R2MZ5HXZH_A" target="blank"><img class="small" src="/images/RAS2019_talk.jpg" title="RAS 2019 talk"></a>

<!-- <h2><a href="High Redshift Galaxy Evolution" name="High Redshift Galaxy Evolution">High Redshift Galaxy Evolution</a></h2> -->

<h2><a name="Galaxy Protoclusters">Galaxy Protoclusters</a></h2>

Galaxy clusters are the largest collapsed objects in the universe, comprising of a highly evolved galaxy population embedded in a hot, rarefied InterCluster Medium (ICM). Their pre-collapse progenitors, known as galaxy *protoclusters*, are host to some of the most extreme objects (in terms of mass, star formation rate and nuclear activity) at these early times.
Protoclusters are of significant interest for understanding the environmental dependence of galaxy evolution at early times, as well as the build-up, enrichment and heating of the ICM.

<img class="small" src="/images/dm_example.png" title="Simulated Protocluster">
<p style="text-align:center; font-style:italic">The dark matter distribution in a Protocluster at $z \sim 5$ simulated with the EAGLE code</p>
<!-- <img class="small" src="/images/gas_test_zoom_1_r_1.gif" title="Simulated Protocluster">
<p style="text-align:center; font-style:italic">Gas distribution in a Protocluster at $z \sim 5$ simulated with the EAGLE code</p> -->

Protoclusters do not yet host an X-ray emitting ICM, and so are primarily identified through 3D galaxy overdensities. In a recently accepted paper (<a href="http://adsabs.harvard.edu/cgi-bin/bib_query?arXiv:1710.02148" target="blank">Lovell et al. 2018</a>) I studied in detail the relationship between galaxy overdensity and the presence and descendant mass of protoclusters in the <a href="http://galformod.mpa-garching.mpg.de/public/LGalaxies/" target="blank">L-galaxies</a> semi-analytic model.
The motivation for this work was to explore the systematic issues that have the greatest impact on protocluster identification. Surface overdensities of galaxies seen in narrow band photometric surveys are typically compared to simulations in order to evaluate their protocluster probability and estimate their descendant mass.
I developed a more rigorous method for generating these statistics that takes in to account the completeness and purity of the protocluster galaxy population, the galaxy distribution shape, redshift space distortions and redshift uncertainties, as well as the coincidence of AGN with protoclusters.


<!-- <h2><a name="Spectral Energy Distribution Modelling">Spectral Energy Distribution Modelling</a></h2>

Since hydrodynamic simulations do not resolve individual stars or HII regions a number of subgrid models and assumptions must be employed to accurately determine the galaxy SED, which can have a significant impact on the predicted emission.
One example is the choice of stellar population synthesis (SPS) model, which links the initial mass, age and metallicity of a star particle in the simulation ($M_{*} \sim 10^{6} \, M_{\odot}$) to its intrinsic SED.
In recent years a number of advanced SPS models have been developed, including the effects of binary interactions, post-AGB stars and nebular emission.
We demonstrated in <a href="https://arxiv.org/abs/1512.03214" target="blank">Wilkins et al. 2016</a> that the production efficiency of ionising radiation can vary by up to a factor of 4 due to the choice of SPS model, and it can also have a significant effect on predicted magnitudes in the rest-frame UV for high-$z$ objects.

<img class="vsmall" src="/images/spectra_example_z8.png" title="Spectra Example">
<p style="text-align:center; font-style:italic">Median SED of galaxies in the EAGLE simulation at $z = 8$, both intrinsic and dust attenuated, with JWST NIRCAM filters overlayed</p>

The dust contribution at high redshift is also highly uncertain, but is key for predicting realistic observed spectra. Dust modelling can vary significantly in sophistication, from simple screen models linked to the mass and metallicity of star forming gas, to full radiative transfer solutions taking account of the spatial distribution of dust and the orientation of the observer.
Nebular emission is another important component in the SED of high-$z$ galaxies. It is obviously necessary for predicting the presence and strength of individual emission lines, but such lines can also have a significant impact on broad band magnitudes.

I have recently been performing detailed modelling of galaxy SEDs in hydrodynamic simulations in order to carry out close comparisons with HST observations of the rest-frame UV luminosity, and make predictions for JWST. -->

<!-- <h2><a name="Extreme Value Statistics">Extreme Value Statistics</a></h2>

During my Masters I worked with <a href="https://telescoper.wordpress.com/" target="blank">Prof. Peter Coles</a> and <a href="http://www.jb.man.ac.uk/~harrison/" target="blank">Dr. Ian Harrison</a> on <a href="https://www.ncl.ucar.edu/Applications/extreme_value.shtml" target="blank">Extreme Value Statistics</a>, a technique for predicting the most extreme objects in a distribution. I studied the EVS predictions for the halo masses of galaxy clusters and compared to numerical simulation predictions, as well as EVS predictions for the largest voids in the universe, utilising excursion set theory.

<img class="vsmall" src="/images/masters_project_ss.png" title="WebbUK">
<p style="text-align:center; font-style:italic">The dark matter distribution in a small volume containing a massive cluster, simulated using the <a href="http://enzo-project.org/" target="blank">ENZO</a> code</p> -->
