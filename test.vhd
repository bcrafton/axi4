

library ieee;
use ieee.std_logic_1164.all;
library commonlib;
use commonlib.types_common.all;
library ambalib;
use ambalib.types_amba4.all;

entity test is
end;

architecture arch_test of test is 

  constant master_in : nasti_master_in_type := (
    aw_ready => '0',
    w_ready =>  '0',
    b_valid =>  '0',
    b_resp =>   (others =>'0'),
    b_id =>     (others =>'0'),
    b_user =>   '0',
    ar_ready => '0',
    r_valid =>  '0',
    r_resp =>   (others =>'0'),
    r_data =>   (others =>'0'),
    r_last =>   '0',
    r_id =>     (others =>'0'),
    r_user =>   '0'
  );

  constant slave_in : nasti_slave_in_type := (
    aw_valid => '0',
    aw_bits =>  META_NONE,
    aw_id =>    (others =>'0'),
    aw_user =>  '0',

    w_valid =>  '0',
    w_data =>   (others =>'0'),
    w_last =>   '0',
    w_strb =>   (others =>'0'),
    w_user =>   '0',

    b_ready =>  '0',

    ar_valid => '0',
    ar_bits =>  META_NONE,
    ar_id =>    (others =>'0'),
    ar_user =>  '0',

    r_ready =>  '0'
  );

  COMPONENT master
  PORT(
    clk : in std_logic;
    mi : in nasti_master_in_type;
    mo : out nasti_master_out_type;
    cfg : out nasti_master_config_type
  );
  END COMPONENT;

  COMPONENT slave
  PORT(
    clk : in std_logic;
    si : in nasti_slave_in_type;
    so : out nasti_slave_out_type;
    cfg : out nasti_slave_config_type
  );
  END COMPONENT;

  -- inputs
  signal clk : std_logic := '0';

  signal mi : nasti_master_in_type := master_in; 
  signal si : nasti_slave_in_type := slave_in;

  -- outputs
  signal mo : nasti_master_out_type;
  signal so : nasti_slave_out_type;
  signal mcfg : nasti_master_config_type;
  signal scfg : nasti_slave_config_type;

  -- clk period
  constant clk_period : time := 1 us;

begin  

  m_uut : master PORT MAP(
    clk => clk,
    mi => mi,
    mo => mo,
    cfg => mcfg
  );

  s_uut : slave PORT MAP(
    clk => clk,
    si => si,
    so => so,
    cfg => scfg
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
