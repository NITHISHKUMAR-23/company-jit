class Animal:
    def speak(self):
        return "Animal makes a sound!"

class Pet:
    def play(self):
        return "Playing with the pet!"

class Dog(Animal, Pet):
    def bark(self):
        return "Dog barks!"

my_dog = Dog()
print(my_dog.speak())  
print(my_dog.play())   
print(my_dog.bark())  
