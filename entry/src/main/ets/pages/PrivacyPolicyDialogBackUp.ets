import common from "@ohos.app.ability.common"
import { Want } from "@kit.AbilityKit"
import { BusinessError } from "@ohos.base"

@CustomDialog
export default struct PrivacyPolicyDialogBackUp {
  controller!: CustomDialogController
  cancel!: () => void
  confirm!: () => void

  build() {
    Column() {
      Text("🐱 初次相见，你好喵").fontSize(24).fontWeight(FontWeight.Bold).margin({ top: 30, left: 25, bottom: 16,right: 25 })
        .align(Alignment.Start)

      Scroll() {
        Text() {
          Span("我们是 猫与猫寻（杭州）智能科技有限公司，「猫咪日历」是我们开发的App。本App不会收集您的信息，请放心使用喵～\n\n请您阅读")
          Span("《猫咪日历-隐私政策》").fontColor(Color.Orange).onClick(() => {
            let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
            this.startBrowsableAbility(context, "https://zzz.pet/?page_id=135");
          })
        }.fontSize(16).margin({
          left: 25,
          right: 25
        })
      }.height(120)

      Row() {
        Button("不同意").onClick(() => {
          if (this.controller) {
            this.controller.close();
          }
          this.cancel();
        }).fontColor(Color.Gray)
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(Color.Transparent)
        Button("同意")
          .onClick(() => {
            if (this.controller) {
              this.controller.close();
            }
            this.confirm();
          })
          .fontColor(Color.White)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .linearGradient({
            direction: GradientDirection.Right, colors: [[Color.Pink, 0.0], [Color.Pink, 1.0]]
          })
          .width('32%')
          .borderRadius(24)
      }
      .margin({
        top: 16, bottom: 24
      })
      .padding({
        left: 25,
        right: 25
      })
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }
  }

  startBrowsableAbility(context: common.UIAbilityContext, myurl: string): void {
    let want: Want = {
      action: 'ohos.want.action.viewData',
      entities: ['entity.system.browsable'],
      uri: myurl
    };
    context.startAbility(want).then(() => {
      console.log('success')
    }).catch((err: BusinessError) => {
      console.error(`Failed to startAbility. Code: ${err.code}, message: ${err.message}`);
    });
  }
}
