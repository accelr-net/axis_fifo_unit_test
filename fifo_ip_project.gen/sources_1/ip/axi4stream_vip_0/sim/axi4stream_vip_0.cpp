// (c) Copyright 1995-2023 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


#include "axi4stream_vip_0_sc.h"

#include "axi4stream_vip_0.h"

#include "axi_stream_vip.h"

#include <map>
#include <string>





#ifdef XILINX_SIMULATOR
axi4stream_vip_0::axi4stream_vip_0(const sc_core::sc_module_name& nm) : axi4stream_vip_0_sc(nm), aclk("aclk"), aresetn("aresetn"), m_axis_tvalid("m_axis_tvalid"), m_axis_tready("m_axis_tready"), m_axis_tdata("m_axis_tdata"), m_axis_tkeep("m_axis_tkeep"), m_axis_tlast("m_axis_tlast")
{

  // initialize pins
  mp_impl->aclk(aclk);
  mp_impl->aresetn(aresetn);

  // initialize transactors
  mp_M_AXIS_transactor = NULL;
  mp_m_axis_tlast_converter = NULL;
  mp_m_axis_tready_converter = NULL;
  mp_m_axis_tvalid_converter = NULL;

  // initialize socket stubs

}

void axi4stream_vip_0::before_end_of_elaboration()
{
  // configure 'M_AXIS' transactor

  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("axi4stream_vip_0", "M_AXIS_TLM_MODE") != 1)
  {
    // Instantiate Socket Stubs

  // 'M_AXIS' transactor parameters
    xsc::common_cpp::properties M_AXIS_transactor_param_props;
    M_AXIS_transactor_param_props.addLong("TDATA_NUM_BYTES", "1");
    M_AXIS_transactor_param_props.addLong("TDEST_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("TID_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("TUSER_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("HAS_TREADY", "1");
    M_AXIS_transactor_param_props.addLong("HAS_TSTRB", "0");
    M_AXIS_transactor_param_props.addLong("HAS_TKEEP", "1");
    M_AXIS_transactor_param_props.addLong("HAS_TLAST", "1");
    M_AXIS_transactor_param_props.addLong("FREQ_HZ", "100000000");
    M_AXIS_transactor_param_props.addLong("HAS_RESET", "1");
    M_AXIS_transactor_param_props.addFloat("PHASE", "0.0");
    M_AXIS_transactor_param_props.addString("CLK_DOMAIN", "");
    M_AXIS_transactor_param_props.addString("LAYERED_METADATA", "undef");
    M_AXIS_transactor_param_props.addLong("TSIDE_BAND_1_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("TSIDE_BAND_2_WIDTH", "0");

    mp_M_AXIS_transactor = new xtlm::xaxis_xtlm2pin_t<1,1,1,1,1,1>("M_AXIS_transactor", M_AXIS_transactor_param_props);

    // M_AXIS' transactor ports

    mp_M_AXIS_transactor->TDATA(m_axis_tdata);
    mp_M_AXIS_transactor->TKEEP(m_axis_tkeep);
    mp_m_axis_tlast_converter = new xsc::common::scalar2vectorN_converter<1>("m_axis_tlast_converter");
    mp_m_axis_tlast_converter->scalar_in(m_m_axis_tlast_converter_signal);
    mp_m_axis_tlast_converter->vector_out(m_axis_tlast);
    mp_M_AXIS_transactor->TLAST(m_m_axis_tlast_converter_signal);
    mp_m_axis_tready_converter = new xsc::common::vectorN2scalar_converter<1>("m_axis_tready_converter");
    mp_m_axis_tready_converter->vector_in(m_axis_tready);
    mp_m_axis_tready_converter->scalar_out(m_m_axis_tready_converter_signal);
    mp_M_AXIS_transactor->TREADY(m_m_axis_tready_converter_signal);
    mp_m_axis_tvalid_converter = new xsc::common::scalar2vectorN_converter<1>("m_axis_tvalid_converter");
    mp_m_axis_tvalid_converter->scalar_in(m_m_axis_tvalid_converter_signal);
    mp_m_axis_tvalid_converter->vector_out(m_axis_tvalid);
    mp_M_AXIS_transactor->TVALID(m_m_axis_tvalid_converter_signal);
    mp_M_AXIS_transactor->CLK(aclk);
    mp_M_AXIS_transactor->RST(aresetn);

    // M_AXIS' transactor sockets

    mp_impl->M_INITIATOR_socket->bind(*(mp_M_AXIS_transactor->socket));
  }
  else
  {
  }

}

#endif // XILINX_SIMULATOR




#ifdef XM_SYSTEMC
axi4stream_vip_0::axi4stream_vip_0(const sc_core::sc_module_name& nm) : axi4stream_vip_0_sc(nm), aclk("aclk"), aresetn("aresetn"), m_axis_tvalid("m_axis_tvalid"), m_axis_tready("m_axis_tready"), m_axis_tdata("m_axis_tdata"), m_axis_tkeep("m_axis_tkeep"), m_axis_tlast("m_axis_tlast")
{

  // initialize pins
  mp_impl->aclk(aclk);
  mp_impl->aresetn(aresetn);

  // initialize transactors
  mp_M_AXIS_transactor = NULL;
  mp_m_axis_tlast_converter = NULL;
  mp_m_axis_tready_converter = NULL;
  mp_m_axis_tvalid_converter = NULL;

  // initialize socket stubs

}

void axi4stream_vip_0::before_end_of_elaboration()
{
  // configure 'M_AXIS' transactor

  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("axi4stream_vip_0", "M_AXIS_TLM_MODE") != 1)
  {
    // Instantiate Socket Stubs

  // 'M_AXIS' transactor parameters
    xsc::common_cpp::properties M_AXIS_transactor_param_props;
    M_AXIS_transactor_param_props.addLong("TDATA_NUM_BYTES", "1");
    M_AXIS_transactor_param_props.addLong("TDEST_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("TID_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("TUSER_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("HAS_TREADY", "1");
    M_AXIS_transactor_param_props.addLong("HAS_TSTRB", "0");
    M_AXIS_transactor_param_props.addLong("HAS_TKEEP", "1");
    M_AXIS_transactor_param_props.addLong("HAS_TLAST", "1");
    M_AXIS_transactor_param_props.addLong("FREQ_HZ", "100000000");
    M_AXIS_transactor_param_props.addLong("HAS_RESET", "1");
    M_AXIS_transactor_param_props.addFloat("PHASE", "0.0");
    M_AXIS_transactor_param_props.addString("CLK_DOMAIN", "");
    M_AXIS_transactor_param_props.addString("LAYERED_METADATA", "undef");
    M_AXIS_transactor_param_props.addLong("TSIDE_BAND_1_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("TSIDE_BAND_2_WIDTH", "0");

    mp_M_AXIS_transactor = new xtlm::xaxis_xtlm2pin_t<1,1,1,1,1,1>("M_AXIS_transactor", M_AXIS_transactor_param_props);

    // M_AXIS' transactor ports

    mp_M_AXIS_transactor->TDATA(m_axis_tdata);
    mp_M_AXIS_transactor->TKEEP(m_axis_tkeep);
    mp_m_axis_tlast_converter = new xsc::common::scalar2vectorN_converter<1>("m_axis_tlast_converter");
    mp_m_axis_tlast_converter->scalar_in(m_m_axis_tlast_converter_signal);
    mp_m_axis_tlast_converter->vector_out(m_axis_tlast);
    mp_M_AXIS_transactor->TLAST(m_m_axis_tlast_converter_signal);
    mp_m_axis_tready_converter = new xsc::common::vectorN2scalar_converter<1>("m_axis_tready_converter");
    mp_m_axis_tready_converter->vector_in(m_axis_tready);
    mp_m_axis_tready_converter->scalar_out(m_m_axis_tready_converter_signal);
    mp_M_AXIS_transactor->TREADY(m_m_axis_tready_converter_signal);
    mp_m_axis_tvalid_converter = new xsc::common::scalar2vectorN_converter<1>("m_axis_tvalid_converter");
    mp_m_axis_tvalid_converter->scalar_in(m_m_axis_tvalid_converter_signal);
    mp_m_axis_tvalid_converter->vector_out(m_axis_tvalid);
    mp_M_AXIS_transactor->TVALID(m_m_axis_tvalid_converter_signal);
    mp_M_AXIS_transactor->CLK(aclk);
    mp_M_AXIS_transactor->RST(aresetn);

    // M_AXIS' transactor sockets

    mp_impl->M_INITIATOR_socket->bind(*(mp_M_AXIS_transactor->socket));
  }
  else
  {
  }

}

#endif // XM_SYSTEMC




#ifdef RIVIERA
axi4stream_vip_0::axi4stream_vip_0(const sc_core::sc_module_name& nm) : axi4stream_vip_0_sc(nm), aclk("aclk"), aresetn("aresetn"), m_axis_tvalid("m_axis_tvalid"), m_axis_tready("m_axis_tready"), m_axis_tdata("m_axis_tdata"), m_axis_tkeep("m_axis_tkeep"), m_axis_tlast("m_axis_tlast")
{

  // initialize pins
  mp_impl->aclk(aclk);
  mp_impl->aresetn(aresetn);

  // initialize transactors
  mp_M_AXIS_transactor = NULL;
  mp_m_axis_tlast_converter = NULL;
  mp_m_axis_tready_converter = NULL;
  mp_m_axis_tvalid_converter = NULL;

  // initialize socket stubs

}

void axi4stream_vip_0::before_end_of_elaboration()
{
  // configure 'M_AXIS' transactor

  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("axi4stream_vip_0", "M_AXIS_TLM_MODE") != 1)
  {
    // Instantiate Socket Stubs

  // 'M_AXIS' transactor parameters
    xsc::common_cpp::properties M_AXIS_transactor_param_props;
    M_AXIS_transactor_param_props.addLong("TDATA_NUM_BYTES", "1");
    M_AXIS_transactor_param_props.addLong("TDEST_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("TID_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("TUSER_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("HAS_TREADY", "1");
    M_AXIS_transactor_param_props.addLong("HAS_TSTRB", "0");
    M_AXIS_transactor_param_props.addLong("HAS_TKEEP", "1");
    M_AXIS_transactor_param_props.addLong("HAS_TLAST", "1");
    M_AXIS_transactor_param_props.addLong("FREQ_HZ", "100000000");
    M_AXIS_transactor_param_props.addLong("HAS_RESET", "1");
    M_AXIS_transactor_param_props.addFloat("PHASE", "0.0");
    M_AXIS_transactor_param_props.addString("CLK_DOMAIN", "");
    M_AXIS_transactor_param_props.addString("LAYERED_METADATA", "undef");
    M_AXIS_transactor_param_props.addLong("TSIDE_BAND_1_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("TSIDE_BAND_2_WIDTH", "0");

    mp_M_AXIS_transactor = new xtlm::xaxis_xtlm2pin_t<1,1,1,1,1,1>("M_AXIS_transactor", M_AXIS_transactor_param_props);

    // M_AXIS' transactor ports

    mp_M_AXIS_transactor->TDATA(m_axis_tdata);
    mp_M_AXIS_transactor->TKEEP(m_axis_tkeep);
    mp_m_axis_tlast_converter = new xsc::common::scalar2vectorN_converter<1>("m_axis_tlast_converter");
    mp_m_axis_tlast_converter->scalar_in(m_m_axis_tlast_converter_signal);
    mp_m_axis_tlast_converter->vector_out(m_axis_tlast);
    mp_M_AXIS_transactor->TLAST(m_m_axis_tlast_converter_signal);
    mp_m_axis_tready_converter = new xsc::common::vectorN2scalar_converter<1>("m_axis_tready_converter");
    mp_m_axis_tready_converter->vector_in(m_axis_tready);
    mp_m_axis_tready_converter->scalar_out(m_m_axis_tready_converter_signal);
    mp_M_AXIS_transactor->TREADY(m_m_axis_tready_converter_signal);
    mp_m_axis_tvalid_converter = new xsc::common::scalar2vectorN_converter<1>("m_axis_tvalid_converter");
    mp_m_axis_tvalid_converter->scalar_in(m_m_axis_tvalid_converter_signal);
    mp_m_axis_tvalid_converter->vector_out(m_axis_tvalid);
    mp_M_AXIS_transactor->TVALID(m_m_axis_tvalid_converter_signal);
    mp_M_AXIS_transactor->CLK(aclk);
    mp_M_AXIS_transactor->RST(aresetn);

    // M_AXIS' transactor sockets

    mp_impl->M_INITIATOR_socket->bind(*(mp_M_AXIS_transactor->socket));
  }
  else
  {
  }

}

#endif // RIVIERA




#ifdef VCSSYSTEMC
axi4stream_vip_0::axi4stream_vip_0(const sc_core::sc_module_name& nm) : axi4stream_vip_0_sc(nm),  aclk("aclk"), aresetn("aresetn"), m_axis_tvalid("m_axis_tvalid"), m_axis_tready("m_axis_tready"), m_axis_tdata("m_axis_tdata"), m_axis_tkeep("m_axis_tkeep"), m_axis_tlast("m_axis_tlast")
{
  // initialize pins
  mp_impl->aclk(aclk);
  mp_impl->aresetn(aresetn);

  // initialize transactors
  mp_M_AXIS_transactor = NULL;
  mp_m_axis_tlast_converter = NULL;
  mp_m_axis_tready_converter = NULL;
  mp_m_axis_tvalid_converter = NULL;

  // Instantiate Socket Stubs

  // configure M_AXIS_transactor
    xsc::common_cpp::properties M_AXIS_transactor_param_props;
    M_AXIS_transactor_param_props.addLong("TDATA_NUM_BYTES", "1");
    M_AXIS_transactor_param_props.addLong("TDEST_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("TID_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("TUSER_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("HAS_TREADY", "1");
    M_AXIS_transactor_param_props.addLong("HAS_TSTRB", "0");
    M_AXIS_transactor_param_props.addLong("HAS_TKEEP", "1");
    M_AXIS_transactor_param_props.addLong("HAS_TLAST", "1");
    M_AXIS_transactor_param_props.addLong("FREQ_HZ", "100000000");
    M_AXIS_transactor_param_props.addLong("HAS_RESET", "1");
    M_AXIS_transactor_param_props.addFloat("PHASE", "0.0");
    M_AXIS_transactor_param_props.addString("CLK_DOMAIN", "");
    M_AXIS_transactor_param_props.addString("LAYERED_METADATA", "undef");
    M_AXIS_transactor_param_props.addLong("TSIDE_BAND_1_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("TSIDE_BAND_2_WIDTH", "0");

    mp_M_AXIS_transactor = new xtlm::xaxis_xtlm2pin_t<1,1,1,1,1,1>("M_AXIS_transactor", M_AXIS_transactor_param_props);
  mp_M_AXIS_transactor->TDATA(m_axis_tdata);
  mp_M_AXIS_transactor->TKEEP(m_axis_tkeep);
  mp_m_axis_tlast_converter = new xsc::common::scalar2vectorN_converter<1>("m_axis_tlast_converter");
  mp_m_axis_tlast_converter->scalar_in(m_m_axis_tlast_converter_signal);
  mp_m_axis_tlast_converter->vector_out(m_axis_tlast);
  mp_M_AXIS_transactor->TLAST(m_m_axis_tlast_converter_signal);
  mp_m_axis_tready_converter = new xsc::common::vectorN2scalar_converter<1>("m_axis_tready_converter");
  mp_m_axis_tready_converter->vector_in(m_axis_tready);
  mp_m_axis_tready_converter->scalar_out(m_m_axis_tready_converter_signal);
  mp_M_AXIS_transactor->TREADY(m_m_axis_tready_converter_signal);
  mp_m_axis_tvalid_converter = new xsc::common::scalar2vectorN_converter<1>("m_axis_tvalid_converter");
  mp_m_axis_tvalid_converter->scalar_in(m_m_axis_tvalid_converter_signal);
  mp_m_axis_tvalid_converter->vector_out(m_axis_tvalid);
  mp_M_AXIS_transactor->TVALID(m_m_axis_tvalid_converter_signal);
  mp_M_AXIS_transactor->CLK(aclk);
  mp_M_AXIS_transactor->RST(aresetn);

  // initialize transactors stubs
  M_AXIS_transactor_initiator_socket_stub = nullptr;

}

void axi4stream_vip_0::before_end_of_elaboration()
{
  // configure 'M_AXIS' transactor
  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("axi4stream_vip_0", "M_AXIS_TLM_MODE") != 1)
  {
    mp_impl->M_INITIATOR_socket->bind(*(mp_M_AXIS_transactor->socket));
  
  }
  else
  {
    M_AXIS_transactor_initiator_socket_stub = new xtlm::xtlm_axis_initiator_stub("socket",0);
    M_AXIS_transactor_initiator_socket_stub->bind(*(mp_M_AXIS_transactor->socket));
    mp_M_AXIS_transactor->disable_transactor();
  }

}

#endif // VCSSYSTEMC




#ifdef MTI_SYSTEMC
axi4stream_vip_0::axi4stream_vip_0(const sc_core::sc_module_name& nm) : axi4stream_vip_0_sc(nm),  aclk("aclk"), aresetn("aresetn"), m_axis_tvalid("m_axis_tvalid"), m_axis_tready("m_axis_tready"), m_axis_tdata("m_axis_tdata"), m_axis_tkeep("m_axis_tkeep"), m_axis_tlast("m_axis_tlast")
{
  // initialize pins
  mp_impl->aclk(aclk);
  mp_impl->aresetn(aresetn);

  // initialize transactors
  mp_M_AXIS_transactor = NULL;
  mp_m_axis_tlast_converter = NULL;
  mp_m_axis_tready_converter = NULL;
  mp_m_axis_tvalid_converter = NULL;

  // Instantiate Socket Stubs

  // configure M_AXIS_transactor
    xsc::common_cpp::properties M_AXIS_transactor_param_props;
    M_AXIS_transactor_param_props.addLong("TDATA_NUM_BYTES", "1");
    M_AXIS_transactor_param_props.addLong("TDEST_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("TID_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("TUSER_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("HAS_TREADY", "1");
    M_AXIS_transactor_param_props.addLong("HAS_TSTRB", "0");
    M_AXIS_transactor_param_props.addLong("HAS_TKEEP", "1");
    M_AXIS_transactor_param_props.addLong("HAS_TLAST", "1");
    M_AXIS_transactor_param_props.addLong("FREQ_HZ", "100000000");
    M_AXIS_transactor_param_props.addLong("HAS_RESET", "1");
    M_AXIS_transactor_param_props.addFloat("PHASE", "0.0");
    M_AXIS_transactor_param_props.addString("CLK_DOMAIN", "");
    M_AXIS_transactor_param_props.addString("LAYERED_METADATA", "undef");
    M_AXIS_transactor_param_props.addLong("TSIDE_BAND_1_WIDTH", "0");
    M_AXIS_transactor_param_props.addLong("TSIDE_BAND_2_WIDTH", "0");

    mp_M_AXIS_transactor = new xtlm::xaxis_xtlm2pin_t<1,1,1,1,1,1>("M_AXIS_transactor", M_AXIS_transactor_param_props);
  mp_M_AXIS_transactor->TDATA(m_axis_tdata);
  mp_M_AXIS_transactor->TKEEP(m_axis_tkeep);
  mp_m_axis_tlast_converter = new xsc::common::scalar2vectorN_converter<1>("m_axis_tlast_converter");
  mp_m_axis_tlast_converter->scalar_in(m_m_axis_tlast_converter_signal);
  mp_m_axis_tlast_converter->vector_out(m_axis_tlast);
  mp_M_AXIS_transactor->TLAST(m_m_axis_tlast_converter_signal);
  mp_m_axis_tready_converter = new xsc::common::vectorN2scalar_converter<1>("m_axis_tready_converter");
  mp_m_axis_tready_converter->vector_in(m_axis_tready);
  mp_m_axis_tready_converter->scalar_out(m_m_axis_tready_converter_signal);
  mp_M_AXIS_transactor->TREADY(m_m_axis_tready_converter_signal);
  mp_m_axis_tvalid_converter = new xsc::common::scalar2vectorN_converter<1>("m_axis_tvalid_converter");
  mp_m_axis_tvalid_converter->scalar_in(m_m_axis_tvalid_converter_signal);
  mp_m_axis_tvalid_converter->vector_out(m_axis_tvalid);
  mp_M_AXIS_transactor->TVALID(m_m_axis_tvalid_converter_signal);
  mp_M_AXIS_transactor->CLK(aclk);
  mp_M_AXIS_transactor->RST(aresetn);

  // initialize transactors stubs
  M_AXIS_transactor_initiator_socket_stub = nullptr;

}

void axi4stream_vip_0::before_end_of_elaboration()
{
  // configure 'M_AXIS' transactor
  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("axi4stream_vip_0", "M_AXIS_TLM_MODE") != 1)
  {
    mp_impl->M_INITIATOR_socket->bind(*(mp_M_AXIS_transactor->socket));
  
  }
  else
  {
    M_AXIS_transactor_initiator_socket_stub = new xtlm::xtlm_axis_initiator_stub("socket",0);
    M_AXIS_transactor_initiator_socket_stub->bind(*(mp_M_AXIS_transactor->socket));
    mp_M_AXIS_transactor->disable_transactor();
  }

}

#endif // MTI_SYSTEMC




axi4stream_vip_0::~axi4stream_vip_0()
{
  delete mp_M_AXIS_transactor;
  delete mp_m_axis_tlast_converter;
  delete mp_m_axis_tready_converter;
  delete mp_m_axis_tvalid_converter;

}

#ifdef MTI_SYSTEMC
SC_MODULE_EXPORT(axi4stream_vip_0);
#endif

#ifdef XM_SYSTEMC
XMSC_MODULE_EXPORT(axi4stream_vip_0);
#endif

#ifdef RIVIERA
SC_MODULE_EXPORT(axi4stream_vip_0);
#endif

