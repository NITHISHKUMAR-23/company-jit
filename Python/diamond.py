class A:
    def display(self):
        print("Display method from class A")

class B(A):
    def display(self):
        print("Display method from class B")

class C(A):
    def display(self):
        print("Display method from class C")

class D(B, C):
    pass

d = D()
d.display()