/*
 * Copyright (c) 2016-2018, Gary Guo
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

// A general FIFO utility that accepts arbitary types and depth.
// The interface is defined with handshaking signals instead of traditional empty and full, but you can still use
// !w_ready as full and !r_valid as empty.
// FALL_THROUGH can be set to 1 to first-word fall-through.
module fifo #(
    parameter DATA_WIDTH   = 1,
    parameter type TYPE    = logic [DATA_WIDTH-1:0],
    parameter DEPTH        = 1,
    parameter FALL_THROUGH = 0
) (
    input  logic clk,
    input  logic rstn,

    input  logic w_valid,
    output logic w_ready,
    input  TYPE  w_data,

    output logic r_valid,
    input  logic r_ready,
    output TYPE  r_data
);

    localparam ADDR_WIDTH = $clog2(DEPTH);

    // Static checks of paramters
    initial begin
        assert (2 ** ADDR_WIDTH == DEPTH) else $fatal(1, "FIFO depth should be power of 2");
        assert (DEPTH >= 1) else $fatal(1, "FIFO should have depth of at least 1");
    end

    generate
        // General case, if DEPTH is not 1.
        if (ADDR_WIDTH != 0) begin

            // Ring buffer constructs
            TYPE buffer [0:DEPTH-1];
            logic [ADDR_WIDTH-1:0] readptr, readptr_next;
            logic [ADDR_WIDTH-1:0] writeptr, writeptr_next;
            logic empty, empty_next;
            logic full, full_next;

            // We cannot accept more writes when full. When empty, we can still accept read if there is a valid write.
            assign w_ready = !full;
            assign r_valid = !empty || (FALL_THROUGH && w_valid);

            // Compute next state
            always_comb begin
                // Default assignments
                readptr_next = readptr;
                writeptr_next = writeptr;
                empty_next = 1'b0;
                full_next = 1'b0;

                // Special cases when FIFO is empty and FALL_THROUGH is enabled. In this case we simply connect two
                // sides together.
                r_data = (FALL_THROUGH && empty) ? w_data : buffer[readptr];

                // If FALL_THROUGH is enabled and transaction happens, do not move pointers.
                if (FALL_THROUGH && empty && r_ready && w_valid) begin
                    empty_next = 1'b1;
                end
                else begin
                    // Adjust pointers according to handshake signals.
                    if (r_valid && r_ready) readptr_next = readptr + 1;
                    if (w_valid && w_ready) writeptr_next = writeptr + 1;

                    // If pointers coincide, then determine the full/empty status by the firing transaction. Note that
                    // these checks can be disjoint as we can never read/write simulatenously when the buffer is full.
                    if (readptr_next == writeptr_next) begin
                        empty_next = empty;
                        full_next = full;
                        if (r_valid && r_ready) empty_next = 1'b1;
                        if (w_valid && w_ready) full_next = 1'b1;
                    end
                end
            end

            always_ff @(posedge clk or negedge rstn)
                if (!rstn) begin
                    readptr  <= 0;
                    writeptr <= 0;
                    full     <= 1'b0;
                    empty    <= 1'b1;
                end
                else begin
                    readptr  <= readptr_next;
                    writeptr <= writeptr_next;
                    empty    <= empty_next;
                    full     <= full_next;

                    if (w_valid && w_ready) buffer[writeptr] <= w_data;
                end

        end
        // This is a specialised version targeting buffer of size 1. The general one does not work as pointers do not
        // exist in this special case.
        else begin

            TYPE buffer;
            // In this special case full and empty are always complements.
            logic empty, empty_next;
            assign w_ready = empty;
            assign r_valid = !empty || (FALL_THROUGH && w_valid);

            // Compute next state
            always_comb begin
                empty_next = 1'b0;
                r_data = (FALL_THROUGH && empty) ? w_data : buffer;
                if (FALL_THROUGH && empty && r_ready && w_valid) begin
                    empty_next = 1'b1;
                end
                else begin
                    empty_next = empty;
                    if (r_valid && r_ready) empty_next = 1'b1;
                    if (w_valid && w_ready) empty_next = 1'b0;
                end
            end

            always_ff @(posedge clk or negedge rstn)
                if (!rstn) begin
                    empty <= 1'b1;
                end
                else begin
                    empty <= empty_next;
                    if (w_valid && w_ready) buffer <= w_data;
                end

        end
    endgenerate

endmodule
