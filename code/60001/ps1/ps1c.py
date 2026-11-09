# Part C: Finding the right amount to save away
current_savings = 0
r = 0.04
total_cost = 1000000.0
semi_annual_raise = .07
portion_down_payment = total_cost * 0.25
months = 36

# Bisection search 
epsilon = 100
steps_bisection = 0
low = 0
high = 10000
guess = (high+low)/2.0

annual_salary = float(input("Enter your annual salary: "))

# Because months is a constant and it's 36 => 36/6=6
for i in range(6):
	annual_salary += (annual_salary*semi_annual_raise)
num_guesses = 0
portion_saved = 0
while abs((guess+(guess*r/12) + ((annual_salary/12) * portion_saved)) - portion_down_payment) >= epsilon:
	if (guess+(guess*r/12) + ((annual_salary/12) * portion_saved)) < portion_down_payment:
		low = guess
	else:
		high = guess
	guess = (high+low)/2.0
	num_guesses += 1
	portion_saved += 1 

	print(guess+(guess*r/12) + ((annual_salary/12) * portion_saved))
	if portion_saved == 10000:
		break

print(portion_saved)


