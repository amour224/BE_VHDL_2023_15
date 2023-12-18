
module avalon_anemo (
	bp_export,
	clk_clk,
	in_freq_export,
	leds_export,
	avalon_anemometre_0_conduit_end_beginbursttransfer);	

	input	[1:0]	bp_export;
	input		clk_clk;
	input		in_freq_export;
	output	[7:0]	leds_export;
	input		avalon_anemometre_0_conduit_end_beginbursttransfer;
endmodule
