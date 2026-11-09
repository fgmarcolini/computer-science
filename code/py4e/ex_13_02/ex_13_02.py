import urllib.request, urllib.parse, urllib.error
import json

url = input("Enter location: ")
print("Retrieving", url)
uh = urllib.request.urlopen(url)

data = uh.read().decode()
info = json.loads(data)

print("Retrieved", len(data), "characters")

total = 0
for items in info["comments"]:
    total = total + items["count"]

print("Count", len(info["comments"]))
print("Sum", total)



