import router from '@ohos.router';
import { webview } from '@kit.ArkWeb';
import browser from '@ohos.enterprise.browser';
import BrowserUtil from '../net/BrowserUtil';
import common from '@ohos.app.ability.common';

// import web from '@ohos.web';

@Entry
@Component
struct BrowserPage {
  @Prop title: string = ''; // 页面标题
  @Prop url: string = '';   // 网页链接

  aboutToAppear(): void {
    let params = router.getParams() as object
    this.title = params['title'] as string
    this.url = params['url'] as string
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('←')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .padding(16)
          .onClick(() => {
            router.back(); // 返回上一页面
          });

        Text(this.title)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .alignSelf(ItemAlign.Center);

        Image($r("app.media.ic_browser"))
          .width(56)
          .height(56)
          .padding(16)
          .onClick(()=>{
            let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
            BrowserUtil.startBrowsableAbility(context, this.url);
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')

      // 加载 WebView
      Web({
        controller: new webview.WebviewController(),
        src: this.url,
      })
        .javaScriptAccess(true)
        .domStorageAccess(true)
        .width('100%')
        .flexGrow(1);
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM])
    .onAppear(()=>{
      console.log("webview url: " + this.url)
    })
  }
}