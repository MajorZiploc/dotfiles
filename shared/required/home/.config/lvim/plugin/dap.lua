local dap = require('dap')

dap.adapters.python = {
  type = 'executable';
  -- TODO: change this to your venv python
  command = os.getenv('HOME') .. '/.pyenv/shims/python';
  -- TODO: in your venv: pip install debugpy
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function()
      -- TODO: change this to your venv python
      return os.getenv('HOME') .. '/.pyenv/shims/python'
    end;
  },
}
