virtual class data_packet;
    // convert packet data fields to byte stream (wire format) in correct order
    pure virtual function u8_array serialize();
    
    // convert byte stream (wire format) to packet date fields
    pure virtual function bit deserialize(u8_array second_packet);

    // compare two packets
    pure virtual function bit do_compare(data_packet second_packet);
endclass: data_packet