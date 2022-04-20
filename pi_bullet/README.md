# PI BULLET

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

Copyright BULLET 2020

## Purposes

PI extraction codes within the BULLET testbed.
Two algorithms have been implemented: `pi_bullet_walking` and `pi_bullet_walkingComplete`.

### `pi_bullet_walking`

`pi_bullet_walking` extracts following PIs:

- `Peak_load_left`
- `Peak_load_right`
- `RMS_load_left`
- `RMS_load_right`
- `Stance_time_left`
- `Stance_time_right`

using following files:

- `wrench_CrutchLeft.csv`
- `wrench_CrutchRight.csv`
- `gaitEvents.yaml`.

### `pi_bullet_walkingComplete`

`pi_bullet_walkingComplete` extracts the following PIs:

- `Peak_load_left`,
- `Peak_load_right`,
- `RMS_load_left`,
- `RMS_load_right`,
- `Stance_time_left`,
- `Stance_time_right`,
- `Peak_load_shoulders_left`,
- `Peak_load_shoulders_right`,
- `RMS_load_shoulders_left`,
- `RMS_load_shoulders_right`,

from the pre-processed data files:

- `wrench_CrutchLeft.csv`,
- `wrench_CrutchRight.csv`,
- `gaitEvents`,
- `wrench_ShoulderLeft.csv,`
- `wrench_ShoulderRight.csv`.

## Installation

To enable the code under octave, additional packages are needed.

```console
sudo apt-get install liboctave-dev
```

Follow [these recommendations](https://octave.org/doc/v4.2.1/Installing-and-Removing-Packages.html) to make the installation of the additional packages needed:

- [control](https://octave.sourceforge.io/control/index.html)
- [signal](https://octave.sourceforge.io/signal/index.html)
- [io](https://octave.sourceforge.io/io/index.html)
- [statistics](https://octave.sourceforge.io/statistics/index.html)
- [matgeom](https://octave.sourceforge.io/matgeom/index.html)
- [geometry](https://octave.sourceforge.io/geometry/index.html)
- [mapping](https://octave.sourceforge.io/mapping/index.html)

Once octave is configured:

```console
pkg load control
pkg load signal
pkg load io
pkg load statistics
pkg load matgeom
pkg load geometry
pkg load mapping
```

## Usage

## `pi_bullet_walking`

Assuming folder `output` exists:

```console
./run_pi_BulletWalking tests/walking/input/wrench_CrutchLeft.csv tests/walking/input/wrench_CrutchRight.csv tests/walking/input/gaitEvents.yaml output
```

## `pi_bullet_walkingComplete`

Assuming folder `output` exists:

```console
./run_pi_BulletWalkingComplete tests/walking_complete/input/wrench_CrutchLeft.csv tests/walking_complete/input/wrench_CrutchRight.csv tests/walking_complete/input/gaitEvents.yaml tests/walking_complete/input/wrench_ShoulderLeft.csv tests/walking_complete/input/wrench_ShoulderRight.csv output
```

## Build docker image

_(only tested under linux)_

Run the following command in order to create the docker image for this PI:

```console
docker build . -t pi_bullet
```

## Launch the docker image

Assuming the `tests/walking/input` contains the input data, and that the directory `out_tests/` is **already created**, and will contain the PI output:

```shell
docker run --rm -v $PWD/tests/walking/input:/in -v $PWD/out_tests:/out pi_bullet ./run_pi_BulletWalking
/in/wrench_CrutchLeft.csv /in/wrench_CrutchRight.csv /in/gaitEvents.yaml /out
```

Similar command can be launched for the algorithm `walkingcomplete`:

```shell

docker run --rm -v $PWD/tests/walking_complete/input:/in -v $PWD/out_tests:/out pi_bullet ./run_pi_BulletWalkingComplete /in/wrench_CrutchLeft.csv /in/wrench_CrutchRight.csv /in/gaitEvents.yaml /in/wrench_ShoulderLeft.csv /in/wrench_ShoulderRight.csv /out

```

## Acknowledgements

<a href="http://eurobench2020.eu">
  <img src="http://eurobench2020.eu/wp-content/uploads/2018/06/cropped-logoweb.png"
       alt="rosin_logo" height="60" >
</a>

Supported by Eurobench - the European robotic platform for bipedal locomotion benchmarking.
More information: [Eurobench website][eurobench_website]

<img src="http://eurobench2020.eu/wp-content/uploads/2018/02/euflag.png"
     alt="eu_flag" width="100" align="left" >

This project has received funding from the European Union’s Horizon 2020
research and innovation programme under grant agreement no. 779963.

The opinions and arguments expressed reflect only the author‘s view and
reflect in no way the European Commission‘s opinions.
The European Commission is not responsible for any use that may be made
of the information it contains.

[eurobench_logo]: http://eurobench2020.eu/wp-content/uploads/2018/06/cropped-logoweb.png
[eurobench_website]: http://eurobench2020.eu "Go to website"
