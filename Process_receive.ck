// (launch with s.ck)

// the patch
TriOsc s => JCRev r => dac;
SinOsc t => r;
.2 => s.gain;
.2 => t.gain;
.5 => r.mix;

// create our OSC receiver
OscRecv recv;
// use port 6449 (or whatever)
11000 => recv.port;
// start listening (launch thread)
recv.listen();

// create an address in the receiver, store in new variable
recv.event( "/foo/notes, i i f" ) @=> OscEvent @ oe;

// infinite event loop
while( true )
{
    // wait for event to arrive
    oe => now;

    // grab the next message from the queue. 
    while( oe.nextMsg() )
    { 
        int i,j;
        float f;

        // getFloat fetches the expected float (as indicated by "i f")
        oe.getInt() => i => Std.mtof => s.freq;
        oe.getInt() => j => Std.mtof => t.freq;
        oe.getFloat() => f => r.gain;
        //0 => s.gain;

        // print
        <<< "got (via OSC):", i, j, f >>>;
    }
}
