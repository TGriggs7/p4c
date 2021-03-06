#include <core.p4>
#include <v1model.p4>

header ethernet_t {
    bit<48> dst_addr;
    bit<48> src_addr;
    bit<16> eth_type;
}

struct Headers {
    ethernet_t eth_hdr;
}

struct Meta {
}

parser p(packet_in pkt, out Headers hdr, inout Meta m, inout standard_metadata_t sm) {
    state start {
        pkt.extract<ethernet_t>(hdr.eth_hdr);
        transition accept;
    }
}

control ingress(inout Headers h, inout Meta m, inout standard_metadata_t sm) {
    bit<16> tmp;
    bit<16> tmp_0;
    @name("ingress.simple_action") action simple_action() {
        {
            bool hasReturned = false;
            bit<16> retval;
            hasReturned = true;
            retval = 16w4;
        }
        {
            bool hasReturned_0 = false;
            bit<16> retval_0;
            bit<16> tmp_1;
            {
                bool hasReturned_3 = false;
                bit<16> retval_3;
                hasReturned_3 = true;
                retval_3 = 16w4;
                tmp_1 = retval_3;
            }
            hasReturned_0 = true;
            retval_0 = tmp_1;
        }
    }
    apply {
        {
            bool hasReturned_4 = false;
            bit<16> retval_4;
            hasReturned_4 = true;
            retval_4 = 16w4;
            tmp = retval_4;
        }
        tmp_0 = tmp;
        {
            bool hasReturned_5 = false;
            bit<16> retval_5;
            hasReturned_5 = true;
            retval_5 = 16w4;
        }
        simple_action();
    }
}

control vrfy(inout Headers h, inout Meta m) {
    apply {
    }
}

control update(inout Headers h, inout Meta m) {
    apply {
    }
}

control egress(inout Headers h, inout Meta m, inout standard_metadata_t sm) {
    apply {
    }
}

control deparser(packet_out b, in Headers h) {
    apply {
        b.emit<Headers>(h);
    }
}

V1Switch<Headers, Meta>(p(), vrfy(), ingress(), egress(), update(), deparser()) main;

