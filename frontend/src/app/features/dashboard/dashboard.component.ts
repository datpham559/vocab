import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { DashboardService } from '../../core/services/dashboard.service';
import { StudyService } from '../../core/services/study.service';
import { Dashboard } from '../../core/models/dashboard.model';

interface HeatmapDay {
  date: Date;
  dateStr: string;
  count: number;
  level: number;
  empty: boolean;
}

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {
  dashboard = signal<Dashboard | null>(null);
  loading = signal(true);
  reviewCount = signal(0);

  heatmapWeeks: HeatmapDay[][] = [];
  monthLabels: { label: string; weekIdx: number }[] = [];
  totalActiveDays = 0;
  totalWordsThisYear = 0;

  readonly dayLabels = ['', 'T2', '', 'T4', '', 'T6', ''];

  constructor(
    private dashboardService: DashboardService,
    private studyService: StudyService
  ) {}

  ngOnInit(): void {
    this.dashboardService.getDashboard().subscribe({
      next: data => { this.dashboard.set(data); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
    this.studyService.getReviewCount().subscribe({
      next: res => this.reviewCount.set(res.count),
      error: () => {}
    });
    this.dashboardService.getActivity().subscribe({
      next: data => this.buildHeatmap(data),
      error: () => this.buildHeatmap([])
    });
  }

  private buildHeatmap(data: { date: string; wordsStudied: number }[]): void {
    const map = new Map<string, number>();
    data.forEach(d => map.set(d.date, d.wordsStudied));

    this.totalActiveDays = data.length;
    this.totalWordsThisYear = data.reduce((s, d) => s + d.wordsStudied, 0);

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    // Start from the Sunday 51 full weeks before current week's Sunday
    const start = new Date(today);
    start.setDate(start.getDate() - today.getDay() - 7 * 51);

    const weeks: HeatmapDay[][] = [];
    const cur = new Date(start);

    while (cur <= today || (weeks.length > 0 && weeks[weeks.length - 1].length < 7)) {
      if (cur.getDay() === 0) weeks.push([]);
      const dateStr = this.toISODate(cur);
      const count = map.get(dateStr) ?? 0;
      const future = cur > today;
      weeks[weeks.length - 1].push({
        date: new Date(cur),
        dateStr,
        count,
        level: future ? 0 : this.countToLevel(count),
        empty: future
      });
      cur.setDate(cur.getDate() + 1);
    }

    this.heatmapWeeks = weeks;

    // Month labels
    const monthNames = ['Th1','Th2','Th3','Th4','Th5','Th6','Th7','Th8','Th9','Th10','Th11','Th12'];
    const labels: { label: string; weekIdx: number }[] = [];
    let lastMonth = -1;
    weeks.forEach((week, wi) => {
      const first = week.find(d => !d.empty);
      if (first) {
        const m = first.date.getMonth();
        if (m !== lastMonth) {
          labels.push({ label: monthNames[m], weekIdx: wi });
          lastMonth = m;
        }
      }
    });
    this.monthLabels = labels;
  }

  getMonthLabel(weekIdx: number): string {
    return this.monthLabels.find(l => l.weekIdx === weekIdx)?.label ?? '';
  }

  private countToLevel(n: number): number {
    if (n === 0) return 0;
    if (n <= 3) return 1;
    if (n <= 7) return 2;
    if (n <= 12) return 3;
    return 4;
  }

  private toISODate(d: Date): string {
    const y = d.getFullYear();
    const m = String(d.getMonth() + 1).padStart(2, '0');
    const day = String(d.getDate()).padStart(2, '0');
    return `${y}-${m}-${day}`;
  }

  get progressPercent(): number {
    const d = this.dashboard();
    if (!d) return 0;
    const total = d.newCount + d.learningCount + d.reviewCount + d.masteredCount;
    return total > 0 ? Math.round((d.masteredCount / total) * 100) : 0;
  }

  get todayPercent(): number {
    const d = this.dashboard();
    if (!d || d.todayTotalWords === 0) return 0;
    return Math.round((d.todayWordsStudied / d.todayTotalWords) * 100);
  }
}
