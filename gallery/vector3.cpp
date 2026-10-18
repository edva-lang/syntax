#include "shapes.hpp"
#include <iostream>
#include <cmath>
#include <memory>
#include <vector>

namespace math {

class Vector3 {
private:
    double x_{0.0};
    double y_{0.0};
    double z_{0.0};

public:
    constexpr Vector3() noexcept = default;
    constexpr Vector3(double x, double y, double z) noexcept : x_(x), y_(y), z_(z) {}

    [[nodiscard]] double magnitude() const noexcept {
        return std::sqrt(x_ * x_ + y_ * y_ + z_ * z_);
    }

    Vector3 operator+(const Vector3& rhs) const noexcept {
        return Vector3(x_ + rhs.x_, y_ + rhs.y_, z_ + rhs.z_);
    }

    Vector3 operator*(double scalar) const noexcept {
        return Vector3(x_ * scalar, y_ * scalar, z_ * scalar);
    }

    void print() const {
        std::cout << "Vector3(" << x_ << ", " << y_ << ", " << z_ << ")\n";
    }
};

} // namespace math

int main() {
    auto v1 = std::make_unique<math::Vector3>(1.0, 2.0, 3.0);
    math::Vector3 v2(4.0, 5.0, 6.0);
    auto v3 = *v1 + v2;
    v3.print();
    return 0;
}
