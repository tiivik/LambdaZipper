# Python 3.6 Package Creator for AWS Lambda

## Quick start
`docker run --rm -v $(pwd):/package tiivik/lambdazipper MYPACKAGE`

for example

`docker run --rm -v $(pwd):/package tiivik/lambdazipper numpy`

Result is a `packagename.zip` that can be added as a Lambda Layer or extracted into your existing Lambda deployment package.

---

### This project consists of two key components
1. Docker environment mimicing AWS Lambda environment. If you are looking for an advanced Lambda environment copy look at
 https://github.com/lambci/docker-lambda
2. Packaging script to build AWS Lambda ready packages from Python 3.6 modules.

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

ADD package.sh /
ENTRYPOINT ["/package.sh"]
```

#### Build your own Docker image for finer control
```
docker build -t my-lambda .
```

#### Confirmed list of dependencies that can successfully be built for AWS Lambda with the Dockerfile provided
```
numpy
dlib
sklearn
requests
flask
bpy_lambda
```