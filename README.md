## Power Line Communication

The Matlab code I wrote in the lab of Pierre-Gérard Fontolliet (Telecommunications Laboratory) at the EPFL.

## Quick start

This repository implements transmission-characteristic and error-
probability modeling for power-line communication channels in Matlab.
See [DEPENDENCIES.md](DEPENDENCIES.md) for the input data files some
scripts expect but which are not included in this repository.

## Repository contents

- `H(f)_Zc(f).m`, `H_Zc.m`, `Aconst.m`, `Aeflexion2.m`,
  `Acalculate2.m`, `Acalculate3.m` -- frequency-response, impedance,
  and reflection-coefficient calculations.
- `twograph25125.m`, `tree.m`, `simu.m` -- transmission-line and
  branched-network propagation simulation.
- `Pe.m`, `GCI.m`, `gauss.m`, `mean_sq.m`, `norma.m` -- error
  probability and Gaussian complementary integral utilities.
- `reports/` -- the COST Action 262 program document (Memorandum of
  Understanding).
- **License:** see [LICENSE](LICENSE) -- research/educational use.

## About

My work on modeling the transmission characteristics of power-line communication channels, a medium that combines the hostile behaviour of a power line with that of a communication channel, for the publication:

Alexandre Matov "Measurements and Modeling of Power Line Channel at High Frequencies" (2001)

https://researchgate.net/publication/256435562_Measurements_and_modelling_of_power_line_channel_at_high_frequencies
