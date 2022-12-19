#!/usr/bin/env python3
# https://github.com/d093w1z/polybar-now-playing

import dbus
import signal
import time
from unicodedata import east_asian_width

from polybarnowplaying import *

mdl = 0

if __name__ == '__main__':
    signal.signal(signal.SIGUSR1, handle_event)
    main(mdl)
