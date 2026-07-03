from abc import ABC, abstractmethod
class Vehicle(ABC):
    @abstractmethod
    def start_engine(self):
        pass
    
    @abstractmethod
    def stop_engine(self):
        pass

class Car(Vehicle):
    def start_engine(self):
        return "Car engine started."

    def stop_engine(self):
        return "Car engine stopped."

class Motorcycle(Vehicle):
    def start_engine(self):
        return "Motorcycle engine started."

    def stop_engine(self):
        return "Motorcycle engine stopped."

car = Car()
motorcycle = Motorcycle()
print(car.start_engine())  
print(motorcycle.start_engine())
