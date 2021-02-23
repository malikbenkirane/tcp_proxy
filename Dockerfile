FROM golang:1.15 AS builder
WORKDIR /opt/builder
COPY ./ .
RUN CGO_ENABLED=0 go build -o ./tcpproxy ./cmd/tcpproxy

FROM alpine AS debug
WORKDIR /opt/bin
COPY --from=builder /opt/builder/tcpproxy .
