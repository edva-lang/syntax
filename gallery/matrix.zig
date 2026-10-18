const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

pub const MatrixError = error{
    DimensionMismatch,
    OutOfMemory,
};

pub fn Matrix(comptime T: type) type {
    return struct {
        rows: usize,
        cols: usize,
        data: []T,
        allocator: Allocator,

        const Self = @This();

        pub fn init(allocator: Allocator, rows: usize, cols: usize) Allocator.Error!Self {
            const data = try allocator.alloc(T, rows * cols);
            @memset(data, 0);
            return Self{
                .rows = rows,
                .cols = cols,
                .data = data,
                .allocator = allocator,
            };
        }

        pub fn deinit(self: *Self) void {
            self.allocator.free(self.data);
        }

        pub fn get(self: Self, r: usize, c: usize) T {
            return self.data[r * self.cols + c];
        }

        pub fn set(self: *Self, r: usize, c: usize, val: T) void {
            self.data[r * self.cols + c] = val;
        }
    };
}
