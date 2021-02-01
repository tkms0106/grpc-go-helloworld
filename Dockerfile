FROM golang:1.15.7 as builder
RUN apt-get update \
 && apt-get install -y git
ARG VERSION
RUN git clone https://github.com/grpc/grpc-go -b ${VERSION} /go/src/github.com/grpc/grpc-go
WORKDIR /go/src/github.com/grpc/grpc-go
RUN cd examples/helloworld/greeter_server \
 && go build

FROM gcr.io/distroless/base-debian10
COPY --from=builder /go/src/github.com/grpc/grpc-go/examples/helloworld/greeter_server/greeter_server /bin
ENTRYPOINT [ "greeter_server" ]
