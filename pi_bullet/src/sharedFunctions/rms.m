function y = rms (varargin)

# Taken from: https://stackoverflow.com/questions/42583070/octave-rms-function-not-recognized
  if (nargin != 1 && nargin != 2)
    print_usage ();
  endif
  y = sqrt (meansq (varargin{:}));
endfunction