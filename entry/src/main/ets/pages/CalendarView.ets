import { CalendarDay } from '../model/CalendarDay';
import { CalendarViewModel } from '../viewmodel/CalendarViewModel';
import { PostCardView } from './PostCardView';

@Preview
@Entry
@Component
struct CalendarView {
  @State viewModel: CalendarViewModel = new CalendarViewModel();
  private scroller: ListScroller = new ListScroller()

  build() {
    Column({ space: 16 }) {
      // Show loading state
      if (this.viewModel.isLoading) {
        Text('Loading...')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center);
      } else {
        List({ space: 8, scroller: this.scroller }) {
          ForEach(this.viewModel.calendarDays, (item: CalendarDay, index: number) => {
            PostCardView({ post: item })
              .id(item.datestamp)
          })
        }
        // .expandSafeArea([SafeAreaType.SYSTEM])
      }
    }
    .onAppear(() => {
      if(this.viewModel.calendarDays.length < 30){
        this.viewModel.fetchCalendarDays()
          .then(()=>{
            const today = this.getTodayDate();
            const firstDate = this.viewModel.calendarDays[0]?.datestamp || '';
            const lastDate = this.viewModel.calendarDays[this.viewModel.calendarDays.length - 1]?.datestamp || '';
            // 检查今天是否在范围内
            if (today > firstDate && today < lastDate) {
              console.info(`Today's date ${today} is within range: ${firstDate} - ${lastDate}`);
              // 找到今天日期所在的索引
              const targetIndex = this.viewModel.calendarDays.findIndex(day => day.datestamp === today);
              // 如果找到对应索引，滚动到目标项
              if (targetIndex >= 0) {
                setTimeout(()=>{
                  this.scroller.scrollToIndex(targetIndex, false)
                }, 100)
              } else {
                console.warn('Today is within range but not found in the list');
              }
            } else {
              console.warn(`Today's date ${today} is out of range: ${firstDate} - ${lastDate}`);
            }
          })
      }
    })
  }
  // 获取今天的日期，格式为 YYYYMMDD
  private getTodayDate(): string {
    const today = new Date();
    const year = today.getFullYear();
    const month = (today.getMonth() + 1).toString().padStart(2, '0'); // 月份补零
    const day = today.getDate().toString().padStart(2, '0'); // 日期补零
    console.log("现在的时间" + today.getHours() + ":" + today.getMinutes())
    return `${year}${month}${day}`; // 返回 YYYYMMDD 格式
  }
}