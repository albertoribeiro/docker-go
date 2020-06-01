FROM golang:1.14.3-alpine3.11 as builder
WORKDIR /go/src/app
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...
RUN go build -ldflags="-s -w" hello.go

FROM scratch
COPY --from=builder /go/src/app/hello /usr/bin/hello
WORKDIR /usr/bin
ENTRYPOINT ["hello"]