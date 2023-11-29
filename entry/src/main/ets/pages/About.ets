import router from '@ohos.router';
@Entry
@Component
struct About {
  @State message: string = '关于我'

  build() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Brown).margin({left:110})
        Column({space:8}){
          Text("我是Vagmr,刚刚学习鸿蒙开发的新人" +
          ",在未来,我想构建更多精彩的应用，开发是如此快乐，"
          + "我期待未来遇见更多新的技术。")
            .fontColor("#fff4eee9").fontSize(28).margin({top:20})
            .fontWeight(300)
          Column(){
            Text("💻 喜欢开发").fontSize(30).fontWeight(300)
              .fontColor(Color.Black)
            Text("🚎️ 喜欢远行").fontSize(30).fontWeight(300)
              .fontColor(Color.Black)
            Text("🌴️ 喜欢看沿途的风景").fontSize(30).fontWeight(300)
              .fontColor(Color.Black)
            Text("🌾️ 喜欢吹吹晚风，看看日落").fontSize(30).fontWeight(300)
              .fontColor(Color.Black)
            Text("🌇 无论远行多远，看到多么美丽的风景，都不能忘记那份初心")
              .fontColor(Color.Black)
              .fontSize(30).fontWeight(300)
          }.width("100%").height(300).margin({top:10})
          .alignItems(HorizontalAlign.Start)
          .radialGradient({
            center: [170, 150],
            radius: 350,
            colors: [["rgba(238, 174, 202, 0.6)", 0.0], ["rgba(148, 233, 223, 0.6)", 1.0]]
          })
        }
        .height(500).width("100%").justifyContent(FlexAlign.Start)
        Row(){
          Text("版本：0.1")
            .fontColor("#ffb30a4b").fontSize(30)
          Text("作者：vagmr")
            .fontColor("#ff31f0cc").fontSize(30)
        }
        .justifyContent(FlexAlign.SpaceBetween).width("90%")
        .margin({top:50,left:20}).padding({left:5,right:5})
        .border({width:3,radius:8,color:Color.White})
        Button("Back").position({x:80,y:690})
          .width(200).fontSize(25).fontWeight(350)
          .height(50).onClick(() => {router.back()})
      }
      .width('100%')
    .height('100%').alignItems(HorizontalAlign.Start)
      .backgroundImage($r("app.media.bg"),ImageRepeat.NoRepeat)
    .backgroundImageSize(ImageSize.Cover)
      .backgroundImagePosition({x:-2200,y:0})
  }
}