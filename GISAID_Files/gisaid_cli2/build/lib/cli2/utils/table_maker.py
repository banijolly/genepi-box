"""
    This module does the heavy lifting of building the tables.
    Merge SARS-CoV-2 *.xls, *.xlsx and *.json files for NCBI biosample upload.
    Merge tables for SRA sample upload.
    Copyright (C) 2020 Dr Mark B Schultz dr.mark.schultz@gmail.com
    https://github.com/schultzm/gnb.git GNU Affero General Public License
    <https://www.gnu.org/licenses/>.
"""
import pandas as pd

class Table():
    def __init__(self, indata):
        self.indata = indata

    def gisaid_template(self, unknown):
        df = None
        try:
            df = pd.read_excel(self.indata, header=0, sheet_name=1)
        except:
            df = pd.read_csv(self.indata, header=0, sep=",")
        df.set_index("covv_virus_name", inplace=True)
        df = df.drop(df.index[0]) #drops the first row (=duplicated header) only if required ****
        df.replace("unknown", unknown, inplace=True)
        return df