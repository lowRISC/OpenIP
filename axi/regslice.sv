/*
 * Copyright (c) 2019, Gary Guo
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *  * Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */

// A register slice for AXI interface.
//
// MODE: 0 (none) 1 (forward) 2 (reverse) 3 (lite both ways) 7 (high performance both ways)
module axi_regslice #(
    parameter AW_MODE = 3,
    parameter  W_MODE = 7,
    parameter  B_MODE = 3,
    parameter AR_MODE = 3,
    parameter  R_MODE = 7
) (
    input logic clk, rstn,
    AXI_BUS.Slave  master,
    AXI_BUS.Master slave
);

localparam SZ_master_ar_addr = $bits(master.ar_addr);
localparam SZ_master_ar_burst = $bits(master.ar_burst);
localparam SZ_master_ar_cache = $bits(master.ar_cache);
localparam SZ_master_ar_id = $bits(master.ar_id);
localparam SZ_master_ar_len = $bits(master.ar_len);
localparam SZ_master_ar_lock = $bits(master.ar_lock);
localparam SZ_master_ar_prot = $bits(master.ar_prot);
localparam SZ_master_ar_qos = $bits(master.ar_qos);
localparam SZ_master_ar_region = $bits(master.ar_region);
localparam SZ_master_ar_size = $bits(master.ar_size);
localparam SZ_master_ar_user = $bits(master.ar_user);
localparam SZ_master_aw_addr = $bits(master.aw_addr);
localparam SZ_master_aw_burst = $bits(master.aw_burst);
localparam SZ_master_aw_cache = $bits(master.aw_cache);
localparam SZ_master_aw_id = $bits(master.aw_id);
localparam SZ_master_aw_len = $bits(master.aw_len);
localparam SZ_master_aw_lock = $bits(master.aw_lock);
localparam SZ_master_aw_prot = $bits(master.aw_prot);
localparam SZ_master_aw_qos = $bits(master.aw_qos);
localparam SZ_master_aw_region = $bits(master.aw_region);
localparam SZ_master_aw_size = $bits(master.aw_size);
localparam SZ_master_aw_user = $bits(master.aw_user);
localparam SZ_master_b_id = $bits(master.b_id);
localparam SZ_master_b_user = $bits(master.b_user);
localparam SZ_master_r_id = $bits(master.r_id);
localparam SZ_master_r_user = $bits(master.r_user);
localparam SZ_master_w_data = $bits(master.w_data);
localparam SZ_master_w_last = $bits(master.w_last);
localparam SZ_master_w_strb = $bits(master.w_strb);
localparam SZ_master_w_user = $bits(master.w_user);
localparam SZ_slave_ar_id = $bits(slave.ar_id);
localparam SZ_slave_ar_user = $bits(slave.ar_user);
localparam SZ_slave_aw_addr = $bits(slave.aw_addr);
localparam SZ_slave_aw_id = $bits(slave.aw_id);
localparam SZ_slave_aw_user = $bits(slave.aw_user);
localparam SZ_slave_b_id = $bits(slave.b_id);
localparam SZ_master_b_resp = $bits(master.b_resp);
localparam SZ_slave_b_user = $bits(slave.b_user);
localparam SZ_master_r_data = $bits(master.r_data);
localparam SZ_slave_r_id = $bits(slave.r_id);
localparam SZ_master_r_last = $bits(master.r_last);
localparam SZ_master_r_resp = $bits(master.r_resp);
localparam SZ_slave_r_user = $bits(slave.r_user);
localparam SZ_slave_w_data = $bits(slave.w_data);
localparam SZ_slave_w_user = $bits(slave.w_user);

    // Static checks of interface matching
    if (SZ_master_aw_addr != SZ_slave_aw_addr ||
        SZ_master_aw_id != SZ_slave_aw_id ||
        SZ_master_w_data != SZ_slave_w_data ||
        SZ_master_aw_user != SZ_slave_aw_user ||
        SZ_master_w_user != SZ_slave_w_user ||
        SZ_master_b_user != SZ_slave_b_user ||
        SZ_master_ar_user != SZ_slave_ar_user ||
        SZ_master_r_user != SZ_slave_r_user)
        $fatal(1, "Parameter mismatch");

    //
    // AW channel
    //

    typedef logic [
        SZ_master_aw_id +
        SZ_master_aw_addr +
        SZ_master_aw_len +
        SZ_master_aw_size +
        SZ_master_aw_burst +
        SZ_master_aw_lock +
        SZ_master_aw_cache +
        SZ_master_aw_prot +
        SZ_master_aw_qos +
        SZ_master_aw_region +
        SZ_master_aw_user - 1 : 0] aw_pack_t;

    regslice #(
        .TYPE             (aw_pack_t),
        .FORWARD          ((AW_MODE & 1) != 0),
        .REVERSE          ((AW_MODE & 2) != 0),
        .HIGH_PERFORMANCE ((AW_MODE & 4) != 0)
    ) awfifo (
        .clk     (clk),
        .rstn    (rstn),
        .w_valid (master.aw_valid),
        .w_ready (master.aw_ready),
        .w_data  ({
            master.aw_id, master.aw_addr, master.aw_len, master.aw_size, master.aw_burst, master.aw_lock,
            master.aw_cache, master.aw_prot, master.aw_qos, master.aw_region, master.aw_user
        }),
        .r_valid (slave.aw_valid),
        .r_ready (slave.aw_ready),
        .r_data  ({
            slave.aw_id, slave.aw_addr, slave.aw_len, slave.aw_size, slave.aw_burst, slave.aw_lock,
            slave.aw_cache, slave.aw_prot, slave.aw_qos, slave.aw_region, slave.aw_user
        })
    );

    //
    // W channel
    //

    typedef logic [
        SZ_master_w_data +
        SZ_master_w_strb +
        SZ_master_w_last +
        SZ_master_w_user - 1 : 0] w_pack_t;

    regslice #(
        .TYPE             (w_pack_t),
        .FORWARD          ((W_MODE & 1) != 0),
        .REVERSE          ((W_MODE & 2) != 0),
        .HIGH_PERFORMANCE ((W_MODE & 4) != 0)
    ) wfifo (
        .clk     (clk),
        .rstn    (rstn),
        .w_valid (master.w_valid),
        .w_ready (master.w_ready),
        .w_data  ({master.w_data, master.w_strb, master.w_last, master.w_user}),
        .r_valid (slave.w_valid),
        .r_ready (slave.w_ready),
        .r_data  ({slave.w_data, slave.w_strb, slave.w_last, slave.w_user})
    );

    //
    // B channel
    //

    typedef logic [
        SZ_master_b_id +
        SZ_master_b_resp +
        SZ_master_b_user - 1 : 0] b_pack_t;

    regslice #(
        .TYPE             (b_pack_t),
        .FORWARD          ((B_MODE & 1) != 0),
        .REVERSE          ((B_MODE & 2) != 0),
        .HIGH_PERFORMANCE ((B_MODE & 4) != 0)
    ) bfifo (
        .clk     (clk),
        .rstn    (rstn),
        .w_valid (slave.b_valid),
        .w_ready (slave.b_ready),
        .w_data  ({slave.b_id, slave.b_resp, slave.b_user}),
        .r_valid (master.b_valid),
        .r_ready (master.b_ready),
        .r_data  ({master.b_id, master.b_resp, master.b_user})
    );

    //
    // AR channel
    //

    typedef logic [
        SZ_master_ar_id +
        SZ_master_ar_addr +
        SZ_master_ar_len +
        SZ_master_ar_size +
        SZ_master_ar_burst +
        SZ_master_ar_lock +
        SZ_master_ar_cache +
        SZ_master_ar_prot +
        SZ_master_ar_qos +
        SZ_master_ar_region +
        SZ_master_ar_user - 1 : 0] ar_pack_t;

    regslice #(
        .TYPE             (ar_pack_t),
        .FORWARD          ((AR_MODE & 1) != 0),
        .REVERSE          ((AR_MODE & 2) != 0),
        .HIGH_PERFORMANCE ((AR_MODE & 4) != 0)
    ) arfifo (
        .clk     (clk),
        .rstn    (rstn),
        .w_valid (master.ar_valid),
        .w_ready (master.ar_ready),
        .w_data  ({
            master.ar_id, master.ar_addr, master.ar_len, master.ar_size, master.ar_burst, master.ar_lock,
            master.ar_cache, master.ar_prot, master.ar_qos, master.ar_region, master.ar_user
        }),
        .r_valid (slave.ar_valid),
        .r_ready (slave.ar_ready),
        .r_data  ({
            slave.ar_id, slave.ar_addr, slave.ar_len, slave.ar_size, slave.ar_burst, slave.ar_lock,
            slave.ar_cache, slave.ar_prot, slave.ar_qos, slave.ar_region, slave.ar_user
        })
    );

    //
    // R channel
    //

    typedef logic [
        SZ_master_r_id +
        SZ_master_r_data +
        SZ_master_r_resp +
        SZ_master_r_last +
        SZ_master_r_user - 1 : 0] r_pack_t;

    regslice #(
        .TYPE             (r_pack_t),
        .FORWARD          ((R_MODE & 1) != 0),
        .REVERSE          ((R_MODE & 2) != 0),
        .HIGH_PERFORMANCE ((R_MODE & 4) != 0)
    ) rfifo (
        .clk     (clk),
        .rstn    (rstn),
        .w_valid (slave.r_valid),
        .w_ready (slave.r_ready),
        .w_data  ({slave.r_id, slave.r_data, slave.r_resp, slave.r_last, slave.r_user}),
        .r_valid (master.r_valid),
        .r_ready (master.r_ready),
        .r_data  ({master.r_id, master.r_data, master.r_resp, master.r_last, master.r_user})
    );

endmodule
