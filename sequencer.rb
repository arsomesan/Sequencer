use_osc "localhost", 4560


live_loop :getbpm do
  use_real_time
  bpm = sync "/osc*/bpm"
  set :globalBpm, bpm[0]
end

live_loop :getsynth do
  use_real_time
  synth = sync "/osc*/synth"
  set :synth, synth[0]
end


live_loop :getbool do
  use_real_time
  base = sync "/osc*/sec"
  set :baseBool, base[0]
  set :hihtBool, base[1]
  set :snareBool, base[2]
  set :percBool, base[3]
end

live_loop :getmldybool do
  use_real_time
  mldybool = sync "/osc*/mldytime"
  set :mldyBool1, mldybool[0]
  set :mldyBool2, mldybool[1]
  set :mldyBool3, mldybool[2]
  set :mldyBool4, mldybool[3]
  set :mldyBool5, mldybool[4]
  set :mldyBool6, mldybool[5]
  set :mldyBool7, mldybool[6]
  set :mldyBool8, mldybool[7]
end


live_loop :getamp do
  use_real_time
  amp = sync "/osc*/amp"
  set :globalAmp, amp[0]
  set :bamp, amp[1]
  set :hamp, amp[2]
  set :samp, amp[3]
  set :pamp, amp[4]
  set :mamp, amp[5]
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
  use_real_time
  bbool = get(:baseBool)
  baserate = get(:brate)
  sample :bd_klub, amp: (get(:globalAmp) * get(:bamp)) * bbool, rate: baserate, attack: get(:battk), release: get(:brel)
  sleep get(:globalBpm)
end

live_loop :_hiht do
  use_real_time
  hbool = get(:hihtBool)
  hihtrate = get(:hrate)
  sample :drum_cymbal_closed, amp: (get(:globalAmp) * get(:hamp)) * hbool, rate: hihtrate, attack: get(:hattk), release: get(:hrel)
  sleep get(:globalBpm)
end

live_loop :_snare do
  use_real_time
  sbool = get(:snareBool)
  snarerate = get(:srate)
  sample :drum_snare_soft, amp: (get(:globalAmp) * get(:samp)) * sbool, rate: snarerate, attack: get(:sattk), sustain: 1, release: get(:srel)
  sleep get(:globalBpm)
end

live_loop :_perc do
  use_real_time
  pbool = get(:percBool)
  percrate = get(:prate)
  sample :perc_snap, amp: (get(:globalAmp) * get(:pamp)) * pbool, rate: percrate, attack: get(:pattk), release: get(:prel)
  sleep get(:globalBpm)
end


live_loop :_melody do
  use_real_time
  bamp = get(:globalAmp)
  mbool = get(:mldyBool1)
  synth = get(:synth)
  with_fx :slicer, phase: 0.25, wave: get(:slicerwave), mix: get(:slicerbool) do
    if (mbool == 1)
      if (synth == 0)
        use_synth :piano
      end
      if (synth == 1)
        use_synth :prophet
      end
      if (synth == 2)
        use_synth :dark_ambience
      end
      if (synth == 3)
        use_synth :blade
      end
      play get(:tune), amp: (get(:globalAmp) * get(:mamp)) * mbool, attack: get(:mattk), decay: get(:mrel)
      sleep get(:globalBpm) * 2
    else
      sleep get(:globalBpm)
    end
    
  end
end

live_loop :_melody2 do
  use_real_time
  bamp = get(:globalAmp)
  mbool = get(:mldyBool2)
  synth = get(:synth)
  with_fx :slicer, phase: 0.25, wave: get(:slicerwave), mix: get(:slicerbool) do
    if (mbool == 1)
      if (synth == 0)
        use_synth :piano
      end
      if (synth == 1)
        use_synth :prophet
      end
      if (synth == 2)
        use_synth :dark_ambience
      end
      if (synth == 3)
        use_synth :blade
      end
      play get(:tune), amp: (get(:globalAmp) * get(:mamp)) * mbool, attack: get(:mattk), decay: get(:mrel)
      sleep get(:globalBpm) * 2
    else
      sleep get(:globalBpm)
    end
  end
end

live_loop :_melody3 do
  use_real_time
  bamp = get(:globalAmp)
  mbool = get(:mldyBool3)
  synth = get(:synth)
  with_fx :slicer, phase: 0.25, wave: get(:slicerwave), mix: get(:slicerbool) do
    if (mbool == 1)
      if (synth == 0)
        use_synth :piano
      end
      if (synth == 1)
        use_synth :prophet
      end
      if (synth == 2)
        use_synth :dark_ambience
      end
      if (synth == 3)
        use_synth :blade
      end
      play get(:tune), amp: (get(:globalAmp) * get(:mamp)) * mbool, attack: get(:mattk), decay: get(:mrel)
      sleep get(:globalBpm) * 2
    else
      sleep get(:globalBpm)
    end
  end
end

live_loop :_melody4 do
  use_real_time
  bamp = get(:globalAmp)
  mbool = get(:mldyBool4)
  synth = get(:synth)
  with_fx :slicer, phase: 0.25, wave: get(:slicerwave), mix: get(:slicerbool) do
    if (mbool == 1)
      if (synth == 0)
        use_synth :piano
      end
      if (synth == 1)
        use_synth :prophet
      end
      if (synth == 2)
        use_synth :dark_ambience
      end
      if (synth == 3)
        use_synth :blade
      end
      play get(:tune), amp: (get(:globalAmp) * get(:mamp)) * mbool, attack: get(:mattk), decay: get(:mrel)
      sleep get(:globalBpm) * 2
    else
      sleep get(:globalBpm)
    end
  end
end

live_loop :_melody5 do
  use_real_time
  bamp = get(:globalAmp)
  mbool = get(:mldyBool5)
  synth = get(:synth)
  with_fx :slicer, phase: 0.25, wave: get(:slicerwave), mix: get(:slicerbool) do
    if (mbool == 1)
      if (synth == 0)
        use_synth :piano
      end
      if (synth == 1)
        use_synth :prophet
      end
      if (synth == 2)
        use_synth :dark_ambience
      end
      if (synth == 3)
        use_synth :blade
      end
      play get(:tune), amp: (get(:globalAmp) * get(:mamp)) * mbool, attack: get(:mattk), decay: get(:mrel)
      sleep get(:globalBpm) * 2
    else
      sleep get(:globalBpm)
    end
    
  end
end

live_loop :_melody6 do
  use_real_time
  bamp = get(:globalAmp)
  mbool = get(:mldyBool6)
  synth = get(:synth)
  with_fx :slicer, phase: 0.25, wave: get(:slicerwave), mix: get(:slicerbool) do
    if (mbool == 1)
      if (synth == 0)
        use_synth :piano
      end
      if (synth == 1)
        use_synth :prophet
      end
      if (synth == 2)
        use_synth :dark_ambience
      end
      if (synth == 3)
        use_synth :blade
      end
      play get(:tune), amp: (get(:globalAmp) * get(:mamp)) * mbool, attack: get(:mattk), decay: get(:mrel)
      sleep get(:globalBpm) * 2
    else
      sleep get(:globalBpm)
    end
  end
end

live_loop :_melody7 do
  use_real_time
  bamp = get(:globalAmp)
  mbool = get(:mldyBool7)
  synth = get(:synth)
  with_fx :slicer, phase: 0.25, wave: get(:slicerwave), mix: get(:slicerbool) do
    if (mbool == 1)
      if (synth == 0)
        use_synth :piano
      end
      if (synth == 1)
        use_synth :prophet
      end
      if (synth == 2)
        use_synth :dark_ambience
      end
      if (synth == 3)
        use_synth :blade
      end
      play get(:tune), amp: (get(:globalAmp) * get(:mamp)) * mbool, attack: get(:mattk), decay: get(:mrel)
      sleep get(:globalBpm) * 2
    else
      sleep get(:globalBpm)
    end
  end
end

live_loop :_melody8 do
  use_real_time
  bamp = get(:globalAmp)
  mbool = get(:mldyBool8)
  synth = get(:synth)
  with_fx :slicer, phase: 0.25, wave: get(:slicerwave), mix: get(:slicerbool) do
    if (mbool == 1)
      if (synth == 0)
        use_synth :piano
      end
      if (synth == 1)
        use_synth :prophet
      end
      if (synth == 2)
        use_synth :dark_ambience
      end
      if (synth == 3)
        use_synth :blade
      end
      play get(:tune), amp: (get(:globalAmp) * get(:mamp)) * mbool, attack: get(:mattk), decay: get(:mrel)
      sleep get(:globalBpm) * 2
    else
      sleep get(:globalBpm)
    end
  end
end







