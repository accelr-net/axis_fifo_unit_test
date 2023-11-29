package fifo_pkg;
    import xil_common_vip_pkg::*;
    import axi4s_vip_base::*;
    import axi4stream_vip_pkg::*;
    import axi4stream_vip_0_pkg::*;
    import axi4stream_vip_1_pkg::*;

    `include "fifo_packet.svh"
    `include "fifo_packet_sequence.svh"
    `include "fifo_model.svh"

    typedef beat_subscriber #(fifo_packet)      fifo_beat_subscriber;
    typedef packet_subscriber #(fifo_packet)    fifo_packet_subscriber;
endpackage: fifo_pkg