class fifo_packet_sequence extends packet_sequence #(fifo_packet);

    function new(
        ref axi4stream_vip_0_mst_t   mst_agent,
        ref axi4stream_vip_1_slv_t   slv_agent
    );
        super.new(mst_agent,slv_agent);
    endfunction

    task do_mst_work();
        automatic fifo_packet   temp_packet;
        for (int packet_count = 0; packet_count < 1000000; packet_count++) begin
            temp_packet = new();
            temp_packet.randomize();
            // temp_packet.post_randomize();
            // temp_packet.print();
            send_packet(temp_packet);
        end
    endtask: do_mst_work
endclass: fifo_packet_sequence