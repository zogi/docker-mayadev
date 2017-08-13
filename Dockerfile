FROM mottosso/maya:2017

RUN wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo
RUN yum install -y devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++ cmake

ENV PATH=/root/bin:/opt/rh/devtoolset-2/root/usr/bin:/usr/autodesk/maya2017/bin:$PATH
RUN echo "/usr/autodesk/maya2017/lib" > /etc/ld.so.conf.d/maya_libs.conf; ldconfig

ENV PYTHONPATH=/usr/lib/python2.6/site-packages:/usr/lib64/python2.6/site-packages
RUN mayapy -m pip install six
RUN mayapy -m pip install conan

RUN mkdir /root/bin
RUN echo 'PYTHONHOME=/usr/autodesk/maya2017 /usr/autodesk/maya2017/bin/conan "$@"'>/root/bin/conan; chmod 555 /root/bin/conan

WORKDIR /root
