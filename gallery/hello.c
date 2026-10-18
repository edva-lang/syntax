/*
 * Ring buffer implementation in C99.
 * Provides circular FIFO byte queue for I/O buffers.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

#define BUFFER_CAPACITY 1024

typedef struct {
    uint8_t data[BUFFER_CAPACITY];
    size_t head;
    size_t tail;
    size_t size;
} RingBuffer;

void rb_init(RingBuffer *rb) {
    rb->head = 0;
    rb->tail = 0;
    rb->size = 0;
}

bool rb_push(RingBuffer *rb, uint8_t byte) {
    if (rb->size >= BUFFER_CAPACITY) {
        return false;
    }
    rb->data[rb->head] = byte;
    rb->head = (rb->head + 1) % BUFFER_CAPACITY;
    rb->size++;
    return true;
}

int main(int argc, char **argv) {
    RingBuffer q;
    rb_init(&q);

    for (int i = 0; i < 10; ++i) {
        rb_push(&q, (uint8_t)(i * 7));
    }

    printf("Buffer initialized with %zu items\n", q.size);
    return 0;
}
