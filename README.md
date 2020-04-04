# Universe Datascience

Based on work and format defined here : https://github.com/mesosphere/universe

This is a collection of prepackaged apps, tailored for datascientists that can be deployed using [`DCOS`](https://dcos.io/).
This universe use the Onyxia format extension so that it can be used with Onyxia datalab (https://github.com/inseefrlab/onyxia-api & https://github.com/inseefrlab/onyxia-ui). This format extension is defined here (WIP : add link to specification).

## Using this universe

This universe is published at https://inseefrlab.github.io/Universe-Datascience/universe.json (corresponding to the `master` branch).

A preview universe is also published at https://inseefrlab.github.io/Universe-Datascience/universe-preview.json based on the preview branch of the InseeFrLab/Universe-Datascience repository.

## Building the universe

To build this universe, we use scripts provided by https://github.com/mesosphere/universe :

```
scripts/build.sh
```

The resulting `universe.json` is in `target` folder.
