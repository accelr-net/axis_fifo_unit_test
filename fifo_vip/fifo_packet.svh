class fifo_packet extends data_packet;
    u8_array    data_packet;
    
    function new();
        this.data_packet = {};
    endfunction

    //TODOs-function - post_randomize()
    function u8_array serialize();
        return data_packet;
    endfunction

    function bit deserialize(u8_array second_packet);
        data_packet = second_packet;
        if(data_packet.size() != 0) begin
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
        int         rand_data;
        u8_array    data;
        //concaticate 
        int packet_length = $urandom_range(1,MAX_SIZE);
        for(int i = 0; i < packet_length; i++) begin
            rand_data = $urandom_range(MIN_VALUE_OF_RANGE,MAX_VALUE_OF_RANGE);
            data_packet.push_back(rand_data);
        end
    endfunction: post_randomize

    function int get_packet_size();
        return data_packet.size();
    endfunction

    function void print();
        for(int i=0; i<this.data_packet.size(); i++)
            $display("data packet [%d] : %d",i,this.data_packet[i]);
    endfunction

    function void clear();
        this.data_packet = {};
    endfunction

    function bit do_compare(fifo_packet second_packet);
        bit is_identical = 1'b1;
        foreach(second_packet.data_packet[i]) begin
            if(this.data_packet[i] == second_packet.data_packet[i]) begin
                is_identical = is_identical & 1'b1;
            end
            else begin
                is_identical = is_identical & 1'b0;
            end
        end
        return is_identical;
    endfunction: do_compare
endclass : fifo_packet