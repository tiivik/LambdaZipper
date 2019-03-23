# Python 3.6 Package Creator for AWS Lambda

<a href="https://www.buymeacoffee.com/NscyVhWZG">Buy me a coffee!![Buy me a coffee!](https://www.buymeacoffee.com/assets/img/BMC-btn-logo.svg)</a>

## Quick start
`docker run --rm -v $(pwd):/package tiivik/lambdazipper MYPACKAGE`

**Example:**

`docker run --rm -v $(pwd):/package tiivik/lambdazipper numpy`

Result is `numpy.zip` that can be added as a [Lambda Layer](https://aws.amazon.com/blogs/aws/new-for-aws-lambda-use-any-programming-language-and-share-common-components/) or extracted into your existing Lambda deployment package.



---
### Confirmed Python 3.6 dependencies
Confirmed list of Python 3.6 dependencies that can successfully be built for AWS Lambda with the [Dockerfile](Dockerfile) provided
```
opencv-python
numpy
dlib
sklearn
requests
flask
bpy_lambda
```

### This project consists of two key components
1. Docker environment mimicing AWS Lambda environment. If you are looking for an advanced Lambda environment replication, take a look at [lambci/docker-lambda](https://github.com/lambci/docker-lambda).
2. Packaging script to build AWS Lambda ready packages from Python 3.6 modules.

## Dockerfile for Lambda environment
Premade Docker image can be found on Docker Hub https://cloud.docker.com/repository/docker/tiivik/lambdazipper
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

ADD package.sh /
ENTRYPOINT ["/package.sh"]
```

#### Build your own Docker image for finer control
```
docker build -t my-lambda .
```
