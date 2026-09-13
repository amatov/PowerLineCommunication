# Dependencies

No Matlab toolbox is required. The scripts use only core Matlab
functions (`erfc`, `textread`, `fopen`/`fprintf`, and basic array/plot
operations).

## Missing input data

`H(f)_Zc(f).m` and `twograph25125.m` expect input `.txt` files
(`50bignewY12.5_25_2.txt`, `Zc_FR.txt`, `Zc_MOD.txt`) that are not
included in this repository. `simu.m` writes its output as waveform
files formatted for an external circuit simulator.

## Hardcoded paths

`H(f)_Zc(f).m`, `simu.m`, and `twograph25125.m` contain hardcoded
absolute paths to the original author's machine. Active
(non-commented) instances are flagged with a `% EDIT:` comment directly
above them -- update these before running a script.
