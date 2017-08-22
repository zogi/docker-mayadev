FROM mottosso/maya:2017

# Setup envvars.
ENV MAYA_LOCATION=/usr/autodesk/maya2017
ENV TBB_ROOT=/usr/autodesk/maya2017

# Install development tools and some common libraries.
RUN wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo
RUN yum install -y devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++ cmake vim

# Libs needed for building Maya plugins.
RUN yum install -y mesa-libGLU-devel libX11-devel libXt-devel

# Add /root/bin, devtoolset-2 bin path and Maya bin path to PATH.
ENV PATH=/root/bin:/opt/rh/devtoolset-2/root/usr/bin:/usr/autodesk/maya2017/bin:$PATH

# Install conan.
ENV PYTHONPATH=/usr/lib/python2.6/site-packages:/usr/lib64/python2.6/site-packages
RUN mayapy -m pip install six
RUN mayapy -m pip install conan

# Create a wrapper script for conan.
# Setting PYTHONHOME globally breaks yum, setting LD_LIBRARY_PATH breaks the
# maya.standalone module.
WORKDIR /root/bin
RUN echo 'PYTHONHOME=/usr/autodesk/maya2017 LD_LIBRARY_PATH=/usr/autodesk/maya2017/lib /usr/autodesk/maya2017/bin/conan "$@"'>conan; chmod 555 conan

# Add the plugin load tester script to the image.
WORKDIR /root/bin
ADD test_plugin_load.py .

# Alias for dvorak layout.
RUN echo "alias te='ls -l'" >> ~/.bashrc

WORKDIR /root
