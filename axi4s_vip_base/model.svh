//------------------------------------------------------------------------------
//
// CLASS: model
//
// base class for describing model architecture which behaves like the axi_fifo
//------------------------------------------------------------------------------
virtual class model #(
    type packet_t = data_packet
); 

    // Type definitions: design base types. 
    //
    // packet_t_queue.
    typedef packet_t    packet_t_queue[$];

    // Function: get_expected_packet.
    //
    // virtual function to introduce get_expected_packet function.
    pure virtual function packet_t_queue get_expected_packet(packet_t input_packet);

endclass: model