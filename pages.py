#Meesun Park CS 314 Spring 2016

# version 3:  log file name is now a command line argument.
#             You may hard code the name "log" if you prefer. See last comment
#              of file.

import sys             # version 3
import subprocess
import re

# Calls the R system specifying that commands come from file commands.R
# The commands.R provided with this assignment will read the file named
# data and will output a histogram of that data to the file pageshist.pdf
def runR( ):
    res = subprocess.call(['R', '-f', 'commands.R'])

# log2hist analyzes a log file to calculate the total number of pages
# printed by each user during the period represented by this log file,
# and uses R to produce a pdf file pageshist.pdf showing a histogram
# of these totals.  logfilename is a string which is the name of the
# log file to analyze.
#
def log2hist(logfilename):
    # fill in your code here
    inputF = open(logfilename, 'r')

    users = {}

    for eachLine in inputF:
    	#takes line into user and pages
    	line = re.search('user:\s*(?P<user>.*)\s*printer:.*?pages:\s*(?P<pages>\d+)', eachLine)
    	
    	#only if line has the components from earlier
    	if line:
    		userName = line.group('user')
    		userName.strip()
    		pageCount = int(line.group('pages'))
    		
    		#either adds pageCount and userName to dict
    		#or adds the number into already entry
    		if userName in users:
    			users[userName] += pageCount

    		else:
    			users[userName] = pageCount

    data = open('data', 'w+')

    #adds all the pagecounts from user dict
    for pageCount in users.values():
    	data.write('%d\n' % pageCount)

    data.close()
    inputF.close()

    runR()

    return 

if __name__ == '__main__':
    log2hist(sys.argv[1])  # version 2.

# line above may be changed to log2hist("log")

