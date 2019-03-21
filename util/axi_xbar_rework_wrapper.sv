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
// Originally by   Gary Guo
// Create Date:    13/03/2019
// Module Name:    axi_xbar_rework_wrapper
// Project Name:   LowRISC
// Language:       SystemVerilog
//
// Description: Replace crossbar to improve compliance and generality
//
// Revision: Under version-control

`ifdef GENESYSII
 `define SIMPLE_XBAR
`endif

`ifdef verilator
 `define SIMPLE_XBAR
`endif

module axi_xbar_rework_wrapper (
    input wire logic clk,
    input wire logic rst_n,
    input wire logic test_en_i,
    AXI_BUS.Slave slave_0,
    AXI_BUS.Slave slave_1,
    AXI_BUS.Master master_0,
    AXI_BUS.Master master_1,
    AXI_BUS.Master master_2,
    AXI_BUS.Master master_3,
    AXI_BUS.Master master_4,
    AXI_BUS.Master master_5,
    AXI_BUS.Master master_6,
    AXI_BUS.Master master_7,
    AXI_BUS.Master master_8,
    input wire logic[8:0][63:0] start_addr_i,
    input wire logic[8:0][63:0] end_addr_i
);
    parameter integer NB_MASTER = 9;
    parameter integer NB_SLAVE = 2;
    parameter integer AXI_ADDR_WIDTH = 64;
    parameter integer AXI_DATA_WIDTH = 64;
    parameter integer AXI_ID_WIDTH = 4;
    parameter integer AXI_USER_WIDTH = 1;
    parameter integer MASTER_SLICE_DEPTH = 1;
    parameter integer SLAVE_SLICE_DEPTH = 1;
    localparam integer AXI_ID_OUT = 5;
    logic[8:0][63:0] start_addr;
    logic[8:0][63:0] mask_addr;
`ifdef SIMPLE_XBAR
    axi_channel #(
            .ID_WIDTH   (AXI_ID_OUT),
            .ADDR_WIDTH (AXI_ADDR_WIDTH),
            .DATA_WIDTH (AXI_DATA_WIDTH)
        ) master_buf_0 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel #(
            .ID_WIDTH   (AXI_ID_OUT),
            .ADDR_WIDTH (AXI_ADDR_WIDTH),
            .DATA_WIDTH (AXI_DATA_WIDTH)
        ) master_buf_1 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel #(
            .ID_WIDTH   (AXI_ID_OUT),
            .ADDR_WIDTH (AXI_ADDR_WIDTH),
            .DATA_WIDTH (AXI_DATA_WIDTH)
        ) master_buf_2 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel #(
            .ID_WIDTH   (AXI_ID_OUT),
            .ADDR_WIDTH (AXI_ADDR_WIDTH),
            .DATA_WIDTH (AXI_DATA_WIDTH)
        ) master_buf_3 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel #(
            .ID_WIDTH   (AXI_ID_OUT),
            .ADDR_WIDTH (AXI_ADDR_WIDTH),
            .DATA_WIDTH (AXI_DATA_WIDTH)
        ) master_buf_4 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel #(
            .ID_WIDTH   (AXI_ID_OUT),
            .ADDR_WIDTH (AXI_ADDR_WIDTH),
            .DATA_WIDTH (AXI_DATA_WIDTH)
        ) master_buf_5 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel #(
            .ID_WIDTH   (AXI_ID_OUT),
            .ADDR_WIDTH (AXI_ADDR_WIDTH),
            .DATA_WIDTH (AXI_DATA_WIDTH)
        ) master_buf_6 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel #(
            .ID_WIDTH   (AXI_ID_OUT),
            .ADDR_WIDTH (AXI_ADDR_WIDTH),
            .DATA_WIDTH (AXI_DATA_WIDTH)
        ) master_buf_7 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel #(
            .ID_WIDTH   (AXI_ID_OUT),
            .ADDR_WIDTH (AXI_ADDR_WIDTH),
            .DATA_WIDTH (AXI_DATA_WIDTH)
        ) master_buf_8 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel_1 #(
            .ID_WIDTH   (AXI_ID_WIDTH),
            .ADDR_WIDTH (AXI_ADDR_WIDTH),
            .DATA_WIDTH (AXI_DATA_WIDTH)
        ) slave_buf_0 (
        .clk(clk),
        .rstn(rst_n)
    );
    axi_channel_1 #(
            .ID_WIDTH   (AXI_ID_WIDTH),
            .ADDR_WIDTH (AXI_ADDR_WIDTH),
            .DATA_WIDTH (AXI_DATA_WIDTH)
        ) slave_buf_1 (
        .clk(clk),
        .rstn(rst_n)
    );
`else
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
`endif
    localparam integer genblk1_0_i = 0;
    from_if   #(
                    .ADDR_WIDTH(AXI_ADDR_WIDTH),
                    .USER_WIDTH(AXI_USER_WIDTH),
                    .ID_WIDTH(AXI_ID_WIDTH),
                    .DATA_WIDTH(AXI_DATA_WIDTH)
                    ) genblk1_0_from_if_adapter (
        .incoming_if(slave_0),
`ifdef SIMPLE_XBAR
        .outgoing_openip(slave_buf_0)
`else
        .outgoing_openip(slave_buf[0])
`endif
    );
    localparam integer genblk1_1_i = 1;
    from_if   #(
                    .ADDR_WIDTH(AXI_ADDR_WIDTH),
                    .USER_WIDTH(AXI_USER_WIDTH),
                    .ID_WIDTH(AXI_ID_WIDTH),
                    .DATA_WIDTH(AXI_DATA_WIDTH)
                    ) genblk1_1_from_if_adapter (
        .incoming_if(slave_1),
`ifdef SIMPLE_XBAR
        .outgoing_openip(slave_buf_1)
`else
        .outgoing_openip(slave_buf[1])
`endif
    );
    localparam integer genblk2_0_i = 0;
    to_if  #(
                    .ADDR_WIDTH(AXI_ADDR_WIDTH),
                    .USER_WIDTH(AXI_USER_WIDTH),
                    .ID_WIDTH(AXI_ID_OUT),
                    .DATA_WIDTH(AXI_DATA_WIDTH)
                    )  genblk2_0_to_if_adapter (
        .outgoing_if(master_0),
`ifdef SIMPLE_XBAR
        .incoming_openip(master_buf_0)
`else
        .incoming_openip(master_buf[0])
`endif
    );
    assign mask_addr[0] = end_addr_i[0] - start_addr_i[0];
    assign start_addr[0] = start_addr_i[0];
    localparam integer genblk2_1_i = 1;
    to_if   #(
                    .ADDR_WIDTH(AXI_ADDR_WIDTH),
                    .USER_WIDTH(AXI_USER_WIDTH),
                    .ID_WIDTH(AXI_ID_OUT),
                    .DATA_WIDTH(AXI_DATA_WIDTH)
                    ) genblk2_1_to_if_adapter (
        .outgoing_if(master_1),
`ifdef SIMPLE_XBAR
        .incoming_openip(master_buf_1)
`else
        .incoming_openip(master_buf[1])
`endif
    );
    assign mask_addr[1] = end_addr_i[1] - start_addr_i[1];
    assign start_addr[1] = start_addr_i[1];
    localparam integer genblk2_2_i = 2;
    to_if   #(
                    .ADDR_WIDTH(AXI_ADDR_WIDTH),
                    .USER_WIDTH(AXI_USER_WIDTH),
                    .ID_WIDTH(AXI_ID_OUT),
                    .DATA_WIDTH(AXI_DATA_WIDTH)
                    ) genblk2_2_to_if_adapter (
        .outgoing_if(master_2),
`ifdef SIMPLE_XBAR
        .incoming_openip(master_buf_2)
`else
        .incoming_openip(master_buf[2])
`endif
    );
    assign mask_addr[2] = end_addr_i[2] - start_addr_i[2];
    assign start_addr[2] = start_addr_i[2];
    localparam integer genblk2_3_i = 3;
    to_if   #(
                    .ADDR_WIDTH(AXI_ADDR_WIDTH),
                    .USER_WIDTH(AXI_USER_WIDTH),
                    .ID_WIDTH(AXI_ID_OUT),
                    .DATA_WIDTH(AXI_DATA_WIDTH)
                    ) genblk2_3_to_if_adapter (
        .outgoing_if(master_3),
`ifdef SIMPLE_XBAR
        .incoming_openip(master_buf_3)
`else
        .incoming_openip(master_buf[3])
`endif
    );
    assign mask_addr[3] = end_addr_i[3] - start_addr_i[3];
    assign start_addr[3] = start_addr_i[3];
    localparam integer genblk2_4_i = 4;
    to_if   #(
                    .ADDR_WIDTH(AXI_ADDR_WIDTH),
                    .USER_WIDTH(AXI_USER_WIDTH),
                    .ID_WIDTH(AXI_ID_OUT),
                    .DATA_WIDTH(AXI_DATA_WIDTH)
                    ) genblk2_4_to_if_adapter (
        .outgoing_if(master_4),
`ifdef SIMPLE_XBAR
        .incoming_openip(master_buf_4)
`else
        .incoming_openip(master_buf[4])
`endif
    );
    assign mask_addr[4] = end_addr_i[4] - start_addr_i[4];
    assign start_addr[4] = start_addr_i[4];
    localparam integer genblk2_5_i = 5;
    to_if   #(
                    .ADDR_WIDTH(AXI_ADDR_WIDTH),
                    .USER_WIDTH(AXI_USER_WIDTH),
                    .ID_WIDTH(AXI_ID_OUT),
                    .DATA_WIDTH(AXI_DATA_WIDTH)
                    ) genblk2_5_to_if_adapter (
        .outgoing_if(master_5),
`ifdef SIMPLE_XBAR
        .incoming_openip(master_buf_5)
`else
        .incoming_openip(master_buf[5])
`endif
    );
    assign mask_addr[5] = end_addr_i[5] - start_addr_i[5];
    assign start_addr[5] = start_addr_i[5];
    localparam integer genblk2_6_i = 6;
    to_if   #(
                    .ADDR_WIDTH(AXI_ADDR_WIDTH),
                    .USER_WIDTH(AXI_USER_WIDTH),
                    .ID_WIDTH(AXI_ID_OUT),
                    .DATA_WIDTH(AXI_DATA_WIDTH)
                    ) genblk2_6_to_if_adapter (
        .outgoing_if(master_6),
`ifdef SIMPLE_XBAR
        .incoming_openip(master_buf_6)
`else
        .incoming_openip(master_buf[6])
`endif
    );
    assign mask_addr[6] = end_addr_i[6] - start_addr_i[6];
    assign start_addr[6] = start_addr_i[6];
    localparam integer genblk2_7_i = 7;
    to_if   #(
                    .ADDR_WIDTH(AXI_ADDR_WIDTH),
                    .USER_WIDTH(AXI_USER_WIDTH),
                    .ID_WIDTH(AXI_ID_OUT),
                    .DATA_WIDTH(AXI_DATA_WIDTH)
                    ) genblk2_7_to_if_adapter (
        .outgoing_if(master_7),
`ifdef SIMPLE_XBAR
        .incoming_openip(master_buf_7)
`else
        .incoming_openip(master_buf[7])
`endif
    );
    assign mask_addr[7] = end_addr_i[7] - start_addr_i[7];
    assign start_addr[7] = start_addr_i[7];
    localparam integer genblk2_8_i = 8;
    to_if   #(
                    .ADDR_WIDTH(AXI_ADDR_WIDTH),
                    .USER_WIDTH(AXI_USER_WIDTH),
                    .ID_WIDTH(AXI_ID_OUT),
                    .DATA_WIDTH(AXI_DATA_WIDTH)
                    ) genblk2_8_to_if_adapter (
        .outgoing_if(master_8),
`ifdef SIMPLE_XBAR
        .incoming_openip(master_buf_8)
`else
        .incoming_openip(master_buf[8])
`endif
    );
    assign mask_addr[8] = end_addr_i[8] - start_addr_i[8];
    assign start_addr[8] = start_addr_i[8];
`ifdef SIMPLE_XBAR
    axi_crossbar  #(
    .MASTER_NUM(NB_SLAVE),
    .SLAVE_NUM(NB_MASTER),
    .ADDR_WIDTH(AXI_ADDR_WIDTH)
) openip_xbar (
        .master_0(slave_buf_0),
        .master_1(slave_buf_1),
        .slave_0(master_buf_0),
        .slave_1(master_buf_1),
        .slave_2(master_buf_2),
        .slave_3(master_buf_3),
        .slave_4(master_buf_4),
        .slave_5(master_buf_5),
        .slave_6(master_buf_6),
        .slave_7(master_buf_7),
        .slave_8(master_buf_8),
        .BASE(start_addr),
        .MASK(mask_addr)
    );
`else
axi_crossbar #(
    .MASTER_NUM(NB_SLAVE),
    .SLAVE_NUM(NB_MASTER),
    .ADDR_WIDTH(AXI_ADDR_WIDTH)
) openip_xbar (
    .master(slave_buf),
    .slave(master_buf),
    .BASE(start_addr),
    .MASK(mask_addr)               
);
`endif
   
endmodule
