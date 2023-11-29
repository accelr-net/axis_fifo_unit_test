virtual class packet_sequence #(
    type packet_t = data_packet
);
    axi4stream_vip_0_mst_t   mst_agent;
    axi4stream_vip_1_slv_t   slv_agent;

    function new(
        ref axi4stream_vip_0_mst_t   mst_agent,
        ref axi4stream_vip_1_slv_t   slv_agent
    );
        this.mst_agent = mst_agent;
        this.slv_agent = slv_agent;
    endfunction: new
    
    task do_work();
        //Fork do_slv_work & do_mst_work
        fork
            begin
                do_mst_work();
            end
            begin
                do_slv_work();
            end
        join
    endtask: do_work
    
    pure virtual protected task do_mst_work();
    
    protected task do_slv_work();
        //Selt flow control config to slave_driver
        axi4stream_ready_gen ready_gen;
        ready_gen = slv_agent.driver.create_ready("ready_gen");
        ready_gen.set_ready_policy(XIL_AXI4STREAM_READY_GEN_OSC);
        ready_gen.set_low_time(2);
        ready_gen.set_high_time(6);
        slv_agent.driver.send_tready(ready_gen);
    endtask: do_slv_work

    protected task send_packet(packet_t packet);
        automatic int                       beat_count;
        automatic u8_array                  data_array;

        data_array      = packet.serialize();
        beat_count      = data_array.size();
        for(int j = 0; j < beat_count; j++) begin
            automatic axi4stream_transaction    wr_transaction;
            automatic axi4stream_transaction    wr_transactionc;
            automatic logic         [7:0]       data_beat;
            data_beat       = data_array[j];

            wr_transaction  = mst_agent.driver.create_transaction("Mst write trasaction");
            wr_transactionc = mst_agent.driver.create_transaction("Mst write trasactionc");

            wr_transaction.set_driver_return_item_policy(XIL_AXI4STREAM_AT_ACCEPT_RETURN);
            SEND_PACKET_FAILURE: assert(wr_transaction.randomize());
            wr_transaction.set_data_beat(data_beat);

            wr_transaction.set_last(0);
            if(j == beat_count - 1) begin
                wr_transaction.set_last(1);
            end

            //sending trasaction
            mst_agent.driver.send(wr_transaction);
            mst_agent.driver.seq_item_port.get_next_rsp(wr_transactionc);
        end
    endtask: send_packet
endclass: packet_sequence