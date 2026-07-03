import math

class MathOperations:
    """A class for performing various mathematical operations."""

    def gcd(self, a, b):
        """Finds the greatest common divisor (GCD) of two numbers."""
        # return math.gcd(a, b)
        # manual implementation:
        while b != 0:
            a, b = b, a % b
        return a

    def find_lcm(self, a, b):
        """Finds the least common multiple (LCM) of two numbers."""
        if a == 0 or b == 0:
            return "LCM is not defined for zero"
        return abs(a * b) // self.gcd(a, b)

math_operation = MathOperations()
print("LCM of 12 and 18:", math_operation.find_lcm(12, 18))
print("GCD of 12 and 18:", math_operation.gcd(12, 18))
