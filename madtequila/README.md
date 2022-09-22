Special madness version suitable to run with tequila.  
See recipe for sources.  
Implementes what is described in [arxiv:2008.02819](https://arxiv.org/abs/2008.02819).  
Hosted on [anaconda.org/kottmann/madtequila](https://anaconda.org/kottmann/madtequila).  

### Notes for OSX
- OSX-64 version on the anaconda cloud seems to work. 
- OSX-ARM1 version on the anaconda cloud does not work. Suspected reason are issues with the MKL dependency.
Potential solutions: Use apple accelerate framework
1. set `ENABLE_MKL=OFF` in [build.sh](build.sh)
2. install accelerate framework (probably over xcode or something)
3. make sure that the cmake call in the conda build finds the lapack/blas libraries of apple:
  - provide an additional file named `conda_build_config.yaml' with content
  ```bash
  CONDA_BUILD_SYSROOT:
  - /opt/MacOSX11.3.sdk
  ```
  and add the the following to the cmake call in [build.sh](build.sh)
  ```bash
  -D CMAKE_OSX_SYSROOT="${CONDA_BUILD_SYSROOT}"
  ```
