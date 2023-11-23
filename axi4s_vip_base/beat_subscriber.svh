class beat_subscriber #(
    type packet_t           = data_packet
);
    axi4stream_monitor_transaction                              beat_queue[$];
    packet_t                                                    packet_queue[$];
    axi4s_item_collected_port                                   item_collection_port;

    function new(
        ref axi4s_item_collected_port     item_collection_port
    );
        this.item_collection_port = item_collection_port;
    endfunction: new

    task do_work();
        forever begin
            axi4stream_monitor_transaction      current_transaction;
            packet_t                            current_packet;
            u8                                  current_data;
            u8_array                            current_packet_with_u8_type;
            xil_axi4stream_strb              for_ex_keep[$];
            
            item_collection_port.get(current_transaction);
            
            if(current_transaction.get_keep_beat() == 1) begin
                beat_queue.push_back(current_transaction);
                if(current_transaction.get_last()) begin
                    foreach (beat_queue[i]) begin
                        current_data = u8'(beat_queue[i].get_data_beat());
                        current_packet_with_u8_type.push_back(current_data);
                    end
                    beat_queue.delete();
                    current_packet = new();
                    current_packet.deserialize(current_packet_with_u8_type);
                    packet_queue.push_back(current_packet);
                    current_packet_with_u8_type.delete();
                end
            end
        end
    endtask: do_work

    function packet_t pop();
        packet_t null_packet;
        if(packet_queue.size() != 0) begin
            return packet_queue.pop_front();
        end
        else begin
            null_packet = new();
            return null_packet;
        end
    endfunction: pop
endclass: beat_subscriber