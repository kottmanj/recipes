PLATFORM=linux-64 # adapt if necessary
echo building on $PLATFORM
echo you are on $(uname -a)

mkdir build

# export paths to dependencies
export CPLUS_INCLUDE_PATH=$(realpath numcpp/include):$CPLUS_INCLUDE_PATH
# make sure that the right boost and mkl are found and used
export CPLUS_INCLUDE_PATH=$(realpath $PREFIX/include):$CPLUS_INCLUDE_PATH

cmake -D ENABLE_MPI=OFF -D ENABLE_MKL=ON -D CMAKE_INSTALL_PREFIX="$PREFIX" -D CMAKE_CXX_FLAGS="-O3 -DNDEBUG" -S madness -B build
make -j12 -C build
make nemo moldft cis pno cc2 mp2 znemo zcis oep -C build
make install -C build

mkdir -p $PREFIX/etc/conda/activate.d/
touch $PREFIX/etc/conda/activate.d/activate_madness.sh

# get mandess version from source
A=$(grep 'set(MADNESS_MAJOR_VERSION' madness/CMakeLists.txt | cut -d ')' -f 1 | cut -d ' ' -f 2)
B=$(grep 'set(MADNESS_MINOR_VERSION' madness/CMakeLists.txt | cut -d ')' -f 1 | cut -d ' ' -f 2)
C=$(grep 'set(MADNESS_MICRO_VERSION' madness/CMakeLists.txt | cut -d ')' -f 1 | cut -d ' ' -f 2)

MAD_VERSION="$A.$B.$C"

echo "export MRA_DATA_DIR=$PREFIX/share/madness/$MAD_VERSION/data/" >> $PREFIX/etc/conda/activate.d/activate_madness.sh
echo "export MRA_CHEMDATA_DIR=$PREFIX/share/madness/$MAD_VERSION/data/" >> $PREFIX/etc/conda/activate.d/activate_madness.sh
