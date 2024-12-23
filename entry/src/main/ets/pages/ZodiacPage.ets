// ZodiacPage.ets
import router from '@ohos.router'
import { CalendarDay } from '../model/CalendarDay'
import { Zodiac } from '../model/Zodiac'
import { ZodiacStore } from '../ZodiacStore'
import zodiacList from 'resources/rawfile/zodiac_list.json'

@Entry
@Component
struct ZodiacPage {
  @Prop post: CalendarDay
  private zodiac?: Zodiac
  private cardPadding: number = 24
  private dateSpacing: number = 12

  aboutToAppear(): void {
    let params = router.getParams() as object
    this.post = params['post'] as CalendarDay
  }

  @State glow: boolean = false // 控制光芒效果的动画状态
  // 星座图片的背景 URL
  private skyImageUrl: string = "https://maoxun.oss-cn-hangzhou.aliyuncs.com/image/img_star_sky.jpg"

  build() {
    Stack() {
      // 背景图层
      Image(this.skyImageUrl)
        .objectFit(ImageFit.Fill)
        .width('100%')
        .height('100%')
        .expandSafeArea([SafeAreaType.SYSTEM])

      Scroll() {
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
            }
            .width('100%')
          }
          .padding(this.cardPadding)
          .width('100%')
        }
        .backgroundColor('#DDFFFFFF')
        .borderRadius(16)
        .clip(true)
        .shadow({
          radius: 8,
          color: Color.Gray,
          offsetX: 0,
          offsetY: 4
        })
        .margin({
          top: 100,
          left: this.cardPadding,
          right: this.cardPadding,
          bottom: 64
        })
      }
      .expandSafeArea([SafeAreaType.SYSTEM])

      Stack() {
        // 返回按钮
        Row() {
          Text('←')// Unicode 左箭头符号
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .padding(this.cardPadding)
            .onClick(() => {
              router.back() // 返回逻辑
            })
          Text()
            .flexGrow(1)
        }
        .width('100%')

        Text('星座')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
    }
    .alignContent(Alignment.Top)
    .backgroundColor('#000') // 设置页面背景颜色
    .expandSafeArea([SafeAreaType.SYSTEM])
    // .backgroundColor(Color.Black)
    .onAppear(() => {
      if (this.zodiac == null) {
        if (Object.keys(ZodiacStore.getInstance().getZodiacData()).length == 0) {
          ZodiacStore.getInstance().setZodiacData(zodiacList)
          this.setPost()
        } else {
          this.setPost()
        }
      }
      this.glow = true
    })
    .onDisAppear(() => {
      this.glow = false
    })
  }

  private setPost() {
    let emoji = CalendarDay.getZodiacSign(this.post.datestamp)
    let zodiac = ZodiacStore.getInstance().getZodiacData()[emoji]
    this.zodiac = zodiac
    this.post.title = zodiac.zh + " " + zodiac.emoji
    this.post.subtitle = zodiac.period
    this.post.desc = zodiac.summary
    this.post.imageUrl = zodiac.imageUrl
    console.log("set Zodiac post")
  }
}