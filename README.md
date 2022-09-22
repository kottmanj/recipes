# recipes
collection of conda recipes

- [madness](madness): Madness from source. Works for applications, but has issues with using it as development library (hard links to MKL)
- [madtequila](madtequila): Special Madness fork suitable to use with tequila (will be automatically detected by the latter)

# How to compile
1. Get Anaconda (or miniconda)
2. Install conda-build
```bash
conda install conda-build
```
3. Install from recipe
```bash
conda-build recipe_directory
```
