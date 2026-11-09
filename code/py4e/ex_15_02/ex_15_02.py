#This application will read the mailbox data (mbox.txt) and count the number of email messages per organization (i.e. domain name of the email address) using a database 
import sqlite3

conn = sqlite3.connect("orgs.sqlite")
cur = conn.cursor()

# Clear the table before anything to avoid errors
cur.execute("DROP TABLE IF EXISTS Counts")

# Create the table Counts
cur.execute("CREATE TABLE Counts (org TEXT, count INTEGER)")

# Open the mbox.txt file
fh = open("../mbox.txt")

for line in fh:
    if not line.startswith("From: "):
        continue
    
    # Substract the org name of the email
    org = line.split()[1].split('@')[1]

    cur.execute("SELECT count FROM Counts WHERE org = ? ", (org, ))
    row = cur.fetchone() # Get the first row of the SQL query
    if row is None:
        cur.execute("INSERT INTO Counts (org, count) VALUES (?, 1) ", (org, ))
    else:
        cur.execute("UPDATE Counts SET count = count + 1 WHERE org = ? ", (org, ))

# Commit the database operations at the end of the loop for boost performance
conn.commit()

sqlstr = "SELECT org, count FROM Counts ORDER BY count DESC LIMIT 10"
for row in cur.execute(sqlstr):
    print(str(row[0]), row[1])

# Close the database
cur.close()
    
