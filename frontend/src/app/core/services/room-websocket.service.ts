import { Injectable, OnDestroy } from '@angular/core';
import { Client, IMessage } from '@stomp/stompjs';
import { Subject } from 'rxjs';
import { AuthService } from './auth.service';
import { RoomEvent } from '../models/room.model';

// eslint-disable-next-line @typescript-eslint/no-explicit-any
declare const require: (module: string) => any;

@Injectable({ providedIn: 'root' })
export class RoomWebSocketService implements OnDestroy {
  private client: Client | null = null;
  private events$ = new Subject<RoomEvent>();
  private currentCode = '';

  constructor(private authService: AuthService) {}

  connect(code: string): Subject<RoomEvent> {
    this.currentCode = code;
    const token = this.authService.getToken();

    this.client = new Client({
      webSocketFactory: () => {
        const SockJS = require('sockjs-client');
        return new SockJS('/ws');
      },
      connectHeaders: { Authorization: `Bearer ${token ?? ''}` },
      reconnectDelay: 5000,
      onConnect: () => {
        console.log('[WS] Connected to room', code);
        this.client!.subscribe(`/topic/room/${code}`, (msg: IMessage) => {
          try {
            const event: RoomEvent = JSON.parse(msg.body);
            this.events$.next(event);
          } catch {}
        });
      },
      onDisconnect: () => console.log('[WS] Disconnected'),
      onStompError: (frame) => console.error('[WS] STOMP error', frame),
      onWebSocketError: (evt) => console.error('[WS] WebSocket error', evt),
    });

    this.client.activate();
    return this.events$;
  }

  sendChat(text: string): void {
    if (!this.client?.connected || !text.trim()) return;
    this.client.publish({
      destination: `/app/room/${this.currentCode}/chat`,
      body: JSON.stringify({ text: text.trim() })
    });
  }

  sendReact(emoji: string): void {
    if (!this.client?.connected) return;
    this.client.publish({
      destination: `/app/room/${this.currentCode}/react`,
      body: JSON.stringify({ emoji })
    });
  }

  disconnect(): void {
    this.client?.deactivate();
    this.client = null;
  }

  ngOnDestroy(): void {
    this.disconnect();
  }
}
