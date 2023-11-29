import router from '@ohos.router';
@Entry
@Component
struct ImagePcs {
  @State message: Resource = $r("app.string.ImagePcs")
  @State imgHeight:number = 350
  @State warningInfo:string = ""
  build() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .margin({left:"30%"})
        Text(this.warningInfo).fontSize(30).fontColor(Color.Red)
          .margin({top:2,bottom:2})
      Column(){
        Image("https://iili.io/J9BjFkb.jpg").height(this.imgHeight)
      }.height(350).margin({bottom:5}).justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center).width("100%")
        Row(){
          Blank(25)
         Text("图片高度为：").fontSize(24).fontFamily("宋体")
          TextInput({placeholder:"输入图片高度"}).fontSize(20).width(180)
            .backgroundColor("#eee").fontColor(Color.Brown).height(40)
            .type(InputType.Number)
            .onChange(val => {
              let heightVal = Number(val)
              if(heightVal <= 350 && heightVal >= 100){
                this.imgHeight = heightVal
              }else if(heightVal > 350){
                this.warningInfo = "图片高度不能超过350"
                setTimeout(() => {
                  this.warningInfo = ""
                },1500)
              }else if (heightVal < 100) {
                this.warningInfo = "图片高度不能小于100"
                setTimeout(() => {
                  this.warningInfo = ""
                },1500)
              }
            })
        }.height(60).alignItems(VerticalAlign.Center)
        Divider().color("#333").margin({bottom:15,left:20}).width("90%")
        .strokeWidth(4)
        Row(){
            Button("缩小").width(120).fontSize(25)
              .fontWeight(350).margin({left:3}).type(ButtonType.Normal)
              .borderRadius(15).height(45).fontColor(Color.Orange)
              .backgroundColor("#ffc61440")
              .onClick(() => {
                if(this.imgHeight > 100){ this.imgHeight -= 10}
              })
          Button("放大").width(120).fontSize(25)
            .fontWeight(350).margin({left:3}).type(ButtonType.Normal)
            .borderRadius(15).height(45).fontColor(Color.Orange)
            .backgroundColor("#ffc61440")
            .onClick(() => {
              if(this.imgHeight < 350){ this.imgHeight += 10}
            })
        }.height(70).border({width:1,radius:4,color:Color.Gray})
        .width("90%").justifyContent(FlexAlign.SpaceBetween)
        .margin({left:20})
        Slider({min:100,max:350,value:this.imgHeight,step:10
        ,style:SliderStyle.OutSet,direction:Axis.Horizontal})
          .width("90%").margin({left:20,top:20}).showTips(true)
          .backgroundColor("#999").padding({top:5,bottom:5})
          .border({width:2,color:"#ff9d4708",radius:5})
          .trackThickness(5)
          .onChange(val => {
            this.imgHeight = val
          })
        Button("Back").position({x:80,y:680})
          .width(200).fontSize(25).fontWeight(350)
          .height(50).onClick(() => {router.back()})
      }
      .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
}