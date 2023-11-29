class packet_subscriber #(
    type packet_t = data_packet
);
    beat_subscriber #(packet_t) mst_beat_subscriber;
    beat_subscriber #(packet_t) slv_beat_subscriber;
    mailbox                     expected_packets;
    model           #(packet_t) model_inst;
    int                         pass_count;
    int                         fail_count;

    function new(
        beat_subscriber #(packet_t) slv_beat_sub,
        beat_subscriber #(packet_t) mst_beat_sub,
        model #(packet_t)           dut_model
    );
        slv_beat_subscriber =   slv_beat_sub;
        mst_beat_subscriber =   mst_beat_sub;
        model_inst          =   dut_model;
        expected_packets    =   new();
    endfunction: new

    task do_work();
        // Fork read_from_mst & read_from_slv
        fork
            begin
                read_from_mst();
            end
            begin
                read_from_slv();
            end
        join_any
        #1000;
    endtask: do_work

    task read_from_mst();
        while(1) begin
            packet_t    last_packet; 
            packet_t    expected_values[$];
            last_packet = mst_beat_subscriber.pop();
            if(last_packet.serialize().size() > 0) begin
                expected_values = model_inst.get_expected_packet(last_packet);
                foreach (expected_values[i]) begin
                    expected_packets.put(expected_values[i]);
                end
            end
            #10;
        end
    endtask: read_from_mst

    task read_from_slv();
        while(1) begin    
            packet_t    slv_last_packet;
            packet_t    expected_last_packet;
            slv_last_packet = slv_beat_subscriber.pop();
            if(slv_last_packet.serialize().size() > 0) begin
                expected_packets.get(expected_last_packet); 
                if(slv_last_packet.do_compare(expected_last_packet)) begin
                    pass_count = pass_count + 1;
                end
                else begin
                    fail_count = fail_count + 1;
                end
            end
            #10;
        end
    endtask: read_from_slv

    task publish_results();
        $display("+---------------------------------------------------------------+");
        $display("|                             Scoreboard                        |");
        $display("+---------------------------------------------------------------+");
        $display("|First in first out condition|Pass count |Fail count |Total count|");
        $display("|                            |%d|%d|%d|",pass_count,fail_count,pass_count+fail_count);
        $display("+---------------------------------------------------------------+");
        $display("+---------------------------------------------------------------+");
    endtask: publish_results

    function bit is_success();
        if(fail_count != 0) begin
            $display("[packet_subscriber#is_success()]-DUT is perfect!");
        end
        else begin
            $display("[packet_subscriber#is_success()]-There is issues some issues");
        end
    endfunction: is_success
endclass: packet_subscriber