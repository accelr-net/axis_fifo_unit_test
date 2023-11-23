-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Fri Nov 17 11:01:02 2023
-- Host        : sachith-Inspiron-16-5620 running 64-bit Ubuntu 22.04.3 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /tools/Xilinx/Vivado/2022.2/bin/fifo_ip_project/fifo_ip_project.gen/sources_1/ip/axi4stream_vip_0/axi4stream_vip_0_stub.vhdl
-- Design      : axi4stream_vip_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k70tfbv676-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity axi4stream_vip_0 is
  Port ( 
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    m_axis_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tlast : out STD_LOGIC_VECTOR ( 0 to 0 )
  );

end axi4stream_vip_0;

architecture stub of axi4stream_vip_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "aclk,aresetn,m_axis_tvalid[0:0],m_axis_tready[0:0],m_axis_tdata[7:0],m_axis_tlast[0:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "axi4stream_vip_v1_1_13_top,Vivado 2022.2";
begin
end;
