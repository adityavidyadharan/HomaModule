#!/usr/bin/python3

# Copyright (c) 2023 Homa Developers
#
# SPDX-License-Identifier: BSD-1-Clause

# This file provides a collection of functions that plot data generated
# by tthoma.py. Invoke with the --help option for more information.

from glob import glob
from optparse import OptionParser
import math
import matplotlib
import matplotlib.pyplot as plt
import os
from pathlib import Path
import re
import string
import sys

import plot

def backlog(data_file, plot_file):
    """
    Generates a plot of network backlog data produced by the "net"
    analyzer of tthoma.py.

    data_file:   Backlog data file generated by tthoma.py.
    plot_file:   Name of the file in which to output a plot.
    """
    global options

    cores = plot.get_numbers(data_file)
    if options.cores:
        cores = sorted(list(set(cores).intersection(options.cores)))
    columns = []
    core_names = []
    for core in cores:
        columns.append('Back%d' % core)
        core_names.append('C%02d' % core)
    times = plot.get_column(data_file, 'Time')
    xmax = max(times)
    ymax = plot.max_value(data_file, columns)

    ax = plot.start_plot(xmax, ymax, x_label='Time',
            y_label='KB In Flight For %s Cores' % (plot.node_name(data_file)))
    for i in range(len(columns)):
        ax.plot(times, plot.get_column(data_file, columns[i]),
                label=core_names[i], linewidth=0.8)
    ax.legend(loc='upper right', prop={'size': 9})
    plt.tight_layout()
    plt.savefig(plot_file)


def colors(plot_file):
    """
    Generates a plot displaying standard colors.

    plot_file:   Name of the file in which to output a plot.
    """

    plot.plot_colors(plot_file)

# Parse command-line options.
parser = OptionParser(description=
        'Reads data output by tthoma.py and generates a plot. func is '
        'the name of a function in this file, which will be invoked to '
        'generate a particular plot; args provide additional information to '
        'func if needed. Read the in-code documentation for the functions '
        'for details on what kinds of plots are available.',
        usage='%prog [options] func arg arg ...',
        conflict_handler='resolve')
parser.add_option('--cores', dest='cores', default=None,
        metavar='CORES', help='space-separated list of integer core numbers; '
        'plots will include data from these cores only, where appropriate')
(options, args) = parser.parse_args()

if options.cores != None:
    options.cores = list(map(int, options.cores.split(" ")))

if len(args) < 1:
    print('No func was specified')
    parser.print_help()
    exit(1)

if not args[0] in locals():
    print('There is no function %s' % (args[0]))
    parser.print_help()
    exit(1)

locals()[args[0]](*args[1:])