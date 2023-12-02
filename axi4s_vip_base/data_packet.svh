//------------------------------------------------------------------------------
//
// CLASS: data_packet
//
// base class for describing packet architecture
//------------------------------------------------------------------------------
virtual class data_packet;

    // Function: serialize.
    //
    // virtual function to return the data_packet.
    pure virtual function u8_array serialize();
    
    // Function: deserialize.
    //
    // virtual function to returns 1 if the loaded packet is not a null packet.
    pure virtual function bit deserialize(u8_array second_packet);

    // Function: do_compare.
    //
    // virtual function returns 1 if the compared two packets are identical.
    pure virtual function bit do_compare(data_packet second_packet);

endclass: data_packet