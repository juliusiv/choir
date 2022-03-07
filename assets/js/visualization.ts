import { Analyser } from "tone";

export class Visualizer {
  analyser: Analyser;
  canvasElement: HTMLCanvasElement;
  dataArray: Uint8Array;

  constructor(canvasElement) {
    this.canvasElement = canvasElement;
    this.analyser = new Analyser("waveform", 2048);
    this.analyser.channelCount = 1;
    // this.analyser.size
    // this.bufferLength = this.analyser.frequencyBinCount;
    this.dataArray = new Uint8Array(this.analyser.size);
  }

  renderFrame() {
    requestAnimationFrame(this.renderFrame.bind(this));
    const height = this.canvasElement.height;
    const width = this.canvasElement.width;

    const canvasContext = this.canvasElement.getContext("2d");
    canvasContext.clearRect(0, 0, width, height);
    canvasContext.lineWidth = 5;
    canvasContext.strokeStyle = "black";
    canvasContext.beginPath()
    const waveform = this.analyser.getValue() as Float32Array;
    // console.log(waveform)

    // canvasContext.moveTo(0, 0)
    // canvasContext.moveTo(100, 100)
    // canvasContext.lineTo(100, 0)
    // console.log(waveform)
    // console.log(canvasContext)
    for (let i = 0; i < waveform.length; i++) {
      const x = i
      const y = (0.5 + waveform[i] / 2) * height;
      // console.log(y)
      if (i == 0) {
        canvasContext.moveTo(x, y)
      } else {
        canvasContext.lineTo(x, y)
      }
    }

    canvasContext.stroke();
  }
}