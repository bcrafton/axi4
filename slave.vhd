

library ieee;
use ieee.std_logic_1164.all;
library commonlib;
use commonlib.types_common.all;
library ambalib;
use ambalib.types_amba4.all;

entity slave is
  generic (
    xaddr    : integer := 0;
    xmask    : integer := 16#fffff#
  ); 
  Port(
    clk : in std_logic;
    mi : in nasti_slave_in_type;
    mo : out nasti_slave_out_type;
    cfg : out nasti_slave_config_type
  );

end;

architecture arch_slave of slave is 

  constant config : nasti_slave_config_type := (
     descrtype => PNP_CFG_TYPE_SLAVE,
     descrsize => PNP_CFG_SLAVE_DESCR_BYTES,
     irq_idx => 0,
     xaddr => conv_std_logic_vector(xaddr, CFG_NASTI_CFG_ADDR_BITS),
     xmask => conv_std_logic_vector(xmask, CFG_NASTI_CFG_ADDR_BITS),
     vid => VENDOR_GNSSSENSOR,
     did => GNSSSENSOR_RF_CONTROL
  );

begin  

  cfg <= config;
  mo.aw_ready <= '1';

  check_valid : process(clk)
  begin
    if( rising_edge(clk) ) then
      report "clock";
    end if;
  end process;

end;
