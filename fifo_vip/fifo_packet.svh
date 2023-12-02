//------------------------------------------------------------------------------
//
// CLASS: fifo_packet
//
// this is an extended class of data_packet class and thisdefines all 
// the vitual functions introduced in the data_packet class. 
//------------------------------------------------------------------------------
class fifo_packet extends data_packet;
    u8_array    data_buffer;
    
    // Function: new
    //
    // This implements the constructor for the fifo_packet class.
    function new();
    endfunction

    // Function: serialize.
    //
    // function to return the data_packet.
    function u8_array serialize();
        return data_buffer;
    endfunction

    // Function: deserialize.
    //
    // function to returns 1 if the loaded packet is not a null packet.
    function bit deserialize(u8_array second_packet);
        data_buffer = second_packet;
        if(data_buffer.size() != 0) begin
            return 1'b1;
        end
        else begin
            return 1'b0;
        end
    endfunction

    // Function: post_randomize.
    //
    // function that randomize the packet properties for generation.
    function void post_randomize();
        int         MIN_SIZE            = 1;
        int         MAX_SIZE            = 10;
        int         MIN_VALUE_OF_RANGE  = 10;
        int         MAX_VALUE_OF_RANGE  = 100;
        u8_array    data;
        //Concatinate 
        for(int i = 0; i<$urandom_range(MIN_SIZE, MAX_SIZE); i++) begin
            data_buffer.push_back($urandom_range(MIN_VALUE_OF_RANGE, MAX_VALUE_OF_RANGE));
        end
    endfunction: post_randomize

    // Function: do_compare.
    //
    // function returns 1 if the compared two packets are identical.
    function bit do_compare(data_packet second_packet);
        bit is_identical = 1'b1;
        fifo_packet second_fifo_packet;
        type_check: assert ($cast(second_fifo_packet, second_packet))
            else $fatal(1, "**** fifo_packet.do_compare() - packet types of comparing packets mismatch!!! ****");
    
        foreach(second_fifo_packet.data_buffer[i]) begin
            if(this.data_buffer[i] == second_fifo_packet.data_buffer[i]) begin
                is_identical = is_identical & 1'b1;
            end
            else begin
                is_identical = is_identical & 1'b0;
            end
        end
        return is_identical;
    endfunction: do_compare

endclass : fifo_packet