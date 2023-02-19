"""
Sample tests
"""

from django.test import SimpleTestCase

from app import calc

class CalcTests(SimpleTestCase):
    """Test and calculate module."""

    def test_add_numbers(self):
        """test adding numbers."""
        res = calc.add(5,6)
        self.assertEqual(res,11)

    def test_subtract_numbers(self):
        """"test subtracting numbers."""
        res = calc.sub(10,5)
        self.assertEqual(res,5)