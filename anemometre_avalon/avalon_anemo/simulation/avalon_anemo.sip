set_global_assignment -entity "avalon_anemo" -library "lib_avalon_anemo" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "avalon_anemo" -library "lib_avalon_anemo" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "avalon_anemo" -library "lib_avalon_anemo" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_avalon_anemo" -name SPD_FILE [file join $::quartus(sip_path) "../avalon_anemo.spd"]
set_global_assignment -library "lib_avalon_anemo" -name MISC_FILE [file join $::quartus(sip_path) "../../avalon_anemo.qsys"]

set_global_assignment -library "lib_avalon_anemo" -name MISC_FILE [file join $::quartus(sip_path) "avalon_anemo.vhd"]
set_global_assignment -library "lib_avalon_anemo" -name MISC_FILE [file join $::quartus(sip_path) "submodules/avalon_anemo_RAM.hex"]
set_global_assignment -library "lib_avalon_anemo" -name MISC_FILE [file join $::quartus(sip_path) "submodules/avalon_anemo_RAM.vhd"]
set_global_assignment -library "lib_avalon_anemo" -name MISC_FILE [file join $::quartus(sip_path) "submodules/avalon_anemo_LEDS.vhd"]
set_global_assignment -library "lib_avalon_anemo" -name MISC_FILE [file join $::quartus(sip_path) "submodules/avalon_anemo_Jtag.vhd"]
