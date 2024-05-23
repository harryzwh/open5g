#!/usr/bin/env python3

from gnuradio import blocks
from gnuradio import gr
from gnuradio import zeromq

class channel(gr.top_block):

    def __init__(self):
        gr.top_block.__init__(self, "Not titled yet", catch_exceptions=True)
        self.samp_rate = samp_rate = 23040000
        
        self.gNB_DL = zeromq.req_source(gr.sizeof_gr_complex, 1, 'tcp://172.30.0.100:2000', 100, False, -1)
        self.gNB_UL = zeromq.rep_sink(gr.sizeof_gr_complex, 1, 'tcp://172.30.0.201:2000', 100, False, -1)
        self.UE_UL=[zeromq.req_source(gr.sizeof_gr_complex, 1, 'tcp://172.30.0.10{}:2000'.format(idx), 100, False, -1) for idx in range(1,4)]
        self.UE_DL=[zeromq.rep_sink(gr.sizeof_gr_complex, 1, 'tcp://172.30.0.201:200{}'.format(idx), 100, False, -1) for idx in range(1,4)]
        self.spliter = blocks.throttle(gr.sizeof_gr_complex*1, samp_rate,True)
        self.adder = blocks.add_vcc(1)

        self.connect((self.gNB_DL, 0), (self.spliter, 0))
        for ue in self.UE_DL:
            self.connect((self.spliter, 0), (ue, 0))
        
        for idx, ue in enumerate(self.UE_UL):
            self.connect((ue, 0), (self.adder, idx))
        self.connect((self.adder, 0), (self.gNB_UL, 0))

if __name__ == '__main__':
    channel().run()