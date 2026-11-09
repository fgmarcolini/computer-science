hrs = input("Enter Hours:")
rate = input("Enter Rate:")
h = float(hrs)
r = float(rate)

if h > 40.0:
    pay = (h * r) + ( (h - 40.0) * (r * 0.5) )
else:
    pay = h * r
print(pay)

