FROM golang:1.22.0 as builder
LABEL authors="anton"

WORKDIR /app

COPY . .

RUN go mod download

RUN go build -o main .

FROM alpine:latest
RUN apk --no-cache add ca-certificates libc6-compat sqlite

WORKDIR /app

COPY --from=builder /app/main /app/main

COPY --from=builder /app/tracker.db /app/tracker.db

RUN chmod +x /app/main

RUN chmod 644 /app/tracker.db

CMD ["./main"]
