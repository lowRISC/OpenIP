// Copyright 2014-2018 ETH Zurich, University of Bologna and University of Cambridge.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Written by:     Jonathan Kimmitt
// Originally by   Igor Loi - igor.loi@unibo.it, Florian Zaruba - zarubaf@iis.ee.thz.ch
// Create Date:    18/02/2019
// Module Name:    axi_xbar_rework (based on axi_node_wrap_with_slices)
// Project Name:   LowRISC
// Language:       SystemVerilog
//
// Description: Replace crossbar to improve compliance and generality
//
// Revision: Under version-control

module axi_xbar_rework ();
   
    parameter NB_MASTER = 9;
    parameter NB_SLAVE = 2;
    parameter AXI_ADDR_WIDTH = 64;
    parameter AXI_DATA_WIDTH = 64;
    parameter AXI_ID_WIDTH = 4;
    parameter AXI_USER_WIDTH = 1;
    parameter MASTER_SLICE_DEPTH = 1;
    parameter SLAVE_SLICE_DEPTH  = 1;

    logic      clk;
    logic      rst_n;
    logic      test_en_i;
    // Memory map
    logic [NB_MASTER-1:0][AXI_ADDR_WIDTH-1:0] start_addr_i;
    logic [NB_MASTER-1:0][AXI_ADDR_WIDTH-1:0]  end_addr_i;

    localparam AXI_ID_OUT = AXI_ID_WIDTH + $clog2(NB_SLAVE);
    logic [NB_MASTER-1:0][AXI_ADDR_WIDTH-1:0] start_addr;
    logic [NB_MASTER-1:0][AXI_ADDR_WIDTH-1:0] mask_addr;
   
    axi_channel #(
            .ID_WIDTH   (AXI_ID_OUT),
            .ADDR_WIDTH (AXI_ADDR_WIDTH),
            .DATA_WIDTH (AXI_DATA_WIDTH)
        ) master_buf[NB_MASTER-1:0] (
            .clk(clk),
            .rstn(rst_n)
                      );
   
    axi_channel #(
            .ID_WIDTH   (AXI_ID_WIDTH),
            .ADDR_WIDTH (AXI_ADDR_WIDTH),
            .DATA_WIDTH (AXI_DATA_WIDTH)
        ) slave_buf[NB_SLAVE-1:0] (
            .clk(clk),
            .rstn(rst_n)
                      );   

    for (genvar i = 0; i < NB_SLAVE; i++)
      begin
         from_if  #(
                    .ADDR_WIDTH(AXI_ADDR_WIDTH),
                    .USER_WIDTH(AXI_USER_WIDTH),
                    .ID_WIDTH(AXI_ID_WIDTH),
                    .DATA_WIDTH(AXI_DATA_WIDTH)
                    ) from_if_adapter
         (
//          .incoming_if(slave[i]),
          .outgoing_openip(slave_buf[i])                       
          );
      end

    for (genvar i = 0; i < NB_MASTER; i++)
      begin
         to_if  #(
                    .ADDR_WIDTH(AXI_ADDR_WIDTH),
                    .USER_WIDTH(AXI_USER_WIDTH),
                    .ID_WIDTH(AXI_ID_OUT),
                    .DATA_WIDTH(AXI_DATA_WIDTH)
                    ) to_if_adapter
         (
//          .outgoing_if(master[i]),
          .incoming_openip(master_buf[i])                       
          );
      assign mask_addr[NB_MASTER-1-i] = end_addr_i[i] - start_addr_i[i];
      assign start_addr[NB_MASTER-1-i] = start_addr_i[i];
      end

axi_crossbar #(
    .MASTER_NUM(NB_SLAVE),
    .SLAVE_NUM(NB_MASTER),
    .ADDR_WIDTH(AXI_ADDR_WIDTH)
) openip_xbar (
    .master(slave_buf),
    .slave(master_buf)
/*
    .BASE(start_addr),
    .MASK(mask_addr)  
*/              
);
   
endmodule
