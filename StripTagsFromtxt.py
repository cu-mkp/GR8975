import re
import os

for filename in os.listdir("./folio_files"):
	print(filename)

	file_handle = open("./folio_files/"+filename, 'r')
	file_string = file_handle.read()
	file_handle.close()
	
	file_string = (re.sub('<[^>]*>', '', file_string))

	file_handle = open("./folio_files/"+filename, 'w')
	file_handle.write(file_string)
	file_handle.close()
	