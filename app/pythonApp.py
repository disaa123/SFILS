### Dustin Isaacson
### Python interface for assignment 1
### requires password for database
### connection to MySql


import mysql.connector
from getpass import getpass
print ("\nHi\n")
print("SF Library Patron Database")
password = getpass("Enter MySQL password: ")
connection = None

try:
    connection = mysql.connector.connect(
        host="localhost",
        user="root",
        password=password,
        database="assignment1"
    )

    print("connected to database")
    cursor = connection.cursor()
    cursor.execute("SHOW TABLES")

    print("\ndatabase tables:")
    for table in cursor.fetchall():
        print(table[0])
    cursor.close()

    while True:

        print(" \nSan Francisco Library Database\n")
        print("1. view libraries")
        print("2. add patron")
        print("3. delete patron")
        print("4. exit")
        menuChoice = input("\nenter choice: ")

        if menuChoice == "1":
            cursor = connection.cursor()
            cursor.execute("""SELECT home_library_code, home_library_def
                FROM libraries ORDER BY home_library_def""")
            print("\n--- ALL LIBRARIES ---")

            for code, name in cursor.fetchall():
                print(f"{code}: {name}")
            cursor.close()

        elif menuChoice == "2":
            patron_type = int(input("Enter patron type code: "))
            library_code = input("Enter home library code: ")

            cursor = connection.cursor()
            cursor.execute("""INSERT INTO patrons (patron_type_code, home_library_code)
                VALUES (%s, %s)""", (patron_type, library_code))

            connection.commit()
            cursor.close()

        elif menuChoice == "3":
            patron_id = int(input("enter patron ID to delete: "))

            cursor = connection.cursor()
            cursor.execute("""DELETE FROM patrons WHERE patron_id = %s
                """, (patron_id,))
            connection.commit()

            if cursor.rowcount > 0:
                print("patron deleted successfully")
            else:
                print("patron ID not found")
            cursor.close()

        elif menuChoice == "4":
            print("Bye")
            break

        else:
            print("Invalid choice. enter 1-4.")

except mysql.connector.Error as error:
    print("database error:", error)

finally:
    if connection:
        connection.close()
        print("database connection closed")