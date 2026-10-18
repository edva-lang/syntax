#ifndef BUFFER_H
#define BUFFER_H

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct Buffer {
    uint8_t *raw_bytes;
    size_t capacity;
    size_t length;
    bool is_locked;
} Buffer;

Buffer *buffer_create(size_t capacity);
void buffer_free(Buffer *buf);
size_t buffer_write(Buffer *buf, const uint8_t *src, size_t count);
size_t buffer_read(const Buffer *buf, uint8_t *dst, size_t count);

#ifdef __cplusplus
}
#endif

#endif /* BUFFER_H */
