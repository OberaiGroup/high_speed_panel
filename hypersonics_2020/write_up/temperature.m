
function T = temperature( t, T_0, T_f, t_ss, t_flight)
  
  t_in_flight = mod( t, t_flight);

  dTdt = (T_f - T_0)/(t_ss - 0.0);

  t_start_landing = t_flight - t_ss;

  if t_in_flight < t_ss
    T = T_0 + dTdt * t_in_flight;
  elseif t_in_flight < t_start_landing
    T = T_f;
  else 
    t_landing = t_in_flight - t_start_landing;
    T = T_f - dTdt * t_landing;
  end
end
