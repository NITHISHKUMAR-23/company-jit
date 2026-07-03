# my_calculator_project/main.py

from Calculator_Implementation import add, subtract, multiply, divide, modulus, power

def main():
    print("Hello, Welcome to the My Calculator!")
    while True:
        print("\nOptions:")
        print("1. Addition of 2 Numbers")
        print("2. Subtraction of 2 Numbers")
        print("3. Multiplication of 2 Numbers")
        print("4. Diviision of 2 Numbers")
        print("5. Modulus of 2 Numbers")
        print("6. Power of a Number")
        print("7. Exit")
        
        choice = input("Choose an operation (1-7): ")
        
        if choice == '7':
            print("Exiting the calculator. Tata-Goodbye!")
            break
        
        if choice in {'1', '2', '3', '4', '5', '6'}:
            try:
                a = float(input("Enter first number: "))
                b = float(input("Enter second number: "))
                
                if choice == '1':
                    print(f"{a} + {b} = {add(a, b)}")
                elif choice == '2':
                    print(f"{a} - {b} = {subtract(a, b)}")
                elif choice == '3':
                    print(f"{a} * {b} = {multiply(a, b)}")
                elif choice == '4':
                    print(f"{a} / {b} = {divide(a, b)}")
                elif choice == '5':
                    print(f"{a} % {b} = {modulus(a, b)}")
                elif choice == '6':
                    print(f"{a} ^ {b} = {power(a, b)}")
            except ValueError as e:
                print(f"Error: {e}")
        else:
            print("Invalid choice. Please select a valid option.")

if __name__ == "__main__":
    main()


