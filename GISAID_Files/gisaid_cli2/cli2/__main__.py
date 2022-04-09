"""
    Upload consensus sequences and metadata to GISAID's EpiCoV
    Copyright (C) 2021 Freunde von GISAID e.V.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

DEFAULT_TOKEN = "./gisaid.authtoken"

from datetime import datetime
from pathlib import PurePath
import sys
import json

STARTTIME = datetime.now()
TAB = "\t"


def get_execution_time():
    "Print total runtime at end of run."
    print(f"\nTotal runtime (HRS:MIN:SECS): {str(datetime.now() - STARTTIME)}")

def args_parser():
    """
    Argument parser setup and build.
    """
    import argparse, textwrap
    parser = argparse.ArgumentParser(prog = "cli2",
                                     formatter_class = argparse.ArgumentDefaultsHelpFormatter,
                                     description="Version 2 Command Line Interface (CLI) for uploading sequence and metadata to GISAID.")
    subparser_args1 = argparse.ArgumentParser(add_help=False)
    subparser_args2 = argparse.ArgumentParser(add_help=False)
    subparser_args3 = argparse.ArgumentParser(add_help=False)
    subparser_args4 = argparse.ArgumentParser(add_help=False)
    subparser_args5 = argparse.ArgumentParser(add_help=False)
    subparser_args6 = argparse.ArgumentParser(add_help=False)
    subparser_args7 = argparse.ArgumentParser(add_help=False)
    subparser_args1.add_argument("--database", help="Target GISAID database.",
                                 default = "EpiCoV",
                                 choices = ["EpiCoV", "EpiFlu", "EpiRSV"])
    subparser_args2.add_argument("--token",
                                 help = "Authentication token.",
                                 default = DEFAULT_TOKEN)
    subparser_args3.add_argument("--username",
                                 help = "Your GISAID username.",
                                 required = True, type = str)
    subparser_args3.add_argument("--password",
                                 help = "Your GISAID password.  Leave blank on shared computers.",
                                 type = str)
    subparser_args4.add_argument("--debug",
                                 help = "Switch off debugging information (dev purposes only).",
                                 action = "store_false")
    subparser_args4.add_argument("--log",
                                 help = "All output logged here.",
                                 default = "./logfile.log")
    subparser_args5.add_argument("--client_id",
                                 help = "Submitter's client-ID. Email clisupport@gisaid.org to request client-ID.",
                                 required = True)
    subparser_args6.add_argument("--metadata",
                                 help = "The csv-formatted metadata file.",
                                 required = True)
    subparser_args6.add_argument("--fasta",
                                 help = "The fasta-formatted nucleotide sequences file.",
                                 required = True)
    subparser_args6.add_argument("--frameshift",
                                 help = "'catch_none': catch none of the frameshifts and release immediately; 'catch_all': catch all frameshifts and require email confirmation; 'catch_novel': catch novel frameshifts and require email confirmation.",
                                 choices = ["catch_all", "catch_novel", "catch_none"],
                                 default = "catch_all",
                                 required = False)
    subparser_args6.add_argument("--failed",
                                 help = "Name of CSV output to contain failed records.",
                                 default = "./failed.out")
    subparser_args7.add_argument("--proxy",
                                 help = "Proxy-configuration for HTTPS-Request in the form: http(s)://username:password@proxy:port.")


    subparser_modules = parser.add_subparsers(
        title="Sub-commands help", help="", metavar="", dest="subparser_name"
    )
    subparser_modules.add_parser(
        "authenticate",
        help="""Write the authentication token.""",
        description="Write the authentication token.",
        parents=[subparser_args1, subparser_args2, subparser_args3, subparser_args5, subparser_args7, subparser_args4],
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )

    subparser_modules.add_parser(
        "upload",
        help="""Upload sequences and metadata.""",
        description="Perform upload of sequences and metadata to GISAID's curation zone.",
        parents=[subparser_args1, subparser_args2, subparser_args6, subparser_args7, subparser_args4],
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )

    subparser_modules.add_parser("version",
                        help = "Show version and exit.")

    return parser



def main():
    """The main routine"""
    parser = args_parser()
    args = parser.parse_args()

    if parser.parse_args().subparser_name is None:
        print("usage: cli2 -h")
    elif args.subparser_name == "version":
        from cli2 import __version__
        print(f"cli2 version:{TAB}{__version__}")
    else:
        from cli2.handler import handle
        try:
            exit_code, logfile = handle(args)
        except KeyboardInterrupt:
            print("user interrupt")
            sys.exit(1)
        if args.log:
            with open(args.log, "a") as f:
                f.write(json.dumps(logfile, indent = 4))
        get_execution_time()
        sys.exit(exit_code) #no need to do this as python does this implicitly at this stage

if __name__ == "__main__":

    import doctest
    doctest.testmod()
    main()

