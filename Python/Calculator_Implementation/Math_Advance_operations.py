# my_calculator_project/calculator/Math_Advance_operations.py


def divide(a, b):
    """Return the quotient of a and b. Raise ValueError if b is zero."""
    if b == 0:
        raise ValueError("Cannot divide by zero!")
    return a / b

def modulus(a, b):
    """Return the modulus of a and b."""
    if b == 0:
        raise ValueError("Cannot divide by zero!")
    return a % b

def power(a, b):
    """Return a raised to the power of b."""
    return a ** b
