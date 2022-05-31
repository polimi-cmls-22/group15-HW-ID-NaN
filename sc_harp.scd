
///Boot server and then run everything


(
MIDIIn.connectAll;



~n1 = NetAddr.new("127.0.0.1",1201);

~bend= 8192;
~notes = Array.newClear(128);
~trem = 0;



SynthDef(\plucking2, {arg amp = 0.9, freq = 440, decay = 5, dampen = 0.1, bend=0, trem=0, gate=1;

  var env, snd, modulator;
	env = Env.linen(0, decay, 0).kr(doneAction: 2);
	snd = Pluck.ar(
        in: PinkNoise.ar(amp),
        trig: Impulse.kr(0),
        maxdelaytime: 0.1,
		delaytime: freq.reciprocal *bend.midiratio,
        decaytime: decay,
        coef: dampen);

	modulator = SinOsc.ar(trem).range(0, 0.8);
	snd = snd * modulator * amp;
	Out.ar(0, [snd, snd]);
}).add;




MIDIdef.noteOn(\noteTest, {
	arg vel, nn;
	[vel, nn].postln;

	~n1.sendMsg('\noteOn', nn);

	~notes[nn] = Synth.new(\plucking2,
		[
			\freq, nn.midicps,
			\amp, vel.linexp(1,127, 0.01,1),
			\bend, ~bend.linlin(0,16383,1,-1),
			\trem, ~trem.linlin(0,127, 0,20),
			\gate, 1,

	]
	);

});

MIDIdef.noteOff(\noteOffTest, {
	arg vel, nn;
	[vel, nn];
	~notes[nn].set(\gate, 0);
	~notes[nn]=nil;
	{~n1.sendMsg('\noteOff',nn)}.defer(0.3);
});


MIDIdef.bend(\bendTest, {
	arg val, chan, src;
	[val, chan];
	~n1.sendMsg('\pitch', val);
	//~n1.sendMsg('\pitchB', nn, 200, 0);
	~bend = val;
	~notes.do{arg synth; synth.set(\bend, val.linlin(0, 16383,-1,1))};
}, chan:0);

MIDIdef.cc(\ccTest,{

 	arg val, con;
 	[val, con];
 	~trem = val;
	~n1.sendMsg('\trem', val);
 	~notes.do({
 		arg synth;
		synth.set(\trem, ~trem.linlin(0,127,0,20));
 	});
 }, 10,chan:0);


)





(
MIDIdef(\noteTest).free;
MIDIdef(\noteOffTest).free;
MIDIdef(\bendTest).free;
MIDIdef(\ccTest).free;

)




