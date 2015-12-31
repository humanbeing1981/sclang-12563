
// rain & thunder  by Alexandros S. Skentos
(
SynthDef.new(\winds, {
	arg freq=440,  atk=1, rel=3, amp=1, pan=0, thresh=0.5, length=15;
	var sig, env, sig2, sig3, input, onsets, mod;
	input = In.ar (Server.default.options.numOutputBusChannels);
	onsets = Onsets.kr (FFT(LocalBuf (1024), input));
	mod=Decay.kr (onsets,length,0.5);
	sig=GrayNoise.ar (0.2);
	sig2=LFNoise2.ar (freq, 0.05)*mod;
	sig3=LFNoise1.ar(freq, 0.04)*mod;

	env=EnvGen.kr(Env.new([0,1,0],[atk,rel],[1,-1]));
	sig=Pan2.ar(sig,pan,amp);
	sig=[sig+sig2+sig3]*env;
	Out.ar(0,sig);
	Out.ar(1,sig);
}).send;


Pdef(\machinecontrols,
	Pbind(
	\instrument, \winds,
		\freq, Pexprand(100,880,inf),
		\dur, Pseq([Pwhite(0.05,0.9)],inf),
		\midinote, Pseq([rrand(80,120)],inf),
		\harmonic, Pexprand(1,80,inf).round,
	    \thresh, Pwhite(0.5,0.8,inf),
		\length, Pwhite(7,25,inf),
		\atk, Pwhite(2.0,3.0,inf),
		\rel, Pwhite(2.0,3.0,inf),
		\pan, Pwhite(-0.8,0.8,inf),


).play);

)


//use microphone for huge thunders !!!!

