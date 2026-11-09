import sqlite3
import xml.etree.ElementTree as ET

# Make the connection
conn = sqlite3.connect("tracks.sqlite")
cur = conn.cursor()

# Clear the tables to prevent errors
cur.executescript('''
DROP TABLE IF EXISTS Artist;
DROP TABLE IF EXISTS Genre;
DROP TABLE IF EXISTS Album;
DROP TABLE IF EXISTS Track;
''')

# Create the tables from scratch
cur.executescript('''
CREATE TABLE Artist (
    id  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    name    TEXT UNIQUE
);

CREATE TABLE Genre (
    id  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    name    TEXT UNIQUE
);

CREATE TABLE Album (
    id  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    artist_id  INTEGER,
title   TEXT UNIQUE
);

CREATE TABLE Track (
    id  INTEGER NOT NULL PRIMARY KEY 
        AUTOINCREMENT UNIQUE,
    title TEXT  UNIQUE,
    album_id  INTEGER,
    genre_id  INTEGER,
    len INTEGER, rating INTEGER, count INTEGER
);
''')

# Obtaining the xml data
tracks_xml = ET.parse("tracks/Library.xml")
tracks = tracks_xml.findall("dict/dict/dict")
print("Dict count:", len(tracks))

#<key>Track ID</key><integer>369</integer>
#<key>Name</key><string>Another One Bites The Dust</string>
#<key>Artist</key><string>Queen</string>
def data(dict, text):
	temp = False
	for item in dict:
		if temp is True:
			return item.text
		if item.tag == 'key' and item.text == text:
			temp = True
	return None

for track in tracks:
	if data(track, "Track ID") is None:
		continue

	# Capture all the data
	name = data(track, "Name")
	artist = data(track, "Artist")
	genre = data(track, "Genre")
	album = data(track, "Album")
	count = data(track, "Play Count")
	rating = data(track, "Rating")
	length = data(track, "Total Time")

	print(name, artist, album, genre, count, rating, length)

	if name is None or artist is None or album is None or genre is None:
		continue

	# Insert into Artist Table
	cur.execute("INSERT OR IGNORE INTO Artist (name) VALUES ( ? )", (artist, ))
	cur.execute("SELECT id FROM Artist WHERE name = ? ", (artist, ))	
	artist_id = cur.fetchone()[0]

	# Insert into Genre Table
	cur.execute("INSERT OR IGNORE INTO Genre (name) VALUES ( ? )", (genre, ))
	cur.execute("SELECT id FROM Genre WHERE name = ? ", (genre, ))	
	genre_id = cur.fetchone()[0]

	# Insert into Album table
	cur.execute("INSERT OR IGNORE INTO Album (title, artist_id) VALUES ( ?, ? )", (album, artist_id, ))
	cur.execute("SELECT id FROM Album WHERE title = ? ", (album, ))	
	album_id = cur.fetchone()[0]

	# Insert into Track table
	cur.execute("INSERT OR REPLACE INTO Track (title, album_id, genre_id, len, rating, count) VALUES (?, ?, ?, ?, ?, ?)", (name, album_id, genre_id, length, rating, count, ))

conn.commit()