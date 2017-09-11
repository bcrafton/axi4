

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

  COMPONENT axictrl
  PORT(
    i_clk    : in std_logic;
    i_nrst   : in std_logic;
    i_slvcfg : in  nasti_slave_cfg_vector;
    i_slvo   : in  nasti_slaves_out_vector;
    i_msto   : in  nasti_master_out_vector;
    o_slvi   : out nasti_slave_in_vector;
    o_msti   : out nasti_master_in_vector;
    o_miss_irq  : out std_logic;
    o_miss_addr : out std_logic_vector(CFG_NASTI_ADDR_BITS-1 downto 0);
    o_bus_util_w : out std_logic_vector(CFG_NASTI_MASTER_TOTAL-1 downto 0);
    o_bus_util_r : out std_logic_vector(CFG_NASTI_MASTER_TOTAL-1 downto 0)
  );
  END COMPONENT;

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
  --signal mi : nasti_master_in_type := master_in; 
  --signal si : nasti_slave_in_type := slave_in;
  signal slv_cfg : nasti_slave_cfg_vector;
  signal axiso   : nasti_slaves_out_vector;
  signal aximo   : nasti_master_out_vector;
  signal axisi   : nasti_slave_in_vector;
  signal aximi   : nasti_master_in_vector;

  -- passthrough
  signal mi : nasti_master_in_type; 
  signal si : nasti_slave_in_type;

  -- outputs
  signal mo : nasti_master_out_type;
  signal so : nasti_slave_out_type;
  signal mcfg : nasti_master_config_type;
  signal scfg : nasti_slave_config_type;

  signal o_miss_irq  : std_logic;
  signal o_miss_addr : std_logic_vector(CFG_NASTI_ADDR_BITS-1 downto 0);
  signal o_bus_util_w : std_logic_vector(CFG_NASTI_MASTER_TOTAL-1 downto 0);
  signal o_bus_util_r : std_logic_vector(CFG_NASTI_MASTER_TOTAL-1 downto 0);

  -- clk period
  constant clk_period : time := 1 us;

begin  

  slv_cfg(0) <= scfg;
  axiso(0) <= so;
  aximo(0) <= mo;
  si <= axisi(0);
  mi <= aximi(0);

  a_uut : axictrl PORT MAP(
    i_clk    => clk,
    i_nrst   => '0',

    i_slvcfg => slv_cfg,
    i_slvo   => axiso,
    i_msto   => aximo,
    o_slvi   => axisi,
    o_msti   => aximi,
    o_miss_irq  => o_miss_irq,
    o_miss_addr => o_miss_addr,
    o_bus_util_w => o_bus_util_w,
    o_bus_util_r => o_bus_util_r
  );

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
