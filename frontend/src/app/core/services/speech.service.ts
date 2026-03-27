import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class SpeechService {
  private readonly supported = 'speechSynthesis' in window;

  speak(word: string): void {
    if (!this.supported) return;
    window.speechSynthesis.cancel();
    const utterance = new SpeechSynthesisUtterance(word);
    utterance.lang = 'en-US';
    utterance.rate = 0.9;
    window.speechSynthesis.speak(utterance);
  }

  stop(): void {
    if (this.supported) window.speechSynthesis.cancel();
  }
}
