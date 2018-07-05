# rpi-varnish

Raspberry Pi compatible Docker base image with Varnish.

> Debian Stretch
> Varnish 5.x
> Arm32v7 Arch

## What is Varnish Cache?

![logo](https://avatars3.githubusercontent.com/u/14977495?s=200&v=4)

Varnish Cache is a web application accelerator also known as a caching HTTP reverse proxy. You install it in front of any server that speaks HTTP and configure it to cache the contents. Varnish Cache is really, really fast. It typically speeds up delivery with a factor of 300 - 1000x, depending on your architecture. A high level overview of what Varnish does can be seen in [this video](https://www.youtube.com/watch?v=fGD14ChpcL4).

For more information and related downloads for Varnish Cache please visit [varnish-cache.org](https://varnish-cache.org/index.html).

## Build Details
- [Mantainer](https://github.com/gioamato)
- [Source Repository](https://github.com/gioamato/rpi-varnish)
- [Dockerfile](https://github.com/gioamato/rpi-varnish/blob/master/Dockerfile)
- [DockerHub](https://hub.docker.com/r/gioamato/rpi-varnish/)

## How to use this image

### Starting a container from this image

To configure this container, you can edit the `default.vcl` file to point your backend or you can provide a custom `config.vcl` file (which is usually the case).

```
docker run -d \
  --link web-app:backend-host \
  --volumes-from web-app \
  --env 'VCL_CONFIG=/data/path/to/varnish.vcl' \
  gioamato/rpi-varnish
```

In the above example we assume that:
* You have your application running inside `web-app` container and web server there is running on port 80 (although you don't need to expose that port, as we use --link and varnish will connect directly to it)
* `web-app` container has `/data` volume with `varnish.vcl` somewhere there
* `web-app` is aliased inside varnish container as `backend-host`
* Your `varnish.vcl` should contain at least backend definition like this:

```
backend default {
    .host = "backend-host";
    .port = "80";
}
```

### Environment Variables

When you start the `rpi-varnish` image, you can adjust the configuration of the Varnish Cache instance by passing one or more environment variables on the `docker run` command line.

#### `VCL_CONFIG`

This variable will set the `custom.vcl` file to configure the Varnish daemon.

#### `CACHE_SIZE`

This variable will set the space allocated for the cache. The `-s <malloc[,size]>` option calls `malloc()` to allocate memory space for every object that goes into the cache. If the allocated space cannot fit in memory, the operating system automatically swaps the needed space to disk.

#### `VARNISHD_PARAMS`

Use this variable to set other Varnish parameters to specific values during daemon startup, see [List of Parameters](https://varnish-cache.org/docs/4.1/reference/varnishd.html#list-of-parameters) for details.

### Default Environment Variables

> **VCL_CONFIG** `/etc/varnish/default.vcl`  
> **CACHE_SIZE** `64m`  
> **VARNISHD_PARAMS** `-p default_ttl=3600 -p default_grace=3600`

## License

MIT License

Copyright (c) 2018 Giovanbattista Amato

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.