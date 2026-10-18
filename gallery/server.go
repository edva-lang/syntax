package main

import (
	"context"
	"fmt"
	"net/http"
	"sync"
	"time"
)

type HealthCheckResponse struct {
	Status    string    `json:"status"`
	UptimeSec int64     `json:"uptime_sec"`
	Timestamp time.Time `json:"timestamp"`
}

type ServerPool struct {
	mu      sync.RWMutex
	servers []string
	current int
}

func (p *ServerPool) NextServer() (string, error) {
	p.mu.Lock()
	defer p.mu.Unlock()

	if len(p.servers) == 0 {
		return "", fmt.Errorf("no healthy servers available")
	}

	target := p.servers[p.current]
	p.current = (p.current + 1) % len(p.servers)
	return target, nil
}

func main() {
	pool := &ServerPool{
		servers: []string{"http://10.0.0.1:8080", "http://10.0.0.2:8080"},
	}

	srv, err := pool.NextServer()
	if err != nil {
		panic(err)
	}
	fmt.Printf("Routing request to %s\n", srv)
}
