use_osc "localhost", 4560



live_loop :getbool do
  use_real_time
  base = sync "/osc*/sec"
  set :baseBool, base[0]
  set :hihtBool, base[1]
  set :snareBool, base[2]
  set :percBool, base[3]
end

live_loop :getamp do
  use_real_time
  amp = sync "/osc*/amp"
  set :globalAmp, amp[0]
end

live_loop :getrate do
  use_real_time
  rate = sync "/osc*/rate"
  set :brate, rate[0]
  set :hrate, rate[1]
  set :srate, rate[2]
  set :prate, rate[3]
end

live_loop :getbpm do
  use_real_time
  bpm = sync "/osc*/bpm"
  set :globalBpm, bpm[0]
  print(get(:globalBpm))
end






live_loop :_base do
  sync :start_base
  use_real_time
  bbool = get(:baseBool)
  bamp = get(:globalAmp)
  baserate = get(:brate)
  sample :bd_haus, amp: (bamp * 4) * bbool, rate: baserate
  sleep get(:globalBpm)
end

live_loop :_hiht do
  use_real_time
  cue :start_base
  hbool = get(:hihtBool)
  bamp = get(:globalAmp)
  hihtrate = get(:hrate)
  sample :drum_cymbal_closed, amp: (bamp * 1.5) * hbool, rate: hihtrate
  sleep get(:globalBpm)
end

live_loop :_snare do
  use_real_time
  sbool = get(:snareBool)
  bamp = get(:globalAmp)
  snarerate = get(:srate)
  sample :drum_snare_soft, amp: (bamp * 1) * sbool, rate: snarerate, attack: 0, sustain: 1, release: 0
  sleep get(:globalBpm)
end

live_loop :_perc do
  use_real_time
  cue :start_base
  pbool = get(:percBool)
  bamp = get(:globalAmp)
  percrate = get(:prate)
  sample :perc_snap, amp: (bamp * 1.5) * pbool, rate: percrate
  sleep get(:globalBpm)
end





