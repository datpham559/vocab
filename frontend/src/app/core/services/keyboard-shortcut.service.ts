import { Injectable, signal } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class KeyboardShortcutService {
  private readonly KEY = 'vocab_kbd_hints';
  hintsEnabled = signal(localStorage.getItem(this.KEY) !== 'false');

  toggle(): void {
    const next = !this.hintsEnabled();
    this.hintsEnabled.set(next);
    localStorage.setItem(this.KEY, String(next));
  }
}
