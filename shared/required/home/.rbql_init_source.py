import re
from typing import Optional, Callable

def is_iterable(thing):
  try:
    _ = [*thing]
    return True
  except:
    return False

def attempt(thing, action):
  try:
    if type(thing) is tuple:
      return action(*thing)
    return action(thing)
  except:
    return None

def _ltrim(s):
  return re.sub(r'^\s+', '', s)

def ltrim(s: str):
  return attempt(s, _ltrim)

def _rtrim(s):
  return re.sub(r'\s+$', '', s)

def rtrim(s: str):
  return attempt(s, _rtrim)

def _trim(s):
  return _ltrim(_rtrim(s))

def trim(s: str):
  return attempt(s, _trim)

def _clean_str(s):
  return trim(re.sub(r'\s+', ' ', s))

def clean_str(s: str):
  return attempt(s, _clean_str)

def _dedup(items, on):
  if (not on):
    return list({e for e in items})
  return list({on(e): e for e in items}.values())

def dedup(items: list, on: Optional[Callable]=None):
  return attempt((items, on), _dedup)

