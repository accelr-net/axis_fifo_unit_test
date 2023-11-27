class fifo_packet_sequence extends packet_sequence #(fifo_packet);

    function new(
        ref axi4stream_vip_0_mst_t   mst_agent,
        ref axi4stream_vip_1_slv_t   slv_agent
    );
        super.new(mst_agent,slv_agent);
    endfunction

    task do_mst_work();
        automatic fifo_packet   temp_packet = new();
// $display("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\n");
        for (int packet_count = 0; packet_count < 10; packet_count++) begin
            temp_packet.post_randomize();
            send_packet(temp_packet);
            #(10);
        end
    endtask: do_mst_work
endclass: fifo_packet_sequence