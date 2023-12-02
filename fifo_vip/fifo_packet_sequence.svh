//------------------------------------------------------------------------------
//
// CLASS: fifo_packet_sequence
//
// this is an extended class of packet_sequence class and thisdefines all 
// the vitual functions introduced in the packet_sequence class. 
//------------------------------------------------------------------------------
class fifo_packet_sequence extends packet_sequence #(fifo_packet);

    // Function: new
    //
    // This implements the constructor for the fifo_packet_sequence class.
    function new(
        ref axi4stream_vip_0_mst_t   mst_agent,
        ref axi4stream_vip_1_slv_t   slv_agent
    );
        super.new(mst_agent,slv_agent);
    endfunction

    // Function: do_mst_work.
    //
    // function generates the packets.
    task do_mst_work();
        automatic fifo_packet   temp_packet;
        for (int packet_count = 0; packet_count < 1000; packet_count++) begin
            temp_packet = new();
            temp_packet.randomize();
            send_packet(temp_packet);
        end
    endtask: do_mst_work

endclass: fifo_packet_sequence