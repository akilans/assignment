FROM golang:1.21.6-alpine as builder

# Add a work directory
WORKDIR /app
# Copy app files
COPY . .
# Build app
RUN go build -o sample-app


FROM alpine:3.19 as production
# Add certificates
RUN apk add --no-cache ca-certificates
# Copy built binary from builder
COPY --from=builder /app/sample-app .

ENV PORT=:8080
# Expose port
EXPOSE 8080
# Exec built binary
CMD ./sample-app