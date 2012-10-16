# Your database user, requires SELECT, INSERT and DELETE
db_user = ''

# Password for database user
db_password = ''

# Database host
db_host = ''

# Database schema to use
db_database = 'rail'

# Filename of ATOC schedule file. Usually TTISFnnn.MCA
atoc_file = ''

# Filename of Network Rail schedule file. Usually toc-TOCCODE.json
nr_file = ''

# Import the TIPLOC location data from the ATOC CIF file
import_tiploc = True

# Choose one of the below. They have different licences but
# basically hold the same data. And the ATOC CIF takes 5 minutes 
# to import whereas the NR JSON takes an hour.
import_atoc_schedule = True
import_nr_schedule = False