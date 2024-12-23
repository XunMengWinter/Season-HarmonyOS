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
    Stack() {
      Scroll() {
        Column() {
          Text('←')// Unicode 左箭头符号
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .padding(16)
            .opacity(0)
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

            }
            .padding(this.cardPadding)
            .width('100%')
          }
          .backgroundColor(Color.White)
          .clip(true)
          .shadow({
            radius: 16,
            color: "#3888",
            offsetX: 0,
            offsetY: 8
          })

          // 日期信息
          Row({ space: 8 }) {
            Text(CalendarDay.getZodiacSign(this.post.datestamp))
              .fontSize(20)
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/ZodiacPage', params: {
                    post: this.post
                  }
                })
              })

            Text(`${CalendarDay.getWeekStr(this.post.weekday)}   ${this.post.lunar}   ${this.post.solarTerm}`)
              .fontSize(16)
              .fontColor(Color.Gray)
          }
          .margin({ top: 32, bottom: 8 })

          Row({ space: 8 }) {
            Text("🐱 猫龄换算")
              .fontSize(16)
              .fontColor(Color.Gray)
              .onClick(()=>{
                router.pushUrl({
                  url: "pages/CatAgeCalculatorPage"
                })
              })

            Text("养猫知识 📖")
              .fontSize(16)
              .fontColor(Color.Gray)
          }
          .margin({ top: 32, bottom: 8 })

          Text("🐱 猫咪日历2025")
            .fontSize(16)
            .fontStyle(FontStyle.Italic)
            .margin({ top: 24 })
            .fontColor(Color.Gray)
            .onClick(() => {
              router.back()
            })
        }

      }
      .scrollBar(BarState.Off)
      .expandSafeArea([SafeAreaType.SYSTEM])

      Row() {
        Text('←')// Unicode 左箭头符号
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .padding(16)
          .onClick(() => {
            router.back() // 返回逻辑
          })
        Text(CalendarDay.getSimpleStr(this.post.datestamp))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            router.back() // 返回逻辑
          })
      }
      .width('100%')
    }
    .alignContent(Alignment.Top)
    .expandSafeArea([SafeAreaType.SYSTEM])
  }
}

export { PostDetailView }