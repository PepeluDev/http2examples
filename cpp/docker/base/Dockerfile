FROM alpine:latest

RUN apk add build-base cmake wget tar linux-headers openssl-dev libev-dev openssl-libs-static curl-dev zlib-dev git openssl ca-certificates 

RUN cd / && git clone --recurse-submodules https://github.com/aws/aws-sdk-cpp.git

# Build
RUN cd / && mkdir -p sdkbuild && cd sdkbuild && \
    cmake -DBUILD_ONLY="lambda;sts" -DBUILD_SHARED_LIBS=OFF \
    -DENABLE_TESTING=OFF -DFORCE_SHARED_CRT=OFF ../aws-sdk-cpp

# Install the sdk
RUN cd /sdkbuild && make install && cd ..

# Other dependencies

WORKDIR /code/deps

RUN set -x && wget https://boostorg.jfrog.io/artifactory/main/release/1.76.0/source/boost_1_76_0.tar.gz && \
    tar xvf boost* && cd boost* && ./bootstrap.sh && ./b2 -j4 install && cd .. && rm -rf * && set +x

RUN set -x && wget  https://github.com/google/googletest/archive/2fe3bd9.tar.gz -O gtest.tar.gz && \
    tar xvf gtest.tar.gz && cd googletest* && cmake . && make -j4 install && cd .. && rm -rf * && set +x

RUN set -x && wget https://github.com/nghttp2/nghttp2/releases/download/v1.39.2/nghttp2-1.39.2.tar.bz2 && \
    tar xf nghttp2* && cd nghttp2* && ./configure --enable-asio-lib --disable-shared && make -j4 install && \
    cd .. && rm -rf * && set +x

WORKDIR /code/build
