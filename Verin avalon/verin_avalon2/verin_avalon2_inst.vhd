	component verin_avalon2 is
		port (
			bp_external_connection_export                 : in  std_logic := 'X'; -- export
			clk_clk                                       : in  std_logic := 'X'; -- clk
			led_external_connection_export                : out std_logic;        -- export
			ver_component_0_clk_adc_writeresponsevalid_n  : out std_logic;        -- writeresponsevalid_n
			ver_component_0_cs_writeresponsevalid_n       : out std_logic;        -- writeresponsevalid_n
			ver_component_0_data_in_beginbursttransfer    : in  std_logic := 'X'; -- beginbursttransfer
			ver_component_0_out_pwm_writeresponsevalid_n  : out std_logic;        -- writeresponsevalid_n
			ver_component_0_out_sens_writeresponsevalid_n : out std_logic         -- writeresponsevalid_n
		);
	end component verin_avalon2;

	u0 : component verin_avalon2
		port map (
			bp_external_connection_export                 => CONNECTED_TO_bp_external_connection_export,                 --   bp_external_connection.export
			clk_clk                                       => CONNECTED_TO_clk_clk,                                       --                      clk.clk
			led_external_connection_export                => CONNECTED_TO_led_external_connection_export,                --  led_external_connection.export
			ver_component_0_clk_adc_writeresponsevalid_n  => CONNECTED_TO_ver_component_0_clk_adc_writeresponsevalid_n,  --  ver_component_0_clk_adc.writeresponsevalid_n
			ver_component_0_cs_writeresponsevalid_n       => CONNECTED_TO_ver_component_0_cs_writeresponsevalid_n,       --       ver_component_0_cs.writeresponsevalid_n
			ver_component_0_data_in_beginbursttransfer    => CONNECTED_TO_ver_component_0_data_in_beginbursttransfer,    --  ver_component_0_data_in.beginbursttransfer
			ver_component_0_out_pwm_writeresponsevalid_n  => CONNECTED_TO_ver_component_0_out_pwm_writeresponsevalid_n,  --  ver_component_0_out_pwm.writeresponsevalid_n
			ver_component_0_out_sens_writeresponsevalid_n => CONNECTED_TO_ver_component_0_out_sens_writeresponsevalid_n  -- ver_component_0_out_sens.writeresponsevalid_n
		);

