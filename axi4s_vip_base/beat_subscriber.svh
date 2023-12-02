//------------------------------------------------------------------------------
//
// CLASS: beat_subscriber
//
// This class is where the axi4stream master and slave is being monitered with 
// the sent and received packets by pushing back the packets in to the 
// packet_queue and pop_front them in action once intantiated in the design. 
//------------------------------------------------------------------------------
class beat_subscriber #(
    type packet_t   =   data_packet
);
    axi4stream_monitor_transaction  beat_queue[$];
    packet_t                        packet_queue[$];
    axi4s_item_collected_port       item_collection_port;
  
    // Function: new
    //
    // This implements the constructor for the beat_subscriber class.
    function new(
        ref axi4s_item_collected_port   item_collection_port
    );
        this.item_collection_port = item_collection_port;
    endfunction: new

    // Function: do_work
    //
    // This implements the functionality of capturing the packet to the packet_queue of beat_subscriber class.
    task do_work();
        forever begin
            axi4stream_monitor_transaction  current_transaction;
            packet_t                        current_packet;
            u8                              current_data;
            u8_array                        current_packet_with_u8_type;
            xil_axi4stream_strb             for_ex_keep[$];
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
                    if(current_packet.deserialize(current_packet_with_u8_type)>0) begin
                        packet_queue.push_back(current_packet);
                    end
                    current_packet_with_u8_type.delete();
                end
            end
        end
    endtask: do_work

    // Function: pop
    //
    // This implements method of reading back the packets recorded in thew packet_queue.
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