# What's in this image?

This image is based on
[mottosso/docker-maya](https://github.com/mottosso/docker-maya).

Additionally, the image has the following software installed:
- [devtoolset-2](https://people.centos.org/tru/devtools-2/readme)
- [cmake 2.8](https://cmake.org/)
- [vim](http://www.vim.org/)
- [conan](https://www.conan.io/)
- Libraries and header files needed to build and test Maya plugins.

# How to use it?

The image has not been uploaded to the docker cloud.
To build the image, run `docker build`:

```bash
$ docker build -t mayadev .
```

To run the image, issue:

```bash
$ docker run -ti --rm mayadev
```

Inside the image the `test_plugin_load.py` script can be used to
test loading Maya plugins, e.g.:

```bash
$ test_plugin_load.py $MAYA_LOCATION/plug-ins/bifrost/plug-ins/Boss.so
PASS
```
