import { CalendarDay } from '../model/CalendarDay';
import { CalendarViewModel } from '../viewmodel/CalendarViewModel';
import { PostCardView } from './PostCardView';
import PrivacyPolicyDialogBackUp from './PrivacyPolicyDialogBackUp';
import { process } from '@kit.ArkTS';
import preferences from '@ohos.data.preferences';


// 隐私政策的 URL
const privacyPolicyURL = "https://zzz.pet/?page_id=135";

// 弹窗组件
function showPrivacyPolicy() {
  AlertDialog.show({
    title: "🐱 初次相见，你好喵",
    message: "我们是 猫与猫寻（杭州）智能科技有限公司，「猫咪日历」是我们开发的App。该App不会收集您的信息，请放心使用喵～\n\nhttps://zzz.pet/?page_id=135",
    autoCancel: false, //点击遮障层时，是否关闭弹窗。默认值：true
    alignment: DialogAlignment.Center, //弹窗在竖直方向上的对齐方式。默认值：DialogAlignment.Default
    primaryButton: {
      value: "退出App",
      fontColor: '#181818',
      action: () => {
      }
    },
    secondaryButton: {
      value: "同意",
      action: () => {
      }
    },
    cornerRadius: 12, //弹窗边框弧度
    width: '80%', //弹窗宽度
  })
}


@Preview
@Entry
@Component
struct CalendarView {
  @State viewModel: CalendarViewModel = new CalendarViewModel();
  private scroller: ListScroller = new ListScroller()
  privacyPolicyDialog: CustomDialogController = new CustomDialogController({
    builder: PrivacyPolicyDialogBackUp({
      cancel: this.onCancel.bind(this),
      confirm: this.onAgree.bind(this)
    }),
    alignment: DialogAlignment.Default, // 可设置dialog的对齐方式，设定显示在底部或中间等，默认为底部显示
    cornerRadius: 16,
    autoCancel: false
  })

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
        // .expandSafeArea([SafeAreaType.CUTOUT])
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
      }
    }
    .onAppear(() => {
      const context: Context = getContext(this) as Context;
      preferences.getPreferences(context, "season")
        .then(prefs => {
          // 读取保存的数据
          const hasAgree = prefs.getSync('hasAgree', false); // 默认值是 false
          console.log("获取Preferences成功, 用户是否同意协议 " + hasAgree);
          if (hasAgree == false) {
            this.privacyPolicyDialog.open()
          }
        })

      if (this.viewModel.calendarDays.length < 30) {
        this.viewModel.fetchCalendarDays()
          .then(() => {
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
                setTimeout(() => {
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

  onCancel() {
    console.log("User cancelled the privacy policy dialog.");
    process.exit(0)
  }

  onAgree() {
    console.log("User agreed to the privacy policy.");
    console.log("用户点击了同意，保存记录");
    const context: Context = getContext(this) as Context;
    preferences.getPreferences(context, "season")
      .then(prefs => {
        console.log("获取Preferences成功");
        // 存储数据到Preferences
        // 使用put方法保存key-value对
        prefs.put('hasAgree', true);
        prefs.flush()
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