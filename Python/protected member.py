class Base:
    def __init__(self):
        self._protected_var = "I am a protected variable"

class Derived(Base):
    def access_protected(self):
        return self._protected_var

obj = Derived()
print(obj.access_protected()) 
