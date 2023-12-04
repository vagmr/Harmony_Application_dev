// 第一个tab栏的内容
@Builder function  indexContent(){
  Column() {
    Text(this.title).fontSize(50)
      .margin({bottom:5})
    Column(){
      Text("劝君莫忘少年志，曾许人间第一流")
        .fontSize(30)
        .backgroundColor(Color.Black)
        .width(this.txtWidth).height(this.txtHeight).align(Alignment.Top)
        .textAlign(TextAlign.Center)
        .fontColor(Color.White)
      Button("点击按钮")
        .type(ButtonType.Normal)
        .margin({top:10}).padding(20)
        .onClick(() => {
          animateTo({
            duration:1500,
            onFinish: () =>{
              if (this.isPlay) {
                this.title = "动画播放结束"
              }else {
                this.title = "重新播放"
              }
            }
          },() =>{
            if (this.isPlay){
              this.txtWidth = "0%"
              this.txtHeight = 0
            }
            else {
              this.txtWidth = "60%"
              if (this.txtWidth == "60%") {
                this.txtHeight = 120
              }
            }
            this.isPlay = !this.isPlay
          })
        })
    }.height(400).width("80%")
    .border({width:3,radius:5})
    .margin({top:"10%"}).justifyContent(FlexAlign.Center)
    Row(){
      Image("https://vagmr-event.oss-cn-beijing.aliyuncs.com/24a071ab-fd58-4d9d-b393-05d2b5992bdd.jpg")
        .width(150).height(150)
        .clip(new  Circle({width:"100%",height:"100%"}))
        .rotate({
          x:1,
          y:1,
          z:1,
          angle:this.angle
        })
        .onClick(() => {
          animateTo({
            duration:2000,
            playMode:PlayMode.Alternate,
            curve:Curve.EaseOut
          },()=>{
            if(this.isRotate){
              this.angle = 0
            }else {
              this.angle = 360
            }
            this.isRotate = !this.isRotate
          })
        })
    }.height(200).width(200)
    .margin({top:10})
    .justifyContent(FlexAlign.Center)
    .border({width:2,radius:"50"})
  }
  .width('100%')
  .height('100%')
  .justifyContent(FlexAlign.Start)
  .alignItems(HorizontalAlign.Center)
}
// bar的构建器
@Builder function bar
(index: number, name: string, img?: Resource | string,
) {
  Column() {
    if (img) {
      Image(img)
        .width(30).height(30).fillColor("#cc096b88")
    }
    Text(name)
      .fontColor(this.currentIndex === index ? "#f1356d" : Color.Black)
      .fontSize(this.currentIndex === index ? 20 : 16)
      .fontWeight(this.currentIndex === index ? 500 : 400)
      .margin({ top: 5, bottom: 1 })
    Divider()
      .strokeWidth(4)
      .color('#007DFF')
      .opacity(this.currentIndex === index ? 1 : 0)
      .margin({ bottom: 4 })
  }.width("70%")
}

@Extend(Text) function  txtSty(color:string | Color = Color.Red){
  .width("80%")
  .border({width:2,radius:5})
  .height(50)
  .fontSize(28)
  .textAlign(TextAlign.Center)
  .margin({top:10})
  .fontColor(color)
  .padding(10)
  .fontWeight(600)
}

 // 第二个tab栏的内容
@Component
struct  subContent{
  @State isShow:boolean = false
  build(){
    Column(){
      Button(this.isShow ? "隐藏" : "显示")
        .margin({top:10}).width(100).height(35)
      .onClick(() => {
        animateTo({
          duration:900,
          curve:Curve.EaseOut,
          playMode:PlayMode.Alternate
        },() => {
          this.isShow = !this.isShow
        })
      })
      if(this.isShow){
        Column(){
          Image($r("app.media.JBWMAdX")).width("80%")
            .margin({top:10})
          Text("陌猪是大笨蛋!!!")
            .txtSty()
        }
        .transition(
          {type:TransitionType.All,translate:{x:300,y:-200}
          ,rotate:{y:1,angle:90}})
      }
    }.width("100%").height("100%")
    .backgroundColor("#ccc")
  }
}

@Entry
@Component
struct AnimationTry {
  @State txtWidth :  string  = "0%"
  @State txtHeight :  number  = 0
  @State title: string =  "动画展示页面"
  @State isPlay: boolean = false
  // 角度
  @State angle: number = 0
  // 是否旋转
  @State isRotate: boolean = false
  @State currentIndex : number   = 0
  build() {
    Tabs({barPosition:BarPosition.End}){
      TabContent(){
        indexContent()
      }.tabBar(bar(0,"首屏",$r("app.media.homesvg")))
      TabContent(){
        subContent()
      }.tabBar(bar(1,"副屏",$r("app.media.pc")))
    }//非垂直显示
    .vertical(false)
    .barMode(BarMode.Fixed)
    .barWidth("100%")
    .barHeight(65)
    .animationDuration(500)
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }
}