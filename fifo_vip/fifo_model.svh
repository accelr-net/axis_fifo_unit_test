//------------------------------------------------------------------------------
//
// CLASS: fifo_model
//
// this is an extended class of model class and thisdefines all 
// the vitual functions introduced in the model class.
//------------------------------------------------------------------------------
class fifo_model extends model #(fifo_packet);

    // Function: get_expected_packet.
    //
    // function to introduce get_expected_packet function.
    function packet_t_queue get_expected_packet(fifo_packet input_packet);
        fifo_packet             expected_values[$];
        expected_values[0]    = input_packet;
        return expected_values;
    endfunction
    
endclass: fifo_model