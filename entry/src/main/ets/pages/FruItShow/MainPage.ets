// bar的构建器
@Builder function  bar
(index: number, name: string,img?:Resource | string,
options:{width:string} = {width:"70%"}){
  Column(){
    if(img) {
      Image(img)
        .width(30).height(30).fillColor("#ff3ef4c2")
    }
    Text(name)
      .fontColor(this.currentIndex === index ? "#f1356d" : Color.Black)
      .fontSize(16)
      .fontWeight(this.currentIndex === index ? 500 : 400)
      .margin({ top: 5,bottom:1 })
    Divider()
      .strokeWidth(4)
      .color('#007DFF')
      .opacity(this.currentIndex === index ? 1 : 0)
      .margin({bottom:4})
  }.width( options.width)
}
// bar的内容组件
@Component
struct  barContent{
  // 记录现在的索引值
  @State currentIndex :  number = 0
  build(){
    Tabs({barPosition:BarPosition.Start}){
      TabContent(){

      }.tabBar(bar(0,"全部"))
      TabContent(){

      }.tabBar(bar(1,"其它"))
      TabContent(){

      }.tabBar(bar(2,"测试"))
    }
    .vertical(false)
    .barMode(BarMode.Fixed)
    .barWidth("100%")
    .barHeight(50)
    .animationDuration(200)
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }
}

@Entry
@Component
struct MainPage {
  // 记录现在的索引值
  @State currentIndex :  number = 0

  build() {
    // tab栏
      Tabs({barPosition:BarPosition.End}){
        // 点击tab栏时显示的内容
        TabContent(){
          barContent()
        }.tabBar(bar(0,"首页",$r("app.media.homesvg")))
        TabContent(){
          Row(){
            Text("还在开发中.......").fontSize(35)
          }.width("80%").height("20%")
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Bottom)
        }.tabBar(bar(1,"记录","https://vagmr-event.oss-cn-beijing.aliyuncs.com/bb377ee6-a14f-4227-84e9-5cd2df2b40d3.svg"))
      }
      //非垂直显示
      .vertical(false)
      .barMode(BarMode.Fixed)
      .barWidth("100%")
      .barHeight(65)
      .animationDuration(200)
      .onChange((index: number) => {
        this.currentIndex = index
      })
  }
}
