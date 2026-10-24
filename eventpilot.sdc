create_clock -name clk -period 20 [get_ports clk]
set_clock_uncertainty 0.2 [get_clocks clk]
set_input_delay 2.0 -clock clk [get_ports {event_req[*] ack rst_n}]
set_output_delay 2.0 -clock clk [get_ports {event_code[*] event_valid busy}]
