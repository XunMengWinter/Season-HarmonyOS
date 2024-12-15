@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Scroll() {
      Column() {
        ForEach([1, 2, 3, 4], (item: Int8Array) => {
          Image('https://6963-icemono-1giecaaj02676f6a-1304448608.tcb.qcloud.la/images/calendar2025/1733116607875gtJk.jpg')// 网络图片 URL
            .width('100%')
            .objectFit(ImageFit.Cover)// 设置图片填充方式
            .margin({ top: 10 });
          Text(this.message)
            .id(item + "")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
        })
      }
    }
    .height('100%')
    .width('100%')
  }
}