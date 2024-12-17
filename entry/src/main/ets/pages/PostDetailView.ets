import { CalendarDay } from '../model/CalendarDay'
import router from '@ohos.router'

@Entry
@Component
struct PostDetailView {
  @Prop post: CalendarDay
  private cardPadding: number = 24
  private dateSpacing: number = 12

  aboutToAppear(): void {
    let params = router.getParams() as object
    this.post = params['post'] as CalendarDay
  }

  build() {
    Column() {
      Column({ space: 0 }) {
        // 图片部分
        Image(this.post.imageUrl)
          .width('100%')
          .objectFit(ImageFit.Cover)
          .clip(true)
          .backgroundColor(Color.Gray)

        // 内容部分
        Column({ space: 16 }) {
          Row({ space: 12 }) {
            // 标题和副标题
            Column({ space: 8 }) {
              Text(this.post.title)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)

              if (this.post.subtitle) {
                Text(this.post.subtitle)
                  .fontSize(16)
                  .fontColor(Color.Gray)
              }
              // 描述文本
              Text(this.post.desc)
                .fontSize(16)
                .fontColor(Color.Black)
                .margin({ top: 8 })
            }
            .width(0)
            .flexGrow(1)
            .alignItems(HorizontalAlign.Start)

            Column({ space: 8 }) {
              Text(this.post.day)
                .fontSize(48)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)

              if (this.post.holiday?.length == 0) {
                Text(this.post.month)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Black)
              } else {
                Text(this.post.holiday)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Black)
              }
            }
          }
          .width('100%')

          // .alignItems(VerticalAlign.Top)

          // 日期信息
          Column({ space: 2 }) {
            Text(`${this.post.lunar}   ${CalendarDay.getWeekStr(this.post.weekday)}   ${this.post.solarTerm}`)
              .fontColor(Color.Gray)
            Text(this.post.weekStr)
              .fontSize(16)
              .fontColor(Color.Gray)
          }
          .margin({ top: 8, bottom: 8 })
        }
        .padding(this.cardPadding)
        .width('100%')
      }
      .backgroundColor(Color.White)
      .clip(true)
      .shadow({
        radius: 8,
        color: Color.Gray,
        offsetX: 0,
        offsetY: 4
      })

      Text("🐱 猫咪日历2025")
        .fontSize(16)
        .fontStyle(FontStyle.Italic)
        .margin({top: 24})
        .fontColor(Color.Gray)
        .onClick(()=>{
          router.back()
        })
    }
  }
}

export { PostDetailView }