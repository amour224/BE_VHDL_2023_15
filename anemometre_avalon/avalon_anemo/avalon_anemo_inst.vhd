	component avalon_anemo is
		port (
			bp_export                                          : in  std_logic_vector(1 downto 0) := (others => 'X'); -- export
			clk_clk                                            : in  std_logic                    := 'X';             -- clk
			in_freq_export                                     : in  std_logic                    := 'X';             -- export
			leds_export                                        : out std_logic_vector(7 downto 0);                    -- export
			avalon_anemometre_0_conduit_end_beginbursttransfer : in  std_logic                    := 'X'              -- beginbursttransfer
		);
	end component avalon_anemo;

	u0 : component avalon_anemo
		port map (
			bp_export                                          => CONNECTED_TO_bp_export,                                          --                              bp.export
			clk_clk                                            => CONNECTED_TO_clk_clk,                                            --                             clk.clk
			in_freq_export                                     => CONNECTED_TO_in_freq_export,                                     --                         in_freq.export
			leds_export                                        => CONNECTED_TO_leds_export,                                        --                            leds.export
			avalon_anemometre_0_conduit_end_beginbursttransfer => CONNECTED_TO_avalon_anemometre_0_conduit_end_beginbursttransfer  -- avalon_anemometre_0_conduit_end.beginbursttransfer
		);

