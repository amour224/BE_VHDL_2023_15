
module verin_avalon2 (
	bp_external_connection_export,
	clk_clk,
	led_external_connection_export,
	ver_component_0_clk_adc_writeresponsevalid_n,
	ver_component_0_cs_writeresponsevalid_n,
	ver_component_0_data_in_beginbursttransfer,
	ver_component_0_out_pwm_writeresponsevalid_n,
	ver_component_0_out_sens_writeresponsevalid_n);	

	input		bp_external_connection_export;
	input		clk_clk;
	output		led_external_connection_export;
	output		ver_component_0_clk_adc_writeresponsevalid_n;
	output		ver_component_0_cs_writeresponsevalid_n;
	input		ver_component_0_data_in_beginbursttransfer;
	output		ver_component_0_out_pwm_writeresponsevalid_n;
	output		ver_component_0_out_sens_writeresponsevalid_n;
endmodule
