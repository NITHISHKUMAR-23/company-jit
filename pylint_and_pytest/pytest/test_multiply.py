# from multiply import mul

# def test_mul_positive_numbers():
#     assert mul(2, 3) == 6
    
# def test_mul_new():
#     assert mul(5,2*2) == 10+10

# def test_mul_negative_numbers():
#     assert mul(-2, -3) == 6

# def test_mul_mixed_sign_numbers():
#     assert mul(-2, 3) == -6

# def test_mul_with_zero():
#     assert mul(0, 5) == 0
#     assert mul(5, 0) == 0


import pytest
from multiply import mul

@pytest.mark.parametrize("a, b, expected", [
    (2, 3, 6),
    (-2, -3, 6),
    (-2, 3, -6),
    (0, 5, 0),
])
def test_mul(a, b, expected):
    assert mul(a, b) == expected
