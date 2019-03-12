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
    axi_channel.slave  master,
    axi_channel.master slave
);

    // Static checks of interface matching
    localparam MADDR_WIDTH = $bits(master.aw_addr);
    localparam SADDR_WIDTH = $bits(slave.aw_addr);
   
    // Static checks of interface matching
    if (MADDR_WIDTH != SADDR_WIDTH ||
        $bits(master.aw_id) != $bits(slave.aw_id) ||
        $bits(master.w_data) != $bits(slave.w_data) ||
        $bits(master.aw_user) != $bits(slave.aw_user) ||
        $bits(master.w_user) != $bits(slave.w_user) ||
        $bits(master.b_user) != $bits(slave.b_user) ||
        $bits(master.ar_user) != $bits(slave.ar_user) ||
        $bits(master.r_user) != $bits(slave.r_user))
        $fatal(1, "Parameter mismatch");

    //
    // AW channel
    //

    typedef logic [
        ($bits(master.aw_id) > $bits(slave.aw_id) ? $bits(master.aw_id) : $bits(slave.aw_id)) +
        $bits(master.aw_addr) +
        $bits(master.aw_len) +
        $bits(master.aw_size) +
        $bits(master.aw_burst) +
        $bits(master.aw_lock) +
        $bits(master.aw_cache) +
        $bits(master.aw_prot) +
        $bits(master.aw_qos) +
        $bits(master.aw_region) +
        $bits(master.aw_user) : 0] aw_pack_t;

    regslice #(
        .TYPE             (aw_pack_t),
        .FORWARD          ((AW_MODE & 1) != 0),
        .REVERSE          ((AW_MODE & 2) != 0),
        .HIGH_PERFORMANCE ((AW_MODE & 4) != 0)
    ) awfifo (
        .clk     (master.clk),
        .rstn    (master.rstn),
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
        $bits(master.w_data) +
        $bits(master.w_strb) +
        $bits(master.w_last) +
        $bits(master.w_user) : 1] w_pack_t;

    regslice #(
        .TYPE             (w_pack_t),
        .FORWARD          ((W_MODE & 1) != 0),
        .REVERSE          ((W_MODE & 2) != 0),
        .HIGH_PERFORMANCE ((W_MODE & 4) != 0)
    ) wfifo (
        .clk     (master.clk),
        .rstn    (master.rstn),
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
        ($bits(master.b_id) > $bits(slave.b_id) ? $bits(master.b_id) : $bits(slave.b_id)) +
        $bits(slave.b_resp) +
        $bits(slave.b_user) : 1] b_pack_t;

    regslice #(
        .TYPE             (b_pack_t),
        .FORWARD          ((B_MODE & 1) != 0),
        .REVERSE          ((B_MODE & 2) != 0),
        .HIGH_PERFORMANCE ((B_MODE & 4) != 0)
    ) bfifo (
        .clk     (master.clk),
        .rstn    (master.rstn),
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
        ($bits(master.ar_id) > $bits(slave.ar_id) ? $bits(master.ar_id) : $bits(slave.ar_id)) +
        $bits(master.ar_addr) +
        $bits(master.ar_len) +
        $bits(master.ar_size) +
        $bits(master.ar_burst) +
        $bits(master.ar_lock) +
        $bits(master.ar_cache) +
        $bits(master.ar_prot) +
        $bits(master.ar_qos) +
        $bits(master.ar_region) +
        $bits(master.ar_user) : 0] ar_pack_t;

    regslice #(
        .TYPE             (ar_pack_t),
        .FORWARD          ((AR_MODE & 1) != 0),
        .REVERSE          ((AR_MODE & 2) != 0),
        .HIGH_PERFORMANCE ((AR_MODE & 4) != 0)
    ) arfifo (
        .clk     (master.clk),
        .rstn    (master.rstn),
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
        ($bits(master.r_id) > $bits(slave.r_id) ? $bits(master.r_id) : $bits(slave.r_id)) +
        $bits(slave.r_data) +
        $bits(slave.r_resp) +
        $bits(slave.r_last) +
        $bits(slave.r_user) : 0] r_pack_t;

    regslice #(
        .TYPE             (r_pack_t),
        .FORWARD          ((R_MODE & 1) != 0),
        .REVERSE          ((R_MODE & 2) != 0),
        .HIGH_PERFORMANCE ((R_MODE & 4) != 0)
    ) rfifo (
        .clk     (master.clk),
        .rstn    (master.rstn),
        .w_valid (slave.r_valid),
        .w_ready (slave.r_ready),
        .w_data  ({slave.r_id, slave.r_data, slave.r_resp, slave.r_last, slave.r_user}),
        .r_valid (master.r_valid),
        .r_ready (master.r_ready),
        .r_data  ({master.r_id, master.r_data, master.r_resp, master.r_last, master.r_user})
    );

endmodule
