// ************************************************************************************************************************
//
// ACCELR, Sri Lanka            https://accelr.lk
// No 175/95, John Rodrigo Mw,  info@accelr.net
// Katubedda, Sri Lanka
//
// ************************************************************************************************************************
//
// PROJECT      :   axi_fifo_unit_test
// PRODUCT      :   axi_fifo_unit_test
// FILE         :   fifo_model.svh
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   support file for axi_fifo_unit_test project
//
// ************************************************************************************************************************
//
// REVISIONS:
//
//  Date           Developer               Description
//  -----------    --------------------    -----------
//  13-JUN-2023    Kasun Buddhi            Creation
//  4-DEC-2023     Sachith Rathnayake      Updated
//
//*************************************************************************************************************************

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