// Auscultation is a skill that requires substantial clinical experience, a fine stethoscope and good listening skills.
s.boot;
(
SynthDef(\ausc, {arg freq=350, vol=0.15;

	~sig2=SinOsc.ar([Amplitude.kr(SoundIn.ar(0))]*freq,0,vol);


	Out.ar(0,~sig2);
	Out.ar(1,~sig2);
	}).send(s);



)

(
var awindow, myslider, myknob, mybutton;

awindow=FlowView.new(windowTitle:"Auscultation");
myslider=EZSlider(awindow, label:"Volume",controlSpec:[0,1], action:{|mv| x.set("vol",mv.value)}, initVal:0.5);
myknob=EZKnob(awindow, label:"Pitch",controlSpec:\freq, action:{|mn| x.set("freq",mn.value)}, initVal:261.626);

mybutton=Button(awindow, Rect(20,20, 50, 25))
  .states_([["Off", Color.black, Color.grey],
    ["On",Color.black,Color.red]])
  .action_({ arg vbutton;
     if(vbutton.value==1,
      {(
        x=Synth("ausc");
        myslider.value=0.15;
        myknob.value=350;
         )}
     ,
    {x.free});
    });

mybutton.value=0;
FreqScope ();
)











