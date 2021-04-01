FROM golang:1.15.7 as builder
ARG VERSION
COPY greeter_server/ /go/src/github.com/mikutas/grpc-go-helloworld/greeter_server/
RUN cd /go/src/github.com/mikutas/grpc-go-helloworld/greeter_server/ \
 && go build

FROM gcr.io/distroless/base-debian10
COPY --from=builder /go/src/github.com/mikutas/grpc-go-helloworld/greeter_server/greeter_server /bin
ENTRYPOINT [ "greeter_server" ]
