FROM golang:1.22.1
LABEL authors="anton"

WORKDIR /app

COPY . .
RUN go mod download

RUN go build -o main .

CMD ["/app/main"]
