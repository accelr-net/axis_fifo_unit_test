class fifo_packet extends data_packet;
    rand u8_array    data_buffer; //for using randomize()
    // u8_array    data_buffer; //for using post_randomize()
    
    function new();
    endfunction

    function u8_array serialize();
        return data_buffer;
    endfunction

    function bit deserialize(u8_array second_packet);
        data_buffer = second_packet;
        if(data_buffer.size() != 0) begin
            return 1'b1;
        end
        else begin
            return 1'b0;
        end
    endfunction

    function void post_randomize();
        int         MAX_SIZE            = 10;
        int         MIN_VALUE_OF_RANGE  = 10;
        int         MAX_VALUE_OF_RANGE  = 100;
        u8_array    data;
        //concaticate 
        for(int i = 0; i<$urandom_range(1,MAX_SIZE); i++) begin
            data_buffer.push_back($urandom_range(MIN_VALUE_OF_RANGE,MAX_VALUE_OF_RANGE));
        end
    endfunction: post_randomize

    function bit do_compare(data_packet second_packet);
        bit is_identical = 1'b1;
        fifo_packet second_fifo_packet;
        type_check: assert ($cast(second_fifo_packet, second_packet))
            else $fatal(1, "**** cast fail!!! ****");
    
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