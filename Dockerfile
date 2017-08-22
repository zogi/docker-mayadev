FROM mottosso/maya:2017

# Install development tools and some common libraries.
RUN wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo
RUN yum install -y devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++ cmake
# libX11 and libXt are needed for building Maya plugins.
# zlib is needed by libpng15.
RUN yum install -y zlib-devel mesa-libGLU-devel libX11-devel libXt-devel

# Add /root/bin, devtoolset-2 bin path and maya bin path to PATH.
ENV PATH=/root/bin:/opt/rh/devtoolset-2/root/usr/bin:/usr/autodesk/maya2017/bin:$PATH

# Build and install Boost 1.61 (conforming to the vfxplatform 2017).
WORKDIR /root/build
RUN wget --quiet https://sourceforge.net/projects/boost/files/boost/1.61.0/boost_1_61_0.tar.gz && tar -xf boost_1_61_0.tar.gz
WORKDIR /root/build/boost_1_61_0
RUN ./bootstrap.sh --prefix=/usr/local --libdir=/usr/local/lib64 --with-python-root=/usr/autodesk/maya2017 --with-python=/usr/autodesk/maya2017/bin/mayapy
RUN ./b2 -s NO_BZIP2=1 install

# Build and install libpng15 (needed by Maya 2017).
WORKDIR /root/build
RUN wget --quiet https://downloads.sourceforge.net/project/libpng/libpng15/1.5.28/libpng-1.5.28.tar.gz && tar -xf libpng-1.5.28.tar.gz
WORKDIR /root/build/libpng-1.5.28
RUN ./configure --prefix=/usr/local --libdir=/usr/local/lib64 && make install

# Set up the dynamic linker search path.
WORKDIR /etc/ld.so.conf.d
RUN echo "/usr/local/lib64" > 01_usr_local_lib64.conf
RUN echo "/usr/autodesk/maya2017/lib" > 02_maya_libs.conf
RUN ldconfig

# Install conan.
ENV PYTHONPATH=/usr/lib/python2.6/site-packages:/usr/lib64/python2.6/site-packages
RUN mayapy -m pip install six
RUN mayapy -m pip install conan

# Create a wrapper script to call conan.
# Only modify PYTHONHOME for conan. Yum needs python 2.6.
WORKDIR /root/bin
RUN echo 'PYTHONHOME=/usr/autodesk/maya2017 /usr/autodesk/maya2017/bin/conan "$@"'>conan; chmod 555 conan

# Setup envvars.
ENV MAYA_LOCATION=/usr/autodesk/maya2017
ENV TBB_ROOT=/usr/autodesk/maya2017

# The libfreetype.so packaged with Maya in this image is incompatible with the
# glibc version shipped with this CentOS, so just overwrite it.
RUN \cp -f /usr/lib64/libfreetype.so.6.3.22 /usr/autodesk/maya2017/lib/libfreetype.so

# Add script to test plugin loading.
WORKDIR /root/bin
ADD test_plugin_load.py .
RUN chmod +x test_plugin_load.py

RUN echo "alias te='ls -l'" >> ~/.bashrc

WORKDIR /root
