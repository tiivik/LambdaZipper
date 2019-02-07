# Fast Edit-Build-Test Cycle for Deploying Lambda Functions on AWS


This project consists of two key components.
1. Docker environment mimicing AWS Lambda environment.
2. Packaging script to build AWS Lambda ready packages from Python 3.6 modules.

## Quick start


## Precompiled binaries
Some precompiled binaries that can be imported into AWS Lambda can be found below


## Dockerfile for Lambda environment
```
FROM amazonlinux:2017.03
RUN yum -y install git \
    python36 \
    python36-pip \
    zip \
    && yum clean all
RUN python3 -m pip install --upgrade pip \
    && python3 -m pip install boto3
RUN yum -y install gcc g++ gcc gcc-c++ cmake
RUN yum -y install python36*
```

#### Build the container
```
docker build -t w3d/lambda .
```

## Build a lambda package
```
docker run --rm -v $(pwd):/package -t w3d/lambda bash /package/package.sh numpy
```
For example building dlib that is executable in AWS Lambda environment run
```
docker run --rm -v $(pwd):/package -t w3d/lambda bash /package/package.sh dlib
```

`--rm` - prevents Docker from saving the container's disk state to host

`-v $(pwd)/packages:/packages` - mount current directory as volume into `/packages` inside Docker container

`bash /packages/package.sh` - run `package.sh` inside the Docker container

#### List of dependencies that can be built for AWS Lambda with the default Docker container:
```
numpy
dlib
```
Dockerfile for the environment is provided and more dependencies can be added to the build environment. 