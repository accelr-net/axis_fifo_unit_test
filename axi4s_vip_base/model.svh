virtual class model #(
    type packet_t = data_packet
); 
    typedef packet_t    packet_t_queue[$];
        
    pure virtual function packet_t_queue get_expected_packet(packet_t input_packet);
endclass: model