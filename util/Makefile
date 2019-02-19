V = axi_xbar_rework.sv ../axi/bram_ctrl.sv ../axi/buf.sv ../axi/channel.sv ../axi/common.sv ../axi/crossbar.sv ../axi/demux.sv ../axi/dummy_master.sv ../axi/dummy_slave.sv ../axi/from_lite.sv ../axi/id_downsizer.sv ../axi/join.sv ../axi/lite_bram_ctrl.sv ../axi/lite_buf.sv ../axi/lite_channel.sv ../axi/lite_dummy_master.sv ../axi/lite_dummy_slave.sv ../axi/lite_join.sv ../axi/mux.sv ../axi/regslice.sv ../axi/to_lite.sv onehot.sv regslice.sv fifo.sv from_if.sv to_if.sv round_robin_arbiter.sv priority_arbiter.sv slave_adapter.sv ../ram/simple_wr.sv

simple.sv: $V
	../../sv-elaborator/target/debug/sv-elaborator $V -t axi_xbar_rework > $@
