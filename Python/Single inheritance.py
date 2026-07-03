class Animal:
    def __init__(self, name):
        self.name = name

    def speak(self):
        return f"{self.name} makes a sound!"
    
class Dog(Animal):
    def speak(self):
        return f"{self.name} barks!"

my_dog = Dog("Buddy")
print(my_dog.speak())
