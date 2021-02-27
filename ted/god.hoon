/-  spider, nist
/+  *strandio, *graph-store, *resource
=,  strand=strand:spider
=,  strand-fail=strand-fail:strand
=>
|%
++  url  "https://beacon.nist.gov/beacon/2.0/pulse/last"
++  file  /vocab/txt
++  pulse-to-value
  =<
  |=  jon=json
  =/  m  (strand ,@ux)
  ^-  form:m
  =/  pul  `pulse:nist`(parser jon)
  =/  val  (rash local-random-value:pul hex)
  (pure:m val)
  :: json pulse parser
  =,  dejs:format
  |%
  ++  parser
    %-  ot
    :~  ['pulse' pulse]
    ==
  ++  pulse
    %-  ot
    :~  ['uri' so]
        ['version' so]
        ['cipherSuite' ni]
        ['period' ni]
        ['certificateId' so]
        ['chainIndex' ni]
        ['pulseIndex' ni]
        ['timeStamp' so]
        ['localRandomValue' so]
        ['external' external]
        ['listValues' (ar list-value)]
        ['precommitmentValue' so]
        ['statusCode' ni]
        ['signatureValue' so]
        ['outputValue' so]
    ==
  ++  external
    %-  ot
    :~  ['sourceId' so]
        ['statusCode' ni]
        ['value' so]
    ==
  ++  list-value
    %-  ot
    :~  ['uri' so]
        ['type' so]
        ['value' so]
        ==
  --
++  get-words
  |=  [=cage val=@ux]
  =/  m  (strand ,@t)
  ^-  form:m
  =/  wordlist  !<  wain  +:cage
    :: derive 16 random numbers from NIST entropy
  =/  nums
  %-  head
  %^  spin  (reap 16 0)
     ~(. og val)
  |=([n=@ud rng=_og] (rads:rng 7.568))
  :: index the numbers
  =/  nums
  %-  head
  %^  spin  nums
    1
  |=([n=@ud a=@ud] [[a n] +(a)])
  :: sort numbers smallest to largest
  =.  nums
  %+  sort  nums
  |=(a=[[@ud @ud] [@ud @ud]] (lth ->:a +>:a))
  :: get words from wordlist
  =|  count=@ud
  =|  words=(list [@ud @t])
  =.  words
  |-
  ?~  nums
  words
  %=  $
    wordlist  +:wordlist
    words  ?:(=(count ->:nums) [[-<:nums -:wordlist] words] words)
    nums  ?:(=(count ->:nums) +:nums nums)
    count  +(count)
  ==
  :: unsort words
  =.  words
  %+  sort  words
  |=(a=[[@ud @t] [@ud @t]] (lth -<:a +<:a))
  :: remove index and convert each cord to tape
  =/  words=(list tape)
  (turn words |=(a=[@ud @t] (trip +:a)))
  :: compose sentence and convert to cord
  =/  msg=@t
  (crip (zing (join " " ["God Says..." words])))
  :: return result
  (pure:m msg)
++  make-post
  |=  [our=ship now=@da res=resource msg=@t]
  =/  m  (strand ,cage)
  ^-  form:m
  :: compose post
  =/  =post  *post
  =:  author.post     our
      index.post      ~[now]
      time-sent.post  now
      contents.post   ~[[%text msg]]
  ==
  :: compose cage for poke
  =/  pst
  ^-  cage
  :-  %graph-update
  !>  ^-  update
  :+  %0  now
  :+  %add-nodes  res
  %-  ~(gas by *(map index node))
  ~[[[now]~ [post [%empty ~]]]]
  :: return result
  (pure:m pst)
--
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
=/  ures  !<  (unit resource)  arg
?~  ures
  (strand-fail %no-arg ~)
=/  res  u.ures
;<  jon=json  bind:m  ((set-timeout ,json) ~s10 (fetch-json url))
;<  val=@ux   bind:m  (pulse-to-value jon)
;<  our=ship  bind:m  get-our
;<  now=@da   bind:m  get-time
;<  wl=cage   bind:m  (read-file [our %home [%da now]] file)
;<  msg=@t    bind:m  (get-words wl val)
;<  pst=cage  bind:m  (make-post our now res msg)
;<  ~         bind:m  (poke [our %graph-push-hook] pst)
(pure:m !>(~))
