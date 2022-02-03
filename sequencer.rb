use_osc "localhost", 4560


live_loop :getbool do
  use_real_time
  base = sync "/osc*/sec"
  set :baseBool, base[0]
  set :hihtBool, base[1]
  set :snareBool, base[2]
end

live_loop :getamp do
  use_real_time
  amp = sync "/osc*/amp"
  set :globalAmp, amp[0]
end



live_loop :_base do
  sync :start_base
  use_real_time
  bbool = get(:baseBool)
  bamp = get(:globalAmp)
  sample :bd_haus, amp: (bamp * 4) * bbool
  sleep 0.25
end

live_loop :_hiht do
  use_real_time
  cue :start_base
  hbool = get(:hihtBool)
  bamp = get(:globalAmp)
  sample :drum_cymbal_closed, amp: (bamp * 1.5) * hbool, rate: 2
  sleep 0.25
end

live_loop :_snare do
  use_real_time
  sbool = get(:snareBool)
  bamp = get(:globalAmp)
  with_fx :distortion do
    sample :drum_snare_soft, amp: (bamp * 1) * sbool, rate: 1.5, attack: 0, sustain: 1, release: 0
    sleep 0.25
  end
end





