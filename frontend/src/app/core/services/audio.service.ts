import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class AudioService {

  private ctx: AudioContext | null = null;

  private getCtx(): AudioContext {
    if (!this.ctx) this.ctx = new AudioContext();
    if (this.ctx.state === 'suspended') this.ctx.resume();
    return this.ctx;
  }

  private beep(freq: number, duration: number, gain = 0.4, type: OscillatorType = 'sine', startTime = 0): void {
    const ctx = this.getCtx();
    const osc = ctx.createOscillator();
    const g   = ctx.createGain();
    osc.connect(g);
    g.connect(ctx.destination);
    osc.type = type;
    osc.frequency.setValueAtTime(freq, ctx.currentTime + startTime);
    g.gain.setValueAtTime(0, ctx.currentTime + startTime);
    g.gain.linearRampToValueAtTime(gain, ctx.currentTime + startTime + 0.01);
    g.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + startTime + duration);
    osc.start(ctx.currentTime + startTime);
    osc.stop(ctx.currentTime + startTime + duration + 0.05);
  }

  /** Tick for countdown 3-2-1 */
  tick(): void {
    this.beep(880, 0.08, 0.3, 'sine');
  }

  /** Final tick — louder, higher */
  tickFinal(): void {
    this.beep(1320, 0.15, 0.5, 'sine');
  }

  /** Question appears */
  questionReveal(): void {
    this.beep(440, 0.06, 0.25, 'sine', 0);
    this.beep(660, 0.06, 0.25, 'sine', 0.07);
    this.beep(880, 0.12, 0.3,  'sine', 0.14);
  }

  /** Timer ticking (last 5 seconds per question) */
  timerTick(): void {
    this.beep(660, 0.05, 0.15, 'square');
  }

  /** Correct answer */
  correct(): void {
    // C-E-G arpeggio
    this.beep(523, 0.12, 0.35, 'sine', 0);
    this.beep(659, 0.12, 0.35, 'sine', 0.13);
    this.beep(784, 0.22, 0.4,  'sine', 0.26);
  }

  /** Wrong answer */
  wrong(): void {
    this.beep(300, 0.08, 0.35, 'sawtooth', 0);
    this.beep(220, 0.22, 0.3,  'sawtooth', 0.1);
  }

  /** Game start — ascending fanfare */
  gameStart(): void {
    const notes = [523, 659, 784, 1047];
    notes.forEach((freq, i) => this.beep(freq, 0.18, 0.35, 'sine', i * 0.15));
  }

  /** Victory / game end */
  victory(): void {
    const melody = [
      { f: 784, t: 0    }, { f: 784, t: 0.15 }, { f: 784, t: 0.3  },
      { f: 622, t: 0.45 }, { f: 784, t: 0.6  }, { f: 1047, t: 0.75 }
    ];
    melody.forEach(n => this.beep(n.f, 0.18, 0.4, 'sine', n.t));
  }
}
