//------------------------------------------------------------------------------
//
// CLASS: data_packet
//
// This is the base sequence-item used by the axi4_vip_base package.
// It is an abstraction of a data packet modeled as a byte array.
// Anyone hoping to utilize the axi4_vip_base package should derive their
// sequence-item from this object.
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