import router from '@ohos.router';
import DateUtil from '../net/DateUtil';

@Entry
@Component
struct CatAgeCalculatorPage {
  @State selectedDate: Date = new Date();
  @State dateStr: string = '';
  @State meowAgeStr: string = '第 xx 天';
  @State ageStr: string = 'xx 岁';
  @State showDatePicker: boolean = false;
  private minimumDate: Date = new Date('2000-01-01');
  private maximumDate: Date = new Date();

  build() {
    Stack() {
      Column() {
        Text()
          .flexGrow(1)

        Image($r('app.media.ic_pink_cat'))
          .width(150)
          .height(150)
          .margin({
            left: 50
          })

        // Display the local image
        Image($r('app.media.ic_cat_house'))
          .width(200)
          .height(200)
          .margin({
            top: -8
          })
      }
      .height("100%")

      // Background gradient
      Column() {
        Text('←')// Unicode 左箭头符号
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .padding(16)
          .opacity(0)
        Text('猫咪年龄计算器')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor("#ff4d91b5")
          .margin({ top: 20 });

        Button(("🐣  "  + this.dateStr) || '选择日期')
          .onClick(() => {
            this.showDatePicker = true;
          })
          .backgroundColor("#cdf4e3")
          .fontColor("#505050")
          .fontWeight(FontWeight.Bold)
          .width('70%')
          .borderRadius(10)
          .margin(32)
          .padding(16);

        Column() {
          // Meow Age
          Row() {
            Text('喵龄:')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Gray)
              .flexGrow(1)
            Text(this.meowAgeStr)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor("#85adc2")
          }
          .width("80%")
          .padding(16);

          // Human Equivalent Age
          Row() {
            Text('相当于人类:')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Gray)
              .flexGrow(1)
            Text(this.ageStr)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Orange);
          }
          .width("80%")
          .padding(16);
        }
        .backgroundColor(Color.White)
        .borderRadius(10)
        .margin(24)
        .padding(16);
      }
      .width('100%');

      if (this.showDatePicker) {
        // Date Picker Modal
        Stack() {
          Column() {
            Text('选择猫咪出生日期')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 16 });

            DatePicker({
              selected: this.selectedDate,
              start: this.minimumDate,
              end: this.maximumDate
            })
              .onDateChange(date => {
                this.selectedDate = date;
              })
              .width('90%')
              .margin({ top: 16 });

            Button('确认')
              .onClick(() => {
                this.handleDateChange(this.selectedDate);
                this.showDatePicker = false;
              })
              .margin({ top: 16 })
              .padding({ top: 12, bottom: 12 , left: 24, right: 24});
          }
          .padding({
            left: 16,
            right: 16,
            top: 16,
            bottom: 16
          })
          .backgroundColor(Color.White)
          .borderRadius(16);
        }
        .backgroundColor("#8000")
        .alignContent(Alignment.Center)
        .alignSelf(ItemAlign.Center)
        .width('100%')
        .height('100%');
      }

      Row() {
        Text('←')// Unicode 左箭头符号
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .padding(16)
          .onClick(() => {
            router.back() // 返回逻辑
          })
      }
      .width('100%')
    }
    .alignContent(Alignment.Top)
    .linearGradient({
      direction: GradientDirection.Bottom, // 渐变方向
      repeating: false, // 渐变颜色是否重复
      colors: [[0x500055ff, 0], [0xccffffff, 1]] // 数组末尾元素占比小于1时满足重复着色效果
    })
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM])
    .onAppear(() => {
      if (this.dateStr == "") {
        this.selectedDate = DateUtil.getDateFromStamp("20240101")
        this.handleDateChange(this.selectedDate);
      }
    })
  }

  private handleDateChange(newDate: Date) {
    this.dateStr = this.formatDate(newDate);
    const diffDays = this.calculateDaysDifference(newDate);
    this.meowAgeStr = `第 ${diffDays} 天`;
    this.ageStr = this.getMeowAge(diffDays);
  }

  private formatDate(date: Date): string {
    const options: Intl.DateTimeFormatOptions = {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
    };
    return date.toLocaleDateString('zh-CN', options);
  }

  private calculateDaysDifference(date: Date): number {
    const currentDate = new Date();
    const differenceInTime = currentDate.getTime() - date.getTime();
    return Math.ceil(differenceInTime / (1000 * 3600 * 24));
  }

  private getMeowAge(day: number): string {
    const month = day / 30.0;
    const year = day / 365.0;

    if (month < 1) {
      const num = Math.floor(month * 12);
      return `${num}个月`;
    }

    if (month < 3) {
      const num = Math.floor(1 + (month - 1) * 2);
      return `${num}岁`;
    }

    if (month < 6) {
      const age = Math.floor(5 + (month - 3) * 1.33);
      return `${age}岁`;
    }

    if (month < 12) {
      const age = Math.floor(9 + (month - 6));
      return `${age}岁`;
    }

    if (month < 24) {
      const age = Math.floor(15 + (year - 1) * 9);
      return `${age}岁`;
    }

    const age = Math.floor(24 + (year - 2) * 4);
    return `${age}岁`;
  }
}