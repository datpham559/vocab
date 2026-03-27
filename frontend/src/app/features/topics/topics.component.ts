import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterLink } from '@angular/router';
import { StudyService, CategoryInfo } from '../../core/services/study.service';

const CATEGORY_LABELS: Record<string, string> = {
  'Achievement': 'Thành tích', 'Actions': 'Hành động', 'Animals': 'Động vật',
  'Body': 'Cơ thể', 'Business': 'Kinh doanh', 'Character': 'Tính cách',
  'Clothing': 'Quần áo', 'Communication': 'Giao tiếp', 'Culture': 'Văn hóa',
  'Descriptive': 'Mô tả', 'Education': 'Giáo dục', 'Emotions': 'Cảm xúc',
  'Entertainment': 'Giải trí', 'Food': 'Thực phẩm', 'General': 'Chung',
  'Health': 'Sức khỏe', 'Home': 'Nhà cửa', 'Language': 'Ngôn ngữ',
  'Nature': 'Thiên nhiên', 'People': 'Con người', 'Places': 'Địa điểm',
  'Politics': 'Chính trị', 'Shopping': 'Mua sắm', 'Social': 'Xã hội',
  'Technology': 'Công nghệ', 'Thinking': 'Tư duy', 'Time': 'Thời gian',
  'Transport': 'Giao thông', 'Travel': 'Du lịch', 'Work': 'Công việc',
};

const CATEGORY_ICONS: Record<string, string> = {
  'Achievement': '🏆', 'Actions': '⚡', 'Animals': '🐾',
  'Body': '🧍', 'Business': '💼', 'Character': '⭐',
  'Clothing': '👔', 'Communication': '💬', 'Culture': '🎭',
  'Descriptive': '🎨', 'Education': '📚', 'Emotions': '😊',
  'Entertainment': '🎬', 'Food': '🍎', 'General': '📝',
  'Health': '🏥', 'Home': '🏠', 'Language': '🗣️',
  'Nature': '🌿', 'People': '👥', 'Places': '🗺️',
  'Politics': '🏛️', 'Shopping': '🛍️', 'Social': '🤝',
  'Technology': '💻', 'Thinking': '🧠', 'Time': '⏰',
  'Transport': '🚗', 'Travel': '✈️', 'Work': '⚙️',
};

@Component({
  selector: 'app-topics',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './topics.component.html',
  styleUrls: ['./topics.component.scss']
})
export class TopicsComponent implements OnInit {
  categories = signal<CategoryInfo[]>([]);
  loading = signal(true);

  constructor(private studyService: StudyService, private router: Router) {}

  ngOnInit(): void {
    this.studyService.getCategories().subscribe({
      next: data => { this.categories.set(data); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }

  getLabel(cat: string): string {
    return CATEGORY_LABELS[cat] ?? cat;
  }

  getIcon(cat: string): string {
    return CATEGORY_ICONS[cat] ?? '📖';
  }

  startStudy(category: string): void {
    this.router.navigate(['/study'], { queryParams: { category } });
  }

  browseWords(category: string): void {
    this.router.navigate(['/words'], { queryParams: { category } });
  }
}
