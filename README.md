# BEiGUIDE

<!-- Badges start -->
[![Tests](https://github.com/agmcfarland/BEiGUIDE/actions/workflows/test-build.yml/badge.svg)](https://github.com/agmcfarland/BEiGUIDE/actions/workflows/test-build.yml)
[![codecov](https://codecov.io/gh/agmcfarland/BEiGUIDE/graph/badge.svg?token=NPALNGNUFJ)](https://codecov.io/gh/agmcfarland/BEiGUIDE)
<!-- Badges end -->

# Background

`Base editor iGUIDE (BEiGUIDE)` allows for quantification of base edits in on and off-target cut sites identified by iGUIDE.

# Installation

```R
devtools::install_github('agmcfarland/BEiGUIDE')
```

# Usage

```sh
/home/ubuntu/miniconda3/envs/aavenger_r4_env/bin/Rscript -e "BEiGUIDE::quantify_edits('/data/BEiGUIDE/tests/testthat/testdata/integration_1', '/data/temp')"
```