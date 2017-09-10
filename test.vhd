

library ieee;
use ieee.std_logic_1164.all;
library commonlib;
use commonlib.types_common.all;
library ambalib;
use ambalib.types_amba4.all;

entity test is
end;

architecture arch_test of test is 

  COMPONENT master
  PORT(
    clk : in std_logic;
    mi : in nasti_master_in_type;
    mo : out nasti_master_out_type;
    cfg : out nasti_master_config_type
  );
  END COMPONENT;

  -- inputs
  signal clk : std_logic := '0';


  -- outputs
  signal mo : nasti_master_out_type;
  signal cfg : nasti_master_config_type;

  -- clk period
  constant clk_period : time := 1 us;

begin  

  uut : master PORT MAP(
    clk => clk,
    mo => mo,
    cfg => cfg
  );

  clk_process : process begin
    clk <= '0';
    wait for clk_period;
    clk <= '1';
    wait for clk_period;
  end process;

  stim_process : process
  begin
    wait for 100 ms;
    wait for clk_period*10;
    wait;
  end process;

end;
