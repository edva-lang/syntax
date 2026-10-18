"""
Token bucket rate limiter and streaming pipeline.
Demonstrates async/await, dataclasses, type hints, and generators.
"""

from __future__ import annotations
import asyncio
import time
from dataclasses import dataclass
from typing import AsyncGenerator, Optional

@dataclass
class RateConfig:
    rate: float          # tokens per second
    capacity: float      # max bucket size
    initial: float = 0.0

class TokenBucket:
    def __init__(self, config: RateConfig) -> None:
        self.capacity = config.capacity
        self.rate = config.rate
        self.tokens = min(config.initial, config.capacity)
        self.last_update = time.monotonic()

    def consume(self, amount: float = 1.0) -> bool:
        now = time.monotonic()
        elapsed = now - self.last_update
        self.last_update = now
        self.tokens = min(self.capacity, self.tokens + elapsed * self.rate)

        if self.tokens >= amount:
            self.tokens -= amount
            return True
        return False

async def event_stream(limit: int) -> AsyncGenerator[dict[str, int], None]:
    for i in range(limit):
        await asyncio.sleep(0.01)
        yield {"id": i, "value": i * i}

if __name__ == "__main__":
    limiter = TokenBucket(RateConfig(rate=10.0, capacity=20.0))
    print(f"Limiter ready: tokens={limiter.tokens}")
