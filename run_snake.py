#!/usr/bin/env python

import snakemake
from argparse import ArgumentParser
from sys import argv

parser = ArgumentParser()

parser.add_argument(
    "--cores",
    default=1,
    type=int,
    help="Number of CPU cores to use in this pipeline run (default %(default)s)")

parser.add_argument(
    "--target",
    action="append",
    help="Snakemake target(s). For multiple targets, can specify --target t1 --target t2 ...")


parser.add_argument(
    "--dry-run",
    help="If this argument is present, Snakemake will do a dry run of the pipeline",
    action="store_true")

def main():
    arg_lst = argv[1:]
    if not arg_lst:
        parser.print_help()
        return
    args = parser.parse_args(arg_lst)

    print(args)


    # if not snakemake.snakemake(
    #         'Snakefile',
    #         cores=args.cores,
    #         printshellcmds=True,
    #         dryrun=args.dry_run,
    #         targets=args.target
    #         ):
    #     raise ValueError("Pipeline failed, see Snakemake error message for details")

if __name__ == "__main__":
    main()