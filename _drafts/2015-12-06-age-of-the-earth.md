---
title: "Lord Kelvin and the age of the earth"
layout: post
comments: true
date: "Sunday, December 6, 2015"
tags:
- History
- Physics
excerpt: A look back at one of the great scientific controversies; Lord Kelvin's thermal timescale for the age of the Sun and the Earth.
---

The story of how scientists discovered the age of the earth is a remarkable one. At the beginning of the nineteenth century many still believed that the earth had been around forever, but by the early twentieth century the definitive source of the sun's heat had been discovered, and evidence from fields as diverse as geology and biology had been united. Perhaps what makes the story even more fascinating are the egos and personalities that shaped it, and none more so than that of William Thomson, aka Lord Kelvin.

Lord Kelvin was possibly the most eminent scientist of his time, famous today for the temperature scale that bears his name. But it was his work on thermodynamics that led him to ponder the question of the age of the earth. He saw an opportunity to apply the recently formulated laws of thermodynamics to the problem, in particular the first law, which states:

>  The total energy of an isolated system is constant; energy can be transformed from one form to another, but cannot be created or destroyed

This is the principle of conservation of energy.

Kelvin sought to apply this principle to calculate the age of the Sun; he held the view that the Earth must have been formed after the Sun, and so by limiting the age of the Sun he could imply upper limits on the age of the Earth.

The Sun shines, and pretty brightly at that, so in assuming the principle of conservation of energy we imply that the Sun must have a source for this radiated energy. Kelvin's theory for the source of this energy was *gravitational contraction*; when a body contracts under its own gravity it releases energy, and according to Kelvin it was this energy that powered the Sun.

We can calculate how much energy the Sun could possibly radiate if it collapsed from its current state with a little school level math and some Newtonian Mechanics.

**Warning:** If you are allergic to Maths, feel free to skip the next bit. You don't need it to follow the story, but I'd certainly recommend running through it if you can; it's a beautiful, if flawed, argument!

We first define the [gravitational potential energy](https://en.wikipedia.org/wiki/Potential_energy#Gravitational_potential_energy), $\Omega$, from Newtonian mechanics, as

<center>
$$\Omega = - \frac{Gm_{1}m_{2}}{r}$$
</center>

where $G$ is the gravitational constant, and $m_{1}$ and $m_{2}$ are two masses whose centre's of gravity are separated by a distance $r$.

To apply this to the Sun, and calculate its total gravitational potential energy, we first model it as a series of concentric shells, each of radius $dr$.

<img src="/../images/concentric.jpg" title="center" alt="center" style="display: block; margin: auto;" />
<center><i>Concentric shells at radius $r$, width $dr$.</i></center>

In the above definition, for a single shell at radius $r$, $m_{1}$ is the mass of the star within radius $r$, and $m_{2}$ is the mass of the shell itself. We then integrate between 0 and $R$, the radius of the Sun, to add up the contributions from all of the shells, giving the total gravitational potential energy of the entire star.

<center>
$$\Omega = -G \int_{0}^{R} \frac{m(r) 4 \pi r^{2} \rho}{r} dr$$
</center>

Here, $m(r)$ is the mass within radius $r$, and $4 \pi r^{2} \rho dr$ is the mass of the shell. We are assuming that the Sun has uniform density, which is not the case but sufficient for such a back of the envelope calculation; Kelvin made the very same assumption when making his argument.

Now, rewrite $m(r)$ in terms of $r$ and $\rho$ to give

<center>
$$\Omega = -G \int_{0}^{R} \frac{4 \pi r^{3} 4 \pi r^{2} \rho}{3r} dr$$
</center>

which, when integrated, simplifies to,

<center>
$$\Omega = -\frac{16}{15} G \pi^{2} \rho^{2} R^{5}$$
</center>

This can be rewritten in terms of the mass of the Sun, $M = \frac{4}{3} \pi r^{3} \rho$, as

<center>
$$\Omega = -\frac{3M^{2}G}{5R}$$
</center>

So, we now have a value for the total gravitational potential energy of our Sun. But before using this to calculate its age, we need to invoke a new theorem. Kelvin's argument relies on the fact that the Sun is radiating energy that comes from gravtitational contraction. The form in which this energy arises within the stars is thermal, through heating. The conversion of gravitational potential energy to thermal energy is not 1:1, but is in fact related by the *Virial theorem*, which states that the total gravitational potential energy of a body, $\Omega$, is equal to minus two times the internal *thermal* energy of the body,

<center>
$$\Omega = -2U$$
</center>

So, only half of the total gravitational potential energy can be converted to thermal energy. In our case, the total thermal energy within the sun is then,

<center>
$$U = -\frac{3M^{2}G}{10R}$$
</center>

We can now use this to calculate the age of the Sun! Given the luminosity of the Sun today ($L = 3.846 \times 10^{26}$ Watts), and assuming that this has stayed constant throughout the Sun's life, the age can be given by the ratio of the total thermal energy against the rate of energy loss. Sticking everything in, we get

<center>
$$\frac{U}{L} = t_{eff} \approx 8 900 000 \ \mathrm{years}$$
</center>

The minus sign in the above eqaution is a curious addition, but is important to understand why bodies appear to get hotter as they contract and lose energy.

His first assertion, that the Sun has not existed forever, seems obvious now, but it was not widely accepted at the time.









;
