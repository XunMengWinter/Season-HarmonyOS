import { CalendarDay } from '../model/CalendarDay';
import { CalendarViewModel } from '../viewmodel/CalendarViewModel';
import { PostCardView } from './PostCardView';

@Entry
@Component
struct CalendarView {
  @State viewModel: CalendarViewModel = new CalendarViewModel();

  build() {
    Column({ space: 16 }) {
      // Show loading state
      if (this.viewModel.isLoading) {
        Text('Loading...')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center);
      } else {
        List({ space: 8 }) {
          ForEach(this.viewModel.calendarDays, (item: CalendarDay, index: number) => {
            PostCardView({ post: item });
          })
        }
      }
    }
    .padding(16)
    .onAppear(() => {
      this.viewModel.fetchCalendarDays();
    });
  }
}