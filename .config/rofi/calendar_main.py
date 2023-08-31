import sys
from os import environ, getenv
from subprocess import call

import calendar_print

show_cal = True
selection = '<'

if len(sys.argv) > 1:
    if sys.argv[1] == '<':
        environ['ROFI_INFO'] = str( int(getenv('ROFI_INFO', '0')) - 1 )
    elif sys.argv[1] == '>':
        environ['ROFI_INFO'] = str( int(getenv('ROFI_INFO', '0')) + 1 )
        selection = '>'
    elif sys.argv[1] == '0':
        environ['ROFI_INFO'] = '0'
    else:
        show_cal = False
else:
    environ['ROFI_INFO'] = '0'
    show_cal = False

if show_cal:
    adjust = int(environ['ROFI_INFO'])
    string = calendar_print.main(adjust)
    lines = 7
    if string.count('\n') > 49:
        lines = 8
    highlight = ""
    if adjust == 0:
        highlight = "-a \"" + str(calendar_print.today_index()) + "\""
        print(highlight)
    call("echo -en \"" + string.replace('\n', "\\n") + "\"| rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry MousePrimary -select '" + selection + "' -l " + str(lines) + " " + highlight + " -theme ~/.config/rofi/calendar-uncreative.rasi | xargs python3 ~/.config/rofi/calendar_main.py", shell=True)

