hrs = input("Enter Hours:")
rate = input("Enter Rate:")
try:
    h = float(hrs)
    r = float(rate)
except:
    print("Error, please enter a number")
    quit()

if h > 40.0:
    pay = (h * r) + ( (h - 40.0) * (r * 0.5) )
else:
    pay = h * r
print(pay)

