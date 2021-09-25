import pdfplumber
from py_linq import Enumerable
import toml
import os
import src.utils as u
from pandas_data_analytics.text_parser.parser import Parser
import re
import pandas_data_analytics.text_parser.utils as tu
import time
start_time = time.time()

this_dir = os.path.dirname(os.path.realpath(__file__))
config = toml.load(os.path.join(this_dir, 'config.toml'))

u.set_full_paths(config, this_dir)
pdf_loc = config['file_locations']['data']
parser_settings = toml.load(config['file_locations']['parser_settings'])

result = tu.from_pdf_per_page_prom(pdf_loc, parser_settings)
print(result)

print("--- %s seconds ---" % (time.time() - start_time))
