# What's in this image?

This image is based on
[mottosso/docker-maya](https://github.com/mottosso/docker-maya).

Additionally, the image has the following software installed:
- [devtoolset-2](https://people.centos.org/tru/devtools-2/readme)
- [cmake 2.8](https://cmake.org/)
- [conan](https://www.conan.io/)

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
