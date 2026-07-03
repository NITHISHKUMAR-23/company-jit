my_dict = {
    'name': 'Ram',
    'age': 30,
    'city': 'New York'
}

print("Name:", my_dict['name']) 

my_dict['job'] = 'Engineer'
print("Dictionary after adding a new key-value pair:", my_dict)

del my_dict['age']
print("Dictionary after removing a key-value pair:", my_dict)

print("Key-Value pairs in the dictionary:")
for key, value in my_dict.items():
    print(f"{key}: {value}")
