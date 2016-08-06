---
title: "Research Papers: Missing massive subhalos in simulations?"
layout: post
comments: true
tags:
- Physics
- Research Papers
date: "Thursday, August 4, 2016"
excerpt:
og_image: /images/research_papers/munari2016.png
cover: /images/research_papers/munari2016.png
---

> I have a bad habit of keeping lots of interesting research papers open in a long line of tabs in my browser. I am loath to close any of them, but the sight of it is not good for my well being every time I want to browse the internet. To alleviate my suffering, from now on I endeavour to read at least one each weekday, and blog a brief summary. These summaries do not represent an endorsement of the research contained in the chosen paper, and the choice is arbitrary based on what I find interesting on a given day. Any of the content is liable to misinterpretation or misrepresentation: if you want to know exactly what the authors said, go check out the paper and make your own mind up.

### NUMERICAL SIMULATIONS CHALLENGED ON THE PREDICTION OF MASSIVE SUBHALO ABUNDANCE IN GALAXY CLUSTERS: THE CASE OF ABELL 2142

To kick things off, here's a paper on dark matter subhalos. [Munari et al. (2016)](http://arxiv.org/abs/1607.01023v1) look at Abell 2142, a local cluster (z~0.09), $M_{200} \approx 1.25 \times 10^{15} M_{\odot}$. They use the internal kinematics of the galaxies as a proxy for the masses of the host dark matter subhalos (as opposed to strong lensing used in a similar study by Grillo et al. 2015). By comparing the subhalos masses with simulations (they focus on semi-analytic models, with prescriptions for treating orphan galaxies$^1$) they find that the simulated halos have less massive subhalos (at $\gte 7$ sigma significance level). This can't be reconciled by introducing baryonic physics in to the N-body sims either. Their succinct, yet damning, conclusion:

> *"Our analysis indicates that current numerical simulations predict a significant smaller amount of massive (circular
velocity above 200 km s-1 ) subhalos. This result is robust, as it holds even when we compare the predictions of simulations
and the direct measurements of velocity values of cluster members, without addressing incompleteness issues. When
accounting for the latter, the actual number of observed galaxies becomes larger, making the discrepancy even more
significant. These results support the findings of a recent strong lensing study of the Hubble Frontier Fields galaxy cluster
MACS J0416 at z=0.4 (Grillo et al. 2015), suggesting that this discrepancy, which is already present in DM-only
simulations, is not alleviated by the inclusion of baryonic physics."*


The plot below shows a histogram of the circular velocity of galaxies in Abel 2142 (bars) and simulations (points). Higher resolution simulations show similar results, suggesting resolution doesn't play a part in the discrepancy.

![Munari 2016](/images/research_papers/munari2016.png)


1. *Orphan galaxies are galaxies whose host extended subhalos have been stripped away, leaving just the compact baryonic core. They're difficult to track in N-body and hydrodynamic simulations, as they don't have them or are resolution limited, respectively.*
