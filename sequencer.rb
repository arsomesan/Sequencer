use_osc "localhost", 4560


live_loop :getbpm do
  use_real_time
  bpm = sync "/osc*/bpm"
  set :globalBpm, bpm[0]
  print(get(:globalBpm))
end

live_loop :getbool do
  use_real_time
  base = sync "/osc*/sec"
  set :baseBool, base[0]
  set :hihtBool, base[1]
  set :snareBool, base[2]
  set :percBool, base[3]
  set :mldyBool, base[4]
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

live_loop :getattk do
  use_real_time
  attack = sync "/osc*/attk"
  set :battk, attack[0]
  set :hattk, attack[1]
  set :sattk, attack[2]
  set :pattk, attack[3]
  set :mattk, attack[4]
end

live_loop :getrelease do
  use_real_time
  release = sync "/osc*/rel"
  set :brel, release[0]
  set :hrel, release[1]
  set :srel, release[2]
  set :prel, release[3]
  set :mrel, release[4]
end

live_loop :getmldy do
  use_real_time
  melody = sync "/osc*/mldy"
  set :tune, melody[0]
end

live_loop :getslicer do
  use_real_time
  slicer = sync "/osc*/slice"
  set :slicerwave, slicer[0]
  set :slicerbool, slicer[1]
end


live_loop :_base do
  sync :start_base
  use_real_time
  bbool = get(:baseBool)
  bamp = get(:globalAmp)
  baserate = get(:brate)
  sample :bd_haus, amp: (bamp * 4) * bbool, rate: baserate, attack: get(:battk), release: get(:brel)
  sleep get(:globalBpm)
end

live_loop :_hiht do
  use_real_time
  cue :start_base
  hbool = get(:hihtBool)
  bamp = get(:globalAmp)
  hihtrate = get(:hrate)
  sample :drum_cymbal_closed, amp: (bamp * 1.5) * hbool, rate: hihtrate, attack: get(:hattk), release: get(:hrel)
  sleep get(:globalBpm)
end

live_loop :_snare do
  use_real_time
  sbool = get(:snareBool)
  bamp = get(:globalAmp)
  snarerate = get(:srate)
  sample :drum_snare_soft, amp: (bamp * 1) * sbool, rate: snarerate, attack: get(:sattk), sustain: 1, release: get(:srel)
  sleep get(:globalBpm)
end

live_loop :_perc do
  use_real_time
  cue :start_base
  pbool = get(:percBool)
  bamp = get(:globalAmp)
  percrate = get(:prate)
  sample :perc_snap, amp: (bamp * 1.5) * pbool, rate: percrate, attack: get(:pattk), release: get(:prel)
  sleep get(:globalBpm)
end


live_loop :_melody do
  use_real_time
  cue :start_base
  bamp = get(:globalAmp)
  mbool = get(:mldyBool)
  with_fx :slicer, phase: 0.25, wave: get(:slicerwave), mix: get(:slicerbool) do
    play get(:tune), amp: (bamp * 0.5) * mbool, attack: get(:mattk), decay: get(:mrel)
    sleep get(:globalBpm)
  end
end







