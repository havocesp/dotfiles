#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import glob
import os
import pathlib as path
import platform
import re

# from homely.general import (WHERE_END, WHERE_TOP, blockinfile, download, haveexecutable, include, lineinfile, mkdir, run, section, symlink)
                                    
# from homely.install import InstallFromSource, installpkg
# from homely.pipinstall import pipinstall
# from homely.system import execute
# from homely.ui import (InputError, allowinteractive, allowpull, head, note,
#                        warn, yesno)

HOME = path.Path.home()
HERE = path.Path(__file__).parent

print(HOME, HERE)

from 