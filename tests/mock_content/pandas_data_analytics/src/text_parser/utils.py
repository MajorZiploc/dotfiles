import pdfplumber
from py_linq import Enumerable
from pandas_data_analytics.text_parser.parser import Parser


def from_pdf_bulk_read(pdf_loc, parser_settings):
  parser = Parser(parser_settings)
  with pdfplumber.open(pdf_loc) as pdf:
    all_txt = Enumerable(pdf.pages).aggregate(
        lambda acc, page: acc + page.extract_text(), "")
    result = parser.parse(all_txt)
    return result


def from_pdf_per_page(pdf_loc, parser_settings):
  # settings per page. returns a list of dicts. 1 per page
  # same info in each dict
  parser = Parser(parser_settings)
  with pdfplumber.open(pdf_loc) as pdf:
    result = Enumerable(pdf.pages)\
        .select(lambda page: page.extract_text())\
        .select(parser.parse)\
        .to_list()
    return result


def merge_dicts(d1, d2):
  # dicts must have the exact same keys
  # if values from d1 are None, then use d2's value
  d3 = {}
  for k, v in d1.items():
    if v is None or v == '':
      d3[k] = d2[k]
    else:
      d3[k] = v
  return d3


def from_pdf(pdf_loc, settings):
  parser = Parser(parser_settings)
  with pdfplumber.open(pdf_loc) as pdf:
    result = Enumerable(pdf.pages)\
        .select(lambda page: page.extract_text())\
        .select(parser.parse)\
        .aggregate(merge_dicts)
    return result


def from_txt(txt, settings):
  parser = Parser(parser_settings)
  result = parser.parse(txt)
  return result
