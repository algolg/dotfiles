import calendar
import sys

from datetime import date
from dateutil.relativedelta import relativedelta
from enum import Enum
from textwrap import wrap

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

    output = ""

    header = Months(month).name + str(year)[2::] + "       < >"
    output = output + ( '\n'.join(wrap(header, 2, replace_whitespace=False, drop_whitespace=False)) )

    days = "SuMoTuWeThFrSa"
    output = output + '\n' + ('\n'.join(wrap(days, 2, replace_whitespace=False, drop_whitespace=False)) )

    calendar.setfirstweekday(calendar.SUNDAY)
    output = output + '\n' + ( '\n'.join(wrap(''.join(drop(list(calendar.month(int(year), int(month)).replace('\n', ' ').split("Sa")[1]), 3)), 2, replace_whitespace=False, drop_whitespace=False)) )

    return output

def today_index():
    today = date.today().day
    cal = main(0).split('\n')[::-1]
    return len(cal) - cal.index(str(today)) - 1

if __name__ == '__main__':
    if len(sys.argv) > 1:
        print(main(sys.argv[1]))
    else:
        print("no arguments provided")

