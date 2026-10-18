# syntax=docker/dockerfile:1.4
FROM debian:bookworm-slim AS builder

WORKDIR /build
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY . .
RUN make release

FROM gcr.io/distroless/cc-debian12:nonroot
WORKDIR /app
COPY --from=builder /build/bin/service /app/service
USER nonroot:nonroot

EXPOSE 8080
ENV APP_ENV=production
ENTRYPOINT ["/app/service"]
