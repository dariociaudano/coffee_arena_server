ARG BASE=golang:1.18-alpine
FROM ${BASE} AS builder

ARG TARGETOS
ARG TARGETARCH

RUN echo "I'm building for $TARGETOS/$TARGETARCH"

WORKDIR /coffee-arena-server

RUN apk add --update --no-cache make git gcc libc-dev

COPY . .

RUN go mod download

RUN make build

# Next image - Copy built Go binary into new workspace
FROM alpine

WORKDIR /
COPY --from=builder /coffee-arena-server/coffee_arena_server /coffee_arena_server

EXPOSE 10000

ENTRYPOINT ["/coffee_arena_server"]
CMD ["--address=0.0.0.0", "--port=10000"]