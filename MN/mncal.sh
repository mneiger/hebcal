#!/bin/bash

# usage
# mncal.sh Année-Hebraique

# ./hebcal --lang fr -e -E -l 50,51 -L -4,21 -m 50 -z CET -i -s | awk -f mnical.awk

.././hebcal --lang fr -e -E -l 50,51 -L -4,21 -m 50 -o -z CET -i -s -H $@ | awk ' 
BEGIN {
    print "BEGIN:VCALENDAR"
#   PRODID:-//Google Inc//Google Calendar 70.9054//EN
   print "VERSION:2.0"
   print "CALSCALE:GREGORIAN"
#   print "METHOD:PUBLISH
# X-WR-CALNAME:Hebcal
# X-WR-TIMEZONE:Europe/Brussels
# X-WR-CALDESC:Calendrier des fêtes juives correspondant au rite libéral\nInc
#  lue également le détail des parachiot et des noms des chabbatot\nCréé à par
# tir de http://www.hebcal.com/hebcal/
}
END {
   print "END:VCALENDAR"
}

  {
    print "BEGIN:VEVENT"
    split($1,d,".")
    ST=sprintf("%04d",d[3]) " " sprintf("%02d",d[2]) " " sprintf("%02d",d[1]) " 00 00 00"
    start=mktime(ST)
    end=start+24*3600l
    print "DTSTART;VALUE=DATE:" strftime("%Y%m%d",start) 
    print "DTEND;VALUE=DATE:" strftime("%Y%m%d",end) 
    print "DESCRIPTION:"
    print "LOCATION:"
    print "SEQUENCE:0"
    $1=""
    gsub(/^[ \t]+/, "", $0)
    print "SUMMARY:" $0 
#    print "CATEGORIES:http://schemas.google.com/g/2005#event"
    print "END:VEVENT"
  }
' 

