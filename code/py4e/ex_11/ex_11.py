import re

handle = open('regex_sum_1643903.txt', 'r')

nums = list()
for line in handle:
    line = line.strip()
    
    # Find all numbers in a line with regex
    num = re.findall('([0-9]+)', line)

    # If not find any number, continue in next loop
    if len(num)==0:
        continue

    # Convert the string list to integer list
    for i in range(len(num)):
        num[i] = int(num[i])
    
    # Concatenate the final list with the converted list
    nums = nums + num

print(sum(nums))

