# syntax=docker/dockerfile:1.6

FROM golang:latest AS builder

COPY . /sample-application
WORKDIR /sample-application
RUN go mod tidy
RUN CGO_ENABLED=0 GOOD=linux go build -o /sample-application/sample-application

FROM gcr.io/distroless/static

COPY --from=builder /sample-application/sample-application .

EXPOSE 8090
ENTRYPOINT ["./sample-application"]
