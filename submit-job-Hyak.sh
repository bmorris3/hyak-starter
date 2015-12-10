#!/bin/bash
## --------------------------------------------------------
## NOTE: to submit jobs to Hyak use
##       qsub <script.sh>
##
## #PBS is a directive requesting job scheduling resources
## and ALL PBS directives must be at the top of the script, 
## standard bash commands can follow afterwards.
## NOTE: Lines that begin with #PBS are commands to PBS,
##       and they are not comment lines.  To comment out
##       use "#  PBS".
## --------------------------------------------------------


## --------------------------------------------------------
## RENAME for your job
## --------------------------------------------------------
#PBS -N hyak-starter-test


## --------------------------------------------------------
## DIRECTORY where this job is run
## --------------------------------------------------------
#PBS -d /gscratch/stf/bmmorris/tmp/


## --------------------------------------------------------
## GROUP to run under, or run under BACKFILL
## --------------------------------------------------------
## PBS -q bf
## PBS -W group_list=hyak-stf
## PBS -W group_list=hyak-secretgroup
#PBS -q bf

## --------------------------------------------------------
## NUMBER nodes, CPUs per node, and MEMORY
## --------------------------------------------------------
#PBS -l nodes=1:ppn=16,feature=16core,mem=12gb
## PBS -l nodes=1:ppn=16,mem=12gb,feature=intel
## PBS -l nodes=2:ppn=16,mem=120gb,feature=intel
## PBS -l nodes=4:ppn=16,mem=250gb,feature=intel
## PBS -l nodes=8:ppn=16,mem=510gb,feature=intel
## PBS -l nodes=16:ppn=16,mem=1000gb,feature=intel

## --------------------------------------------------------
## WALLTIME (defaults to 1 hour as the minimum, specify > 1 hour longer jobs)
## --------------------------------------------------------
#PBS -l walltime=00:10:00


## --------------------------------------------------------
## LOG the (stderr and stdout) job output in the directory
## --------------------------------------------------------
#PBS -j oe -o /gscratch/stf/bmmorris/tmp


## --------------------------------------------------------
## EMAIL to send when job is aborted, begins, and terminates
## --------------------------------------------------------
## PBS -m abe -M dsale@uw.edu
#PBS -m abe -M bmmorris@uw.edu


## --------------------------------------------------------
## END of PBS commmands ... only BASH from here and below
## --------------------------------------------------------


## --------------------------------------------------------
## LOAD any appropriate environment modules and variables
## --------------------------------------------------------
## module load git_2.4.4
## module load icc_16.0.1-ompi_1.8.8


## --------------------------------------------------------
## DEBUGGING information (include jobs logs in any help requests)
## --------------------------------------------------------
## Total Number of nodes and processors (cores) to be used by the job
echo "== JOB DEBUGGING INFORMATION=========================="
HYAK_NNODES=$(uniq $PBS_NODEFILE | wc -l )
HYAK_NPE=$(wc -l < $PBS_NODEFILE)
echo "This job will run on $HYAK_NNODES nodes with $HYAK_NPE total CPU-cores"
echo ""
echo "Node:CPUs Used"
uniq -c $PBS_NODEFILE | awk '{print $2 ":" $1}'
echo ""
echo "ENVIRONMENT VARIABLES"
set
echo ""
echo "== END DEBUGGING INFORMATION  ========================"


## -------------------------------------------------------- 
## RUN your specific applications/scripts/code here
## -------------------------------------------------------- 

## CHANGE directory to where job was submitted (careful, PBS defaults to user home directory)
cd $PBS_O_WORKDIR

## SPECIFY some input variables
#myInputFile1="run-case-1"
#myInputFile2="run-case-2"
#executableFile = "/usr/lusers/bmmorris/git/hyak-starter/line.py"

## KEEP copy of the initial cleared solution (small file size), 
## and RENAME file used for restart after CHECKPOINTING (this file gets big) 
## cp --no-clobber $myInputFile1 runs.$myInputFile1

## RUN my simulation file in BATCH MODE (and make a log file!)
#./my-cool-code myInputFile1 2>&1 |tee log.$myInputFile1
python /usr/lusers/bmmorris/git/hyak-starter/line.py


