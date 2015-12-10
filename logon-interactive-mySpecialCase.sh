#!/bin/sh

qsub -W group_list=hyak-stf -I -V -l nodes=1:ppn=16
