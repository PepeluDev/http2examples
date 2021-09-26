FROM cppserverbase:latest as builder

COPY . /code
WORKDIR /code/cpp/build
RUN  cmake -DCMAKE_BUILD_TYPE=Release .. \
    && make -j4 && mkdir -p /cppserver \
    && cp /code/cpp/build/src/main/cpp/cpphttpserver /cppserver/cppserver \
    && rm -rf /code

WORKDIR /cppserver
CMD ["./cppserver"]
EXPOSE 3000

