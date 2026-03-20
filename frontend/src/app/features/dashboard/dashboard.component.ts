import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { DashboardService } from '../../core/services/dashboard.service';
import { StudyService } from '../../core/services/study.service';
import { Dashboard } from '../../core/models/dashboard.model';

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
