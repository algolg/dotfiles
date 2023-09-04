import calendar
import sys

from datetime import date
from dateutil.relativedelta import relativedelta
from enum import Enum
from math import ceil
from textwrap import wrap

DAYS_START_AT = 14

def drop(list, n: int):
    del list[::n]
    return list

def main(month_adjust: int):
    today = date.today()
    adjusted = today + relativedelta(months=int(month_adjust))

    class Months(Enum):
        JA = 1
        FE = 2
        MR = 3
        AP = 4
        MY = 5
        JN = 6
        JL = 7
        AU = 8
        SE = 9
        OC = 10
        NV = 11
        DE = 12

    month = adjusted.month
    year = adjusted.year

    output = []

    header = Months(month).name + str(year)[2::] + "     T < >"
    output.extend(wrap(header, 2, replace_whitespace=False, drop_whitespace=False))

    days = "SuMoTuWeThFrSa"
    output.extend(wrap(days, 2))

    calendar.setfirstweekday(calendar.SUNDAY)
    output.extend(wrap(''.join(drop(list(calendar.month(int(year), int(month)).replace('\n', ' ').split("Sa")[1]), 3)), 2, replace_whitespace=False, drop_whitespace=False))
    
    prev_month = adjusted + relativedelta(months=-1)
    prev_month_disp = 0
    prev_month_days = calendar.monthrange(prev_month.year, prev_month.month)[1]
    for i in range(DAYS_START_AT, len(output)):
        if output[i] != "  ":
            break;
        prev_month_disp += 1
    for i in range(prev_month_disp):
        output[DAYS_START_AT+i] = str(prev_month_days - prev_month_disp + i + 1)

    next_month_day = 1
    for i in range(len(output), ceil(len(output)/7)*7):
            output.append(str(next_month_day))
            next_month_day += 1
    
    return '\n'.join(output)

def today_index():
    today = date.today().day
    cal = main(0).split('\n')[::-1]
    cal = [i.strip() for i in cal]
    return len(cal) - cal.index(str(today)) - 1

def not_this_month_indices(adjust):
    output = []
    cal = main(adjust).split('\n')
    ranges = []
    current = 1
    for i in range(DAYS_START_AT+1, len(cal)):
        if int(cal[i]) == 1 + int(cal[i-1]):
            current += 1
        else:
            ranges.append(current)
            current = 1
    ranges.append(current)

    if len(ranges) > 1:
        max_index = ranges.index(max(ranges))
        for i in range(0, max_index):
            output.append(str(DAYS_START_AT) + ":"
                          + str(DAYS_START_AT+ranges[i]))
        for i in range(max_index+1, len(ranges)):
            output.append(str(DAYS_START_AT + sum(ranges[:max_index+1]))
                          + ":")

    output_str = ""
    if len(output) > 0:
        output_str = "-u "
    output_str += ','.join(output)

    return output_str


if __name__ == '__main__':
    if len(sys.argv) > 1:
        print(main(sys.argv[1]))
    else:
        print("no arguments provided")

