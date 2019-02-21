// Copyright 2014-2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Engineer:       Jonathan Kimmitt
// Create Date:    20/02/2019
// Module Name:    axi_xbar_wrapper
// Project Name:   PULP
// Language:       SystemVerilog
//
// Description: Dummy wrapper for axi_xbar_rework to instantiate parameters
//
// Revision: Under version-control

module axi_xbar_wrapper #(
    parameter NB_MASTER          = 9,
    parameter NB_SLAVE           = 2,
    parameter AXI_ADDR_WIDTH     = 64,
    parameter AXI_DATA_WIDTH     = 64,
    parameter AXI_ID_WIDTH       = 4,
    parameter AXI_USER_WIDTH     = 1,
    parameter MASTER_SLICE_DEPTH = 1,
    parameter SLAVE_SLICE_DEPTH  = 1
)(
    input logic      clk,
    input logic      rst_n,
    input logic      test_en_i,
    // Memory map
    input  logic [NB_MASTER-1:0][AXI_ADDR_WIDTH-1:0] start_addr_i,
    input  logic [NB_MASTER-1:0][AXI_ADDR_WIDTH-1:0] end_addr_i
);
    localparam AXI_ID_OUT = AXI_ID_WIDTH + $clog2(NB_SLAVE);

    AXI_BUS #(
      .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH  ),
      .AXI_DATA_WIDTH ( AXI_DATA_WIDTH  ),
      .AXI_ID_WIDTH   ( AXI_ID_WIDTH    ),
      .AXI_USER_WIDTH ( AXI_USER_WIDTH  )
    ) axi_slave [NB_SLAVE-1:0](.clk_i(clk));

    AXI_BUS #(
       .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH ),
       .AXI_DATA_WIDTH ( AXI_DATA_WIDTH ),
       .AXI_ID_WIDTH   ( AXI_ID_OUT     ),
       .AXI_USER_WIDTH ( AXI_USER_WIDTH )
    ) axi_master [NB_MASTER-1:0](.clk_i(clk));

    axi_xbar_rework #(
        .NB_MASTER      ( NB_MASTER      ),
        .NB_SLAVE       ( NB_SLAVE       ),
        .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH ),
        .AXI_DATA_WIDTH ( AXI_DATA_WIDTH ),
        .AXI_ID_WIDTH   ( AXI_ID_WIDTH   ),
        .AXI_USER_WIDTH ( AXI_USER_WIDTH )
    ) i_axi_node_intf_wrap (
        .clk,
        .rst_n,
        .test_en_i,
        .slave  ( axi_slave  ),
        .master ( axi_master ),
        .start_addr_i,
        .end_addr_i
    );

endmodule
