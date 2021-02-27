|%
++  pulse
  $:  uri=@t
      version=@t
      cipher-suite=@ud
      period=@ud
      certificate-id=@t
      chain-index=@ud
      pulse-index=@ud
      time-stamp=@t
      local-random-value=@t
      =external
      list-values=(list list-value)
      precommitment-value=@t
      status-code=@ud
      signature-value=@t
      output-value=@t
  ==
++  external
  $:  source-id=@t
      status-code=@ud
      value=@t
  ==
++  list-value
  $:  uri=@t
      type=@t
      value=@t
  ==
--
