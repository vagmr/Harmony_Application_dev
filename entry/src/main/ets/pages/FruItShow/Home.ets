import router from '@ohos.router'
@Entry
@Component
struct Index {
  // onPageShow => router: 'pages/Home'
  onPageShow() {
    setTimeout(() => {
      router.pushUrl({url: "pages/FruItShow/MainPage"})
    }, 1000)
  }
  build() {
    Flex({
      direction: FlexDirection.Column,
      alignItems: ItemAlign.Center,
      justifyContent: FlexAlign.Center
    }) {
      Image($r('app.media.icon'))
        .width(100)
        .height(100)

      Text('如你所见，这是开屏广告')
        .fontSize(26)
        .fontColor("#ff0d703e")
        .margin({top: 300})
        .fontWeight(700)

      Text('健康的生活来自均衡的饮食')
        .fontSize(16)
        .fontColor(Color.White)
        .margin({top: 20})
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#bbb')
  }
}