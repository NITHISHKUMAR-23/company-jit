import pytest
from pytest_math_lcm_gcd import MathOperations

@pytest.fixture
def math_operations():
    """Fixture to create an instance of MathOperations."""
    return MathOperations()

def test_gcd(math_operations):
    """Test the gcd method."""
    assert math_operations.gcd(12, 18) == 6  # GCD of 12 and 18 is 6
    assert math_operations.gcd(0, 18) == 18  # GCD of 0 and 18 is 18
    assert math_operations.gcd(18, 0) == 18  # GCD of 18 and 0 is 18
    assert math_operations.gcd(7, 13) == 1  # GCD of two prime numbers is 1

def test_find_lcm(math_operations):
    """Test the find_lcm method."""
    assert math_operations.find_lcm(12, 18) == 36  # LCM of 12 and 18 is 36
    assert math_operations.find_lcm(0, 18) == "LCM is not defined for zero"  # LCM with 0
    assert math_operations.find_lcm(18, 0) == "LCM is not defined for zero"  # LCM with 0
    assert math_operations.find_lcm(7, 13) == 91  # LCM of two primes is their product (7 * 13)
