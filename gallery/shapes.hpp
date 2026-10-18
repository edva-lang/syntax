#pragma once

#include <string_view>
#include <concepts>
#include <numbers>

namespace shapes {

template <typename T>
concept Numeric = std::is_arithmetic_v<T>;

template <Numeric T>
class Circle {
public:
    explicit constexpr Circle(T radius) noexcept : radius_(radius) {}

    [[nodiscard]] constexpr T radius() const noexcept { return radius_; }
    [[nodiscard]] double area() const noexcept {
        return std::numbers::pi * static_cast<double>(radius_ * radius_);
    }

private:
    T radius_;
};

} // namespace shapes
