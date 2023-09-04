import sys
from math import ceil
from os import environ, getenv
from subprocess import call

import calendar_print

show_cal = True
selection = '<'

if len(sys.argv) > 1:
    match sys.argv[1]:
        case '<':
            environ['ROFI_INFO'] = str( int(getenv('ROFI_INFO', '0')) - 1 )
        case '>':
            environ['ROFI_INFO'] = str( int(getenv('ROFI_INFO', '0')) + 1 )
            selection = '>'
        case 'T':
            environ['ROFI_INFO'] = '0'
        case '0':
            environ['ROFI_INFO'] = '0'
        case _:
            show_cal = False
else:
    environ['ROFI_INFO'] = '0'
    show_cal = False

if show_cal:
    adjust = int(environ['ROFI_INFO'])
    string = calendar_print.main(adjust)
    lines = max( ceil((string.count('\n')+1)/7), 7 )
    highlight = ""
    if adjust == 0:
        highlight = "-a \"" + str(calendar_print.today_index()) + "\""
    unhighlight = calendar_print.not_this_month_indices(adjust)
    call("echo -en \"" + string.replace('\n', "\\n") + "\"| rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry MousePrimary -select '" + selection + "' -l " + str(lines) + " " + highlight + " " +  unhighlight + " -theme ~/.config/rofi/calendar-uncreative.rasi | xargs python3 ~/.config/rofi/calendar_main.py", shell=True)

