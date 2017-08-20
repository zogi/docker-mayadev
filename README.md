# What's in this image?

This image is based on
[mottosso/docker-maya](https://github.com/mottosso/docker-maya).

Additionally, the image has the following software installed:
- [devtoolset-2](https://people.centos.org/tru/devtools-2/readme)
- [cmake 2.8](https://cmake.org/)
- [conan](https://www.conan.io/)
- [boost 1.61](http://www.boost.org/users/history/version_1_61_0.html)
- [libpng15](https://sourceforge.net/projects/libpng/files/libpng15/)
- libGLU-devel, libX11-devel, libXt-devel (for Maya plugin development)

# How to use it?

The image has not been uploaded to the docker cloud.
To build the image, issue `docker build`:

```bash
$ docker build -t mayadev .
```

then run the image:

```bash
$ docker run -ti --rm mayadev
```

Inside the image the `/root/bin/test_plugin_load.py` script can be used to
test loading Maya plugins like so:

```
$ test_plugin_load.py <path_to_my_plugin.so>
```
