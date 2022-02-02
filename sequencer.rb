use_osc "localhost", 4560


live_loop :getbool do
  base = sync "/osc*/sec"
  set :baseBool, base[0]
  set :hihtBool, base[1]
end


live_loop :_base do
  bbool = get(:baseBool)
  sample :bd_haus, amp: 1 * bbool
  sleep 0.25
end

live_loop :_hiht do
  hbool = get(:hihtBool)
  sample :drum_cymbal_closed, amp: 1 * hbool
  sleep 0.25
end





