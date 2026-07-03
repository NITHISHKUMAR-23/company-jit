import math  # Pylint W0611: Unused import "math"

class MathOperations:  # Pylint C0115: Missing class docstring

    def squareRoot(self, num):  # Pylint C0103: Function name doesn't conform to snake_case naming style
        if num < 0:  # Pylint W0101: Consider handling complex numbers
            return "Negative number"
        return math.sqrt(num)

    def find_lcm(a, b):  # Pylint E0213: Method should have self as the first argument
        """Finds the least common multiple."""
        return abs(a * b) // math.gcd(a, b)  # Pylint E1120: Missing "math" import for gcd

    def risky_function(self):
        result = 10 / 0  # Pylint E1120: Division by zero
        return result

    def gcd(a, b):  # Pylint E0213: Method should have self as the first argument
        """Finds the greatest common divisor."""
        while b != 0:
            a, b = b, a % b
        return a

# Missing explicit return and function calls
print(MathOperations().squareRoot(-4)) # Pylint E1111: Statement has no effect
print(MathOperations.find_lcm(4, 6))
print(MathOperations.gcd(8, 12))
print(MathOperations().risky_function())
