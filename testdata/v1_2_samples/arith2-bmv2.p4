#include "core.p4"
#include "v1model.p4"

header hdr {
    bit<32> a;
    bit<32> b;
    bit<8> c;
}

#include "arith-skeleton.p4"

control ingress(inout Headers h, inout Meta m, inout standard_metadata_t sm) {
    action compare()
    { h.h.c = (bit<8>)(bit<1>)(h.h.a < h.h.b); sm.egress_spec = 0; }
    table t() {
        actions = { compare; }
        // const default_action = add;  // not yet supported by BMv2
    }
    apply { t.apply(); }
}

V1Switch(p(), vrfy(), ingress(), egress(), update(), deparser()) main;