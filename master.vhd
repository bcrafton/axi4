

library ieee;
use ieee.std_logic_1164.all;
library commonlib;
use commonlib.types_common.all;
library ambalib;
use ambalib.types_amba4.all;

entity master is 
  Port(
    clk : in std_logic;
    mi : in nasti_master_in_type;
    mo : out nasti_master_out_type;
    cfg : out nasti_master_config_type
  );

end;

architecture arch_master of master is 

  constant config : nasti_master_config_type := (
     descrsize => PNP_CFG_MASTER_DESCR_BYTES,
     descrtype => PNP_CFG_TYPE_MASTER,
     vid => VENDOR_GNSSSENSOR,
     did => RISCV_CACHED_TILELINK
  );

begin  

  cfg <= config;
  mo.aw_valid <= '1';

  send_data : process(clk)
  begin
    if( rising_edge(clk) ) then
      report "clock";
    end if;
  end process;

end;
