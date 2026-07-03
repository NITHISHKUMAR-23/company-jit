class MathOperations:
    def add(self, a, b, c=0):
        return a + b + c

math_op = MathOperations()
print(math_op.add(2, 3))     
print(math_op.add(2, 3, 4))  
