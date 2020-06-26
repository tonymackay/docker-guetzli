# Overview
This repo contains a multi-stage Dockerfile that will build [Guetzli JPEG compressor][guetzli] from source and copy the program to a minimal (scratch) Docker image.

## Building
Run the following command to build the latest version of guetzli.

```
./version build
```

You can change the Docker ID, Password and Hugo version by setting the following variables:

```
export DOCKER_ID=<yourid>
export VERSION=<versiontag>
```

The version script will publish the image to a Docker hub repository if you use the correct Docker ID, app name and password. Either set the password using `export PASSWORD=<yourpassword>` or create a file containing the password at: `~/.docker/password.txt`.

To publish run.

```
./version publish
```

## Using
The following example shows how to run the guetzli:

```
docker run --rm -it tonymackay/guetzli:v1.0.1
```

Output:
```
Guetzli JPEG compressor. Usage: 
guetzli [flags] input_filename output_filename

Flags:
  --verbose    - Print a verbose trace of all attempts to standard output.
  --quality Q  - Visual quality to aim for, expressed as a JPEG quality value.
  --memlimit M - Memory limit in MB. Guetzli will fail if unable to stay under
                 the limit. Default is 6000 MB
  --nomemlimit - Do not limit memory usage.
```

The following example shows how to compress an image located on the host where the container is running.

```
docker run --rm -it -v $(pwd):/data \
tonymackay/guetzli:v1.0.1 --quality 84 test-image.jpg test-image-compressed.jpg
```


[guetzli]: https://github.com/google/guetzli