#ifndef IP_AXI4STREAM_VIP_1_H_
#define IP_AXI4STREAM_VIP_1_H_

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


#ifndef XTLM
#include "xtlm.h"
#endif
#ifndef SYSTEMC_INCLUDED
#include <systemc>
#endif

#if defined(_MSC_VER)
#define DllExport __declspec(dllexport)
#elif defined(__GNUC__)
#define DllExport __attribute__ ((visibility("default")))
#else
#define DllExport
#endif

#include "axi4stream_vip_1_sc.h"




#ifdef XILINX_SIMULATOR
class DllExport axi4stream_vip_1 : public axi4stream_vip_1_sc
{
public:

  axi4stream_vip_1(const sc_core::sc_module_name& nm);
  virtual ~axi4stream_vip_1();

  // module pin-to-pin RTL interface

  sc_core::sc_in< bool > aclk;
  sc_core::sc_in< bool > aresetn;
  sc_core::sc_in< sc_dt::sc_bv<1> > s_axis_tvalid;
  sc_core::sc_out< sc_dt::sc_bv<1> > s_axis_tready;
  sc_core::sc_in< sc_dt::sc_bv<8> > s_axis_tdata;
  sc_core::sc_in< sc_dt::sc_bv<1> > s_axis_tkeep;
  sc_core::sc_in< sc_dt::sc_bv<1> > s_axis_tlast;

  // Dummy Signals for IP Ports


protected:

  virtual void before_end_of_elaboration();

private:

  xtlm::xaxis_pin2xtlm_t<1,1,1,1,1,1>* mp_S_AXIS_transactor;
  xsc::common::vectorN2scalar_converter<1>* mp_s_axis_tlast_converter;
  sc_signal< bool > m_s_axis_tlast_converter_signal;
  xsc::common::scalar2vectorN_converter<1>* mp_s_axis_tready_converter;
  sc_signal< bool > m_s_axis_tready_converter_signal;
  xsc::common::vectorN2scalar_converter<1>* mp_s_axis_tvalid_converter;
  sc_signal< bool > m_s_axis_tvalid_converter_signal;

};
#endif // XILINX_SIMULATOR




#ifdef XM_SYSTEMC
class DllExport axi4stream_vip_1 : public axi4stream_vip_1_sc
{
public:

  axi4stream_vip_1(const sc_core::sc_module_name& nm);
  virtual ~axi4stream_vip_1();

  // module pin-to-pin RTL interface

  sc_core::sc_in< bool > aclk;
  sc_core::sc_in< bool > aresetn;
  sc_core::sc_in< sc_dt::sc_bv<1> > s_axis_tvalid;
  sc_core::sc_out< sc_dt::sc_bv<1> > s_axis_tready;
  sc_core::sc_in< sc_dt::sc_bv<8> > s_axis_tdata;
  sc_core::sc_in< sc_dt::sc_bv<1> > s_axis_tkeep;
  sc_core::sc_in< sc_dt::sc_bv<1> > s_axis_tlast;

  // Dummy Signals for IP Ports


protected:

  virtual void before_end_of_elaboration();

private:

  xtlm::xaxis_pin2xtlm_t<1,1,1,1,1,1>* mp_S_AXIS_transactor;
  xsc::common::vectorN2scalar_converter<1>* mp_s_axis_tlast_converter;
  sc_signal< bool > m_s_axis_tlast_converter_signal;
  xsc::common::scalar2vectorN_converter<1>* mp_s_axis_tready_converter;
  sc_signal< bool > m_s_axis_tready_converter_signal;
  xsc::common::vectorN2scalar_converter<1>* mp_s_axis_tvalid_converter;
  sc_signal< bool > m_s_axis_tvalid_converter_signal;

};
#endif // XM_SYSTEMC




#ifdef RIVIERA
class DllExport axi4stream_vip_1 : public axi4stream_vip_1_sc
{
public:

  axi4stream_vip_1(const sc_core::sc_module_name& nm);
  virtual ~axi4stream_vip_1();

  // module pin-to-pin RTL interface

  sc_core::sc_in< bool > aclk;
  sc_core::sc_in< bool > aresetn;
  sc_core::sc_in< sc_dt::sc_bv<1> > s_axis_tvalid;
  sc_core::sc_out< sc_dt::sc_bv<1> > s_axis_tready;
  sc_core::sc_in< sc_dt::sc_bv<8> > s_axis_tdata;
  sc_core::sc_in< sc_dt::sc_bv<1> > s_axis_tkeep;
  sc_core::sc_in< sc_dt::sc_bv<1> > s_axis_tlast;

  // Dummy Signals for IP Ports


protected:

  virtual void before_end_of_elaboration();

private:

  xtlm::xaxis_pin2xtlm_t<1,1,1,1,1,1>* mp_S_AXIS_transactor;
  xsc::common::vectorN2scalar_converter<1>* mp_s_axis_tlast_converter;
  sc_signal< bool > m_s_axis_tlast_converter_signal;
  xsc::common::scalar2vectorN_converter<1>* mp_s_axis_tready_converter;
  sc_signal< bool > m_s_axis_tready_converter_signal;
  xsc::common::vectorN2scalar_converter<1>* mp_s_axis_tvalid_converter;
  sc_signal< bool > m_s_axis_tvalid_converter_signal;

};
#endif // RIVIERA




#ifdef VCSSYSTEMC
#include "utils/xtlm_axis_target_stub.h"

class DllExport axi4stream_vip_1 : public axi4stream_vip_1_sc
{
public:

  axi4stream_vip_1(const sc_core::sc_module_name& nm);
  virtual ~axi4stream_vip_1();

  // module pin-to-pin RTL interface

  sc_core::sc_in< bool > aclk;
  sc_core::sc_in< bool > aresetn;
  sc_core::sc_in< sc_dt::sc_bv<1> > s_axis_tvalid;
  sc_core::sc_out< sc_dt::sc_bv<1> > s_axis_tready;
  sc_core::sc_in< sc_dt::sc_bv<8> > s_axis_tdata;
  sc_core::sc_in< sc_dt::sc_bv<1> > s_axis_tkeep;
  sc_core::sc_in< sc_dt::sc_bv<1> > s_axis_tlast;

  // Dummy Signals for IP Ports


protected:

  virtual void before_end_of_elaboration();

private:

  xtlm::xaxis_pin2xtlm_t<1,1,1,1,1,1>* mp_S_AXIS_transactor;
  xsc::common::vectorN2scalar_converter<1>* mp_s_axis_tlast_converter;
  sc_signal< bool > m_s_axis_tlast_converter_signal;
  xsc::common::scalar2vectorN_converter<1>* mp_s_axis_tready_converter;
  sc_signal< bool > m_s_axis_tready_converter_signal;
  xsc::common::vectorN2scalar_converter<1>* mp_s_axis_tvalid_converter;
  sc_signal< bool > m_s_axis_tvalid_converter_signal;

  // Transactor stubs
  xtlm::xtlm_axis_target_stub * S_AXIS_transactor_target_socket_stub;

  // Socket stubs

};
#endif // VCSSYSTEMC




#ifdef MTI_SYSTEMC
#include "utils/xtlm_axis_target_stub.h"

class DllExport axi4stream_vip_1 : public axi4stream_vip_1_sc
{
public:

  axi4stream_vip_1(const sc_core::sc_module_name& nm);
  virtual ~axi4stream_vip_1();

  // module pin-to-pin RTL interface

  sc_core::sc_in< bool > aclk;
  sc_core::sc_in< bool > aresetn;
  sc_core::sc_in< sc_dt::sc_bv<1> > s_axis_tvalid;
  sc_core::sc_out< sc_dt::sc_bv<1> > s_axis_tready;
  sc_core::sc_in< sc_dt::sc_bv<8> > s_axis_tdata;
  sc_core::sc_in< sc_dt::sc_bv<1> > s_axis_tkeep;
  sc_core::sc_in< sc_dt::sc_bv<1> > s_axis_tlast;

  // Dummy Signals for IP Ports


protected:

  virtual void before_end_of_elaboration();

private:

  xtlm::xaxis_pin2xtlm_t<1,1,1,1,1,1>* mp_S_AXIS_transactor;
  xsc::common::vectorN2scalar_converter<1>* mp_s_axis_tlast_converter;
  sc_signal< bool > m_s_axis_tlast_converter_signal;
  xsc::common::scalar2vectorN_converter<1>* mp_s_axis_tready_converter;
  sc_signal< bool > m_s_axis_tready_converter_signal;
  xsc::common::vectorN2scalar_converter<1>* mp_s_axis_tvalid_converter;
  sc_signal< bool > m_s_axis_tvalid_converter_signal;

  // Transactor stubs
  xtlm::xtlm_axis_target_stub * S_AXIS_transactor_target_socket_stub;

  // Socket stubs

};
#endif // MTI_SYSTEMC
#endif // IP_AXI4STREAM_VIP_1_H_