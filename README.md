<div align="center">
  <a href="https://accelr.lk/">
    <img src="https://avatars.githubusercontent.com/u/55974019?s=200&v=4" alt="Logo" width="80" height="80">
  </a>

  <h1 align="center">AXI4S_VIP</h1>

  <p align="center">
    VIP project
    <br />
  </p>
</div>
</p>

## Content
- [Content](#content)
- [About the project](#about-the-project)
  - [imporant directory with files](#imporant-directory-with-files)
- [Getting Started](#getting-started)
- [Example design](#example-design)

## About the project

our latest creation, a Verification IP (VIP) for a Device Under Test (DUT) that incorporates AXI4-Stream master and slave ports

### imporant directory with files
```
  ../axis_vip_base/
      ├── axi4s_vip_base.sv
      ├── beat_subscriber.svh
      ├── data_packet.svh
      ├── model.svh
      ├── packet_sequence.svh
      └── packet_subscriber.svh
```

## Getting Started

This is an example of how you may give instructions on setting up your project. This example will demostrate how to add verification for a fifo(first in first out design) with a axi4stream slave and a master ports.

1. Download or clone AXI4S_VIP project
  ```
    git clone git@github.com:accelr-net/axi4stream_vip_fifo.git
  ``` 
2. Copy _axi4s_vip_base_ direcory to your project
3. Add _axi4s_vip_base.sv_ file to __add or create design sources__ your Xilinx Vivado simulator
4. Extend your project files with our base classes (You only have to extend ```data_packet, packet_sequence, model```).

## Example design

This is an example of how you may give instructions on setting up your project. This example will demostrate how to add verification for a fifo(first in first out design) with a axi4stream slave and a master ports. example fifo_classes at ```../fifo_vip/ ``` directory

1. Download or clone AXI4S_VIP project
  ```
    git clone git@github.com:accelr-net/axi4stream_vip_fifo.git
  ``` 
1. Added fifo classes </br>
  </br>
  
  _fifo_packet_
  ```SystemVerilog
    class fifo_packet extends data_packet;
      function u8_array serialize();
        //serialize a packet
      endfunction

      function bit deserialize(u8_array another_packet);
        //deserialize a packet
      endfunction

      function bit do_compare(data_packet second_packet);
        //add logic to compare 2 packets (equal or not)
      endfunction
    end 
  ```
  _fifo_packet_sequence_
  ```SystemVerilog
    class fifo_packet_sequence extends packet_sequence #(fifo_packet);
      //give master and slave agents in the constructor
      function new(
        ref mst_agent,
        ref slv_agnet
      );
        super.new(mst_agent,slv_agent)
      endfunction

      //give your sequence at do_mst_work() task
      task do_mst_work();
        //sequence is goes here
      endtask
    endclass
  ```
  _fifo_model_
  ```SysteVerilog
    class fifo_model extends model #(fifo_packet);
      //this gives a expected packet or packets with respect to a given packet
      function packet_t_queue get_expected_packet(fifo_packet input_packet);
        //make a model here
      endfunction
    endclass
  ```
