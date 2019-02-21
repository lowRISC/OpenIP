// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Thu Feb 21 15:09:09 2019
// Host        : brexit.cl.cam.ac.uk running 64-bit Ubuntu 16.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /local/scratch/jrrk2/ariane/fpga/xilinx/xlnx_proto_check/xlnx_proto_check.srcs/sources_1/ip/xlnx_proto_check/xlnx_proto_check_stub.v
// Design      : xlnx_proto_check
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

module xlnx_proto_check(
  output [159:0] pc_status,
  output         pc_asserted,
  input          aclk,
  input          aresetn,
  input [4:0]    pc_axi_awid,
  input [63:0]   pc_axi_awaddr,
  input [7:0]    pc_axi_awlen,
  input [2:0]    pc_axi_awsize,
  input [1:0]    pc_axi_awburst,
  input [0:0]    pc_axi_awlock,
  input [3:0]    pc_axi_awcache,
  input [2:0]    pc_axi_awprot,
  input [3:0]    pc_axi_awqos,
  input [3:0]    pc_axi_awregion,
  input [0:0]    pc_axi_awuser,
  input          pc_axi_awvalid,
  input          pc_axi_awready,
  input          pc_axi_wlast,
  input [63:0]   pc_axi_wdata,
  input [7:0]    pc_axi_wstrb,
  input [0:0]    pc_axi_wuser,
  input          pc_axi_wvalid,
  input          pc_axi_wready,
  input [4:0]    pc_axi_bid,
  input [1:0]    pc_axi_bresp,
  input [0:0]    pc_axi_buser,
  input          pc_axi_bvalid,
  input          pc_axi_bready,
  input [4:0]    pc_axi_arid,
  input [63:0]   pc_axi_araddr,
  input [7:0]    pc_axi_arlen,
  input [2:0]    pc_axi_arsize,
  input [1:0]    pc_axi_arburst,
  input [0:0]    pc_axi_arlock,
  input [3:0]    pc_axi_arcache,
  input [2:0]    pc_axi_arprot,
  input [3:0]    pc_axi_arqos,
  input [3:0]    pc_axi_arregion,
  input [0:0]    pc_axi_aruser,
  input          pc_axi_arvalid,
  input          pc_axi_arready,
  input [4:0]    pc_axi_rid,
  input          pc_axi_rlast,
  input [63:0]   pc_axi_rdata,
  input [1:0]    pc_axi_rresp,
  input [0:0]    pc_axi_ruser,
  input          pc_axi_rvalid,
  input          pc_axi_rready);
   
endmodule
