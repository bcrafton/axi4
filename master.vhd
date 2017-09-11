

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
  --mo.aw_bits <= '0';
  mo.aw_id <= conv_std_logic_vector(0, CFG_ROCKET_ID_BITS);
  mo.aw_user <= '0';

  mo.w_valid <= '1';
  -- mo.w_data = '0';
  mo.w_last <= '0';
  -- mo.w_strb = '0';
  mo.w_user <= '0';
  
  mo.b_ready <= '1';

  mo.ar_valid <= '1';
  -- mo.ar_bits = '00';
  mo.ar_id <= conv_std_logic_vector(0, CFG_ROCKET_ID_BITS);
  mo.ar_user <= '0';
  mo.r_ready <= '1';

  send_data : process(clk)
  begin
    if( rising_edge(clk) ) then
      -- report std_logic'image(mi.aw_ready);
      -- report std_logic'image(mo.aw_valid);
      if( mi.aw_ready = '1' ) then
        report "clock";
      end if;
    end if;
  end process;

end;
