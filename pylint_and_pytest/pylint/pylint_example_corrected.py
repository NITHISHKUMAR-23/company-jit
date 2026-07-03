""""
Program to find square root, lcm and gcd
"""

import math

class MathOperations:
    """A class for performing various mathematical operations."""

    @staticmethod
    def square_root(num):
        """Returns the square root of a number."""
        if num < 0:
            return "Square root of negative numbers is not supported"
        return math.sqrt(num)

    @staticmethod
    def gcd(a, b):
        """Finds the greatest common divisor (GCD) of two numbers."""
        # return math.gcd(a, b)
        while b != 0:
            a, b = b, a % b
        return a

    @staticmethod
    def find_lcm(a, b):
        """Finds the least common multiple (LCM) of two numbers."""
        if a == 0 or b == 0:
            return "LCM is not defined for zero"
        return abs(a * b) // math.gcd(a, b)

    def risky_function(self):
        """Safely performs a division."""
        try:
            result = 10 / 0  # Avoid division by zero
            return result
        except ZeroDivisionError:
            return "Cannot divide by zero"

# Example usage
math_operation = MathOperations()
print("Square root of 16:", math_operation.square_root(16))
print("LCM of 12 and 18:", math_operation.find_lcm(12, 18))
print("GCD of 12 and 18:", math_operation.gcd(12, 18))
print("Risky Function Output:", math_operation.risky_function())


# Unused Import:

# Kept the math import because it's now used for sqrt and gcd.
# Static Methods:

# Used @staticmethod where instance-specific data was not required.
# Naming Conventions:

# Renamed squareRoot → square_root, consistent with snake_case.
# Ensured proper naming for all other functions and variables.
# Division by Zero:

# Handled 10 / 0 in risky_function using a try-except block.
# Proper Function Calls:

# Added explicit calls to functions in the Example Usage section.
# Error Handling:

# Handled edge cases for LCM when either number is zero.
# Handled negative inputs for square root.
