#import some needed things
import sys
from os.path import exists
import subprocess
import re

# Calls the R system specifying that commands come from file commands.R
# The commands.R provided with this assignment will read the file named
# data and will output a histogram of that data to the file pageshist,pdf

def runR( ):
    res = subprocess.call(['R', '-f', 'commands.R'])

# log2hist analyzes a log file to calculate the total number of pages
# printed by each user during the period represented by this log file,
# and uses R to produce a pdf file pageshist.pdf showing a histogram
# of these totals.  logfilename is a string which is the name of the
# log file to analyze.
#
    
def log2hist(logfilename):
#open the file
    log_file = open(logfilename)

#users list array    
    users_list = {}
    print_regex = re.compile('user:\s*(?P<user>.*)\s*printer:.*?pages:\s*(?P<pages>\d+)')

#check each part in the file
    for line in log_file:   
        x = print_regex.search(line)

#if statement to see what the person printed 
        if x:
            person = x.group('user').strip()
            print_pages = int(x.group('pages'))
            if person not in users_list:
                users_list[person] = print_pages
            else:
                users_list[person] += print_pages
    


#data file to write the results
    data = open('data', 'w+')

#loop writes the results
    for print_pages in users_list.values():
        data.write("%d\n" % print_pages)

#close the data file
    data.close()
    
#runs the runR funciton
    runR()

########################################################


if __name__ == '__main__':
#set the logfilename from argv
    script, logfilename = sys.argv

#if it does not exist, print an error statement 
    if not exists(logfilename):
        print "%r ERROR: This file does not exist" % logfilename
        sys.exit()

# run the log2hist function
    log2hist(logfilename)  