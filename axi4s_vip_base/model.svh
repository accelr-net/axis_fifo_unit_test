//------------------------------------------------------------------------------
//
// CLASS: model
//
// This is the base class for the DUT model/predictor. Anyone hoping to utilize the 
// axi4_vip_base package should derive their DUT model from this class
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