import re

def attempt(thing, action):
  try:
    return action(thing)
  except:
    return None

def ltrim(s: str):
  return attempt(s, lambda s: re.sub(r'^\s+', '', s))

def rtrim(s: str):
  return attempt(s, lambda s: re.sub(r'\s+$', '', s))

def trim(s: str):
  return attempt(s, lambda s: ltrim(rtrim(s)))

def clean_str(s: str):
  return attempt(s, lambda s: trim(re.sub(r'\s+', ' ', s)))

