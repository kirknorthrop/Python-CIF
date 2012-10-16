# Copyright (c) 2012 Kirk Northrop
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in the 
# Software without restriction, including without limitation the rights to use, copy,
# modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so, subject to the 
# following conditions:
#
# The above copyright notice and this permission notice shall be included in all 
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
# PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
# FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
# DEALINGS IN THE SOFTWARE.

import json
import MySQLdb
import config
from string import capwords

# Set up your config in config.py.

db=MySQLdb.connect(host=config.db_host,user=config.db_user,passwd=config.db_password,db=config.db_database)
c=db.cursor()
i = 0

#############################
## ATOC TIPLOC Data Import ##
#############################

# Before we do the main insert, we want to use the ATOC db to get TIPLOC data.
if config.import_tiploc or config.import_atoc_schedule:
	atoc_data = open(config.atoc_file, 'r')
	for line in atoc_data:
		# If TIPLOC insert
		if line[0:2] == 'HD': # Header record
			print line
		
		elif line[0:2] == 'TI': # TIPLOC Insert
			if config.import_tiploc:
				db_values = {'tiploc': line[2:9],
							'nlc': line[11:17],
							'tps_description': capwords(line[18:44]),
							'stanox': line[44:49],
							'crs_code': line[53:56],
							'short_description': line[56:72]}

				c.execute('''INSERT INTO tiploc (tiploc, nlc, tps_description, stanox, crs_code, short_description) 
							VALUES (%(tiploc)s, %(nlc)s, %(tps_description)s, %(stanox)s, %(crs_code)s, %(short_description)s)''',
							db_values)
		
		elif line[0:2] == 'TA': # TIPLOC Delete
			# We don't expect too many of these.
			# TODO: Implement
			if config.import_tiploc:
				print line
		
		elif line[0:2] == 'TD': # TIPLOC Delete
			# We don't expect too many of these.
			# TODO: Implement
			if config.import_tiploc:
				print line
		
		elif line[0:2] == 'AA': # Associations
			# TODO: Implement
			if config.import_atoc_schedule:
				pass
				#print line
		
		elif line[0:2] == 'BS': # Basic Schedule
			if config.import_atoc_schedule:
				db_values = {'train_uid'	: line[3:9],
							'start_date'	: line[9:15],
							'end_date'		: line[15:21],
							'days_run'		: line[21:28],
							'bank_holiday_running'	: line[28:29],
							'train_status'	: line[29:30],
							'train_category': line[30:32],
							'train_identity': line[32:36],
							'headcode'		: line[36:40],
							'train_service_code'	: line[41:49],
							'portion_id'	: line[49:50],
							'power_type'	: line[50:53],
							'timing_load'	: line[53:57],
							'speed'			: line[57:60],
							'operating_characteristics'	: line[60:66],
							'train_class'	: line[66:67],
							'sleepers'		: line[67:68],
							'reservations'	: line[68:69],
							'catering_code'	: line[70:74],
							'service_branding'	: line[74:78],
							'stp_indicator'	: line[79:80]}

				dayno = 0
				for day in list(db_values['days_run']):
					db_values['day' + str(dayno)] = day
					dayno += 1

				c.execute('''INSERT INTO schedule (train_uid, start_date, end_date, runs_mo, runs_tu, runs_we, runs_th, runs_fr, runs_sa, runs_su, bank_holiday_running, train_status, train_category, train_identity, headcode, train_service_code, portion_id, power_type, timing_load, speed, operating_characteristics, train_class, sleepers, reservations, catering_code, service_branding, stp_indicator) 
							VALUES (%(train_uid)s, %(start_date)s, %(end_date)s, %(day0)s, %(day1)s, %(day2)s, %(day3)s, %(day4)s, %(day5)s, %(day6)s, %(bank_holiday_running)s, %(train_status)s, %(train_category)s, %(train_identity)s, %(headcode)s, %(train_service_code)s, %(portion_id)s, %(power_type)s, %(timing_load)s, %(speed)s, %(operating_characteristics)s, %(train_class)s, %(sleepers)s, %(reservations)s, %(catering_code)s, %(service_branding)s, %(stp_indicator)s)''',
							db_values)
		
		elif line[0:2] == 'BX': # Basic Schedule Extra Details
			# None of this data is of any particular interest to us.
			# TODO: Implement anyway for completeness
			if config.import_atoc_schedule:
				pass

		
		elif line[0:2] == 'TN': # Train specific note
			# Network Rail not yet implemented
			if config.import_atoc_schedule:
				print line
		
		elif line[0:2] == 'LO': # Location Origin
			if config.import_atoc_schedule:
				db_values = {'tiploc_code'		: line[2:9],
							'tiploc_instance'	: line[9:10],
							'departure'			: line[10:15],
							'public_departure'	: line[15:19],
							'platform'			: line[19:22],
							'line'				: line[22:25],
							'engineering_allowance'	: line[25:27],
							'pathing_allowance'	: line[27:29],
							'activity'			: line[29:41],
							'performance_allowance'	: line[41:43]}

				c.execute('''INSERT INTO locations (tiploc_code, tiploc_instance, departure, public_departure, platform, line, engineering_allowance, pathing_allowance, activity, performance_allowance) 
							VALUES (%(tiploc_code)s, %(tiploc_instance)s, %(departure)s, %(public_departure)s, %(platform)s, %(line)s, %(engineering_allowance)s, %(pathing_allowance)s, %(activity)s, %(performance_allowance)s)''',
							db_values)
		
		elif line[0:2] == 'LI': # Location Intermediate
			if config.import_atoc_schedule:
				db_values = {'tiploc_code'		: line[2:9],
							'tiploc_instance'	: line[9:10],
							'arrival'			: line[10:15],
							'departure'			: line[15:20],
							'pass'				: line[20:25],
							'public_arrival'	: line[25:29],
							'public_departure'	: line[29:33],
							'platform'			: line[33:36],
							'line'				: line[36:39],
							'path'				: line[39:42],
							'activity'			: line[42:54],
							'engineering_allowance'	: line[54:56],
							'pathing_allowance'	: line[56:58],
							'performance_allowance'	: line[58:60]}

				c.execute('''INSERT INTO locations (tiploc_code, tiploc_instance, arrival, departure, pass, public_arrival, public_departure, platform, line, path, activity, engineering_allowance, pathing_allowance, performance_allowance) 
							VALUES (%(tiploc_code)s, %(tiploc_instance)s, %(arrival)s, %(departure)s, %(pass)s, %(public_arrival)s, %(public_departure)s, %(platform)s, %(line)s, %(path)s, %(activity)s, %(engineering_allowance)s, %(pathing_allowance)s, %(performance_allowance)s)''',
							db_values)
		
		elif line[0:2] == 'LT': # Location Terminus
			if config.import_atoc_schedule:
				db_values = {'tiploc_code'		: line[2:9],
							'tiploc_instance'	: line[9:10],
							'arrival'			: line[10:15],
							'public_arrival'	: line[15:19],
							'platform'			: line[19:22],
							'path'				: line[22:25],
							'activity'			: line[25:37]}

				c.execute('''INSERT INTO locations (tiploc_code, tiploc_instance, arrival, public_arrival, platform, path, activity) 
							VALUES (%(tiploc_code)s, %(tiploc_instance)s, %(arrival)s, %(public_arrival)s, %(platform)s, %(path)s, %(activity)s)''',
							db_values)
		
		elif line[0:2] == 'CR': # Change en route
			# TODO: Implement
			if config.import_atoc_schedule:
				pass
				#print line
		
		elif line[0:2] == 'LN': # Location Note
			# Network Rail not yet implemented
			if config.import_atoc_schedule:
				print line
		
		elif line[0:2] == 'ZZ': # Trailer Record
			if config.import_atoc_schedule:
				print line

		i += 1
		if i % 1000 == 0:
			print "Imported to line ", str(i)
	atoc_data.close()

#############################################
## Network Rail Data Feeds Schedule Import ##
#############################################

if config.import_nr_schedule:

	delete_later = []

	nr_data = open(config.nr_file, 'r')
	for line in nr_data:
		jsonline = json.loads(line)
		if jsonline.keys()[0] == 'JsonTimetableV1': # File header
			pass
		elif jsonline.keys()[0] == 'JsonAssociationV1': # An association
			if False:
				json_inner = jsonline['JsonAssociationV1']
				dayno = 0
				for day in list(json_inner['assoc_days']):
					json_inner['day' + str(dayno)] = day
					dayno += 1

				# Do transaction type and diagram type
				
				if json_inner['CIF_stp_indicator'] == 'C':
					c.execute("DELETE FROM associations WHERE main_train_uid = %s AND assoc_train_uid = %s AND date_from = %s AND date_to = %s AND runs_mo = %s AND runs_tu = %s AND runs_we = %s AND runs_th = %s AND runs_fr = %s AND runs_sa = %s AND runs_su = %s AND location = %s AND base_location_suffix = %s AND assoc_location_suffix = %s", (json_inner['main_train_uid'], json_inner['assoc_train_uid'], json_inner['assoc_start_date'], json_inner['assoc_end_date'], json_inner['day0'], json_inner['day1'], json_inner['day2'], json_inner['day3'], json_inner['day4'], json_inner['day5'], json_inner['day6'], json_inner['location'], json_inner['base_location_suffix'], json_inner['assoc_location_suffix']))
				else:
					c.execute('''INSERT INTO associations (main_train_uid, assoc_train_uid, date_from, date_to, runs_mo, runs_tu, runs_we, runs_th, runs_fr, runs_sa, runs_su, category, date_indicator, location, base_location_suffix, assoc_location_suffix, stp_indicator)
								VALUES (%(main_train_uid)s, %(assoc_train_uid)s, %(assoc_start_date)s, %(assoc_end_date)s, %(day0)s, %(day1)s, %(day2)s, %(day3)s, %(day4)s, %(day5)s, %(day6)s, %(category)s, %(date_indicator)s, %(location)s, %(base_location_suffix)s, %(assoc_location_suffix)s, %(CIF_stp_indicator)s)''',
					  			json_inner)
		elif jsonline.keys()[0] == 'JsonScheduleV1': # A schedule line
			json_inner = jsonline['JsonScheduleV1']
			
			# First, get the nested schedule segment items back in the main dict
			for item in json_inner['schedule_segment']:
				json_inner[item] = json_inner['schedule_segment'][item]
			
			# Then delete the nested version
			del json_inner['schedule_segment']

			# Days stuff
			dayno = 0
			for day in list(json_inner['schedule_days_runs']):
				json_inner['day' + str(dayno)] = day
				dayno += 1

			if json_inner['CIF_stp_indicator'] == 'C':
				
				delete_later.append(json_inner)
				
			else: # TODO: Should check for the others
			
				# Separate out the schedule locations for future processing
				schedule_locations = json_inner['schedule_location']
				
				# Then delete the original
				del json_inner['schedule_location']

				# Then we can put it into the database
				c.execute('''INSERT INTO schedule (runs_mo, runs_tu, runs_we, runs_th, runs_fr, runs_sa, runs_su, train_uid, start_date, end_date, bank_holiday_running, train_status, train_category, headcode, power_type, timing_load, operating_characteristics, train_class, sleepers, reservations, catering_code, service_branding, stp_indicator, atoc_code, applicable_timetable, connection_indicator, business_sector, course_indicator)
							VALUES (%(day0)s, %(day1)s, %(day2)s, %(day3)s, %(day4)s, %(day5)s, %(day6)s, %(CIF_train_uid)s, %(schedule_start_date)s, %(schedule_end_date)s, %(CIF_bank_holiday_running)s, %(train_status)s, %(CIF_train_category)s, %(signalling_id)s, %(CIF_power_type)s, %(CIF_timing_load)s, %(CIF_operating_characteristics)s, %(CIF_train_class)s, %(CIF_sleepers)s, %(CIF_reservations)s, %(CIF_catering_code)s, %(CIF_service_branding)s, %(CIF_stp_indicator)s, %(atoc_code)s, %(applicable_timetable)s, %(CIF_connection_indicator)s, %(CIF_business_sector)s, %(CIF_course_indicator)s)''',
						  	json_inner)
				
				c.execute('SELECT id FROM schedule ORDER BY id DESC LIMIT 0, 1')
				id = c.fetchone()[0]

				for location in schedule_locations:
					# Location ones can often be missing
					# So we check them
					location['id'] = id
					location['location_type'] = location.get('location_type', None)
					location['tiploc_code'] = location.get('tiploc_code', None)
					location['tiploc_instance'] = location.get('tiploc_instance', None)
					location['arrival'] = location.get('arrival', None)
					location['public_arrival'] = location.get('public_arrival', None)
					location['pass'] = location.get('pass', None)
					location['departure'] = location.get('departure', None)
					location['public_departure'] = location.get('public_departure', None)
					location['platform'] = location.get('platform', None)
					location['line'] = location.get('line', None)
					location['path'] = location.get('path', None)
					location['engineering_allowance'] = location.get('engineering_allowance', None)
					location['pathing_allowance'] = location.get('pathing_allowance', None)
					location['performance_allowance'] = location.get('performance_allowance', None)
					location['activity'] = location.get('activity', None)
					location['public_call'] = location.get('public_call', None)
					location['actual_call'] = location.get('actual_call', None)
					location['order_time'] = location.get('order_time', None)

					c.execute('''INSERT INTO locations (id, location_type, tiploc_code, tiploc_instance, arrival, public_arrival, pass, departure, public_departure, platform, line, path, engineering_allowance, pathing_allowance, performance_allowance, activity, public_call, actual_call, order_time)
							VALUES (%(id)s, %(location_type)s, %(tiploc_code)s, %(tiploc_instance)s, %(arrival)s, %(public_arrival)s, %(pass)s, %(departure)s, %(public_departure)s, %(platform)s, %(line)s, %(path)s, %(engineering_allowance)s, %(pathing_allowance)s, %(performance_allowance)s, %(activity)s, %(public_call)s, %(actual_call)s, %(order_time)s)''',
						  	location)

		else:
			print jsonline.keys()[0]
		i += 1
		if i % 1000 == 0:
			print "Imported to line ", str(i)

	# Then do all the delete laters
	for later in delete_later:
		c.execute("SELECT id FROM schedule WHERE train_uid = %(CIF_train_uid)s AND start_date = %(schedule_start_date)s AND end_date = %(schedule_end_date)s",later)
		try:
			id = c.fetchone()[0]
			print "Deleted schedule ", str(id)

			# This is a deletion
			c.execute("DELETE FROM schedule WHERE runs_mo = %(day0)s AND runs_tu = %(day1)s AND runs_we = %(day2)s AND runs_th = %(day3)s AND runs_fr = %(day4)s AND runs_sa = %(day5)s AND runs_su = %(day6)s AND train_uid = %(CIF_train_uid)s AND start_date = %(schedule_start_date)s AND end_date = %(schedule_end_date)s",
						json_inner)
			
			c.execute("DELETE FROM locations WHERE id = %s", id)
		except TypeError: 
			pass

	nr_data.close()

db.close()