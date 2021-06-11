import re
from py_linq import Enumerable


def str_flags_to_regex_flags(str_flags):
  flag_map = {
      "i": re.IGNORECASE,
      "x": re.VERBOSE,
      "m": re.MULTILINE,
      "s": re.DOTALL,
      "u": re.UNICODE,
      "l": re.LOCALE,
      "d": re.DEBUG,
      "a": re.ASCII,
      "t": re.TEMPLATE
  }

  def r(acc, ele):
    acc = acc | ele
    return acc
  return Enumerable(str_flags)\
      .select(lambda f: flag_map[f])\
      .aggregate(r)


class Parser(object):

  def __init__(self, settings):
    self.settings = settings

  def parse(self, txt):
    result_dict = {}
    s = self.settings
    for v in s['fields']:
      ordered_groups = Enumerable(v.get('ordered_groups', [1]))
      pattern = (v['pattern'])
      m = re.search(pattern=pattern, string=txt,
                    flags=str_flags_to_regex_flags(v['flags']))
      res = v.get('group_join_symbol', '').join(
          ordered_groups.select(lambda i: m.group(i)).to_list())\
          if m is not None else ''
      result_dict[v['name']] = res
    return result_dict
