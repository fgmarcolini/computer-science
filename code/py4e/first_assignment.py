print("Hello Python for Everybody!")
print("I'm Gabriel and this is my little program for 1st assignment (right now I have almost finished py4e)")

score = int(input("Rate from 0 to 10 how much do you like PY4E course? "))
while score<0 or score>10:
    score = int(input("Rate from 0 to 10 how much do you like PY4E course? "))
    
if 7<score<=10:
    print("Perfect!!")
elif score > 5:
    print("Good!")
else:
    print("Why?")

if score>=10:
    print("hello world", score)

