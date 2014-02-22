import processing.video.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

class AudioManager {

  Minim minim;
  AudioInput in;
  AudioOutput out;
  AudioRecorder recorder;
  AudioPlayer player;
  String audioFileName;
  
  boolean recording = false;

  AudioManager(Object sketch) {
    minim = new Minim(sketch);
    in = minim.getLineIn();
    out = minim.getLineOut(Minim.STEREO);
  }

  boolean isRecording() {
    return recorder != null && recorder.isRecording();
  }

  boolean isPlaying() {
    return player != null && player.isPlaying();
  }

  void startRec() {
    if (!isRecording()) {
      audioFileName = createWavFileName();
      println("Recording audio to " + audioFileName);
      recorder = minim.createRecorder(in, audioFileName);
      recorder.beginRecord();
    }
  }

  void stopRec() {
    if (isRecording()) {
      println("Stopping recording audio to " + audioFileName);
      recorder.endRecord();
      recorder.save();
      player = minim.loadFile(audioFileName);
    }
  }

  void startPlay() {
    if (!isPlaying()) {
      player.rewind();
      player.play();
    }
  }
                  
  void stopPlay() {
    if (isPlaying()) {
      player.mute();
    }
  }

  String createWavFileName() {
    String fileName = "vodka_record-" + year() + "-" + month() + "-" + day() + ":"
      + hour() + ":" + minute() + ":" + second() + ".wav";
    return fileName;
  }




  
}
