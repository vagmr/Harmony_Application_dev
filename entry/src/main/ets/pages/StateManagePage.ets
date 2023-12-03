import comButton from '../components/Button'
@Extend(Text)  function  textCenter(){
  .textAlign(TextAlign.Center).width("100%")
}

interface comTextType {
  size:number | string
  color:Color | string
}
@Extend(Text) function  text_s_c
( config: comTextType = {size:"20rem",color:Color.Black}){
  .fontSize(config.size)
  .fontColor(config.color)
}
@Extend(Text) function textSty(){
  .text_s_c({color:"#ffeac5c5",size:24})
  .width("90%").margin({left:20})
}
@Extend(Button) function  btnSty(click:Function){
  .fontColor(Color.White).backgroundColor(Color.Green)
  .onClick(() =>{ click()})
}
@Extend(Column) function  state_columnSty
(color:Color | string,h:number = 240){
  .height(h).backgroundColor(color).width("90%")
.padding(10).margin({top:10})
  .borderRadius(10)
}

@Entry
@Component
struct StateManagePage {
  @State msg:string = "这是父组件的默认消息";
  build() {
      Column() {
        Text("状态管理页面").fontSize(28)
          .margin({top:10}).fontColor("#ff169982")
          .height(30)
        Column({ space:8}){
          Text("父组件区域").fontSize(24)
            .fontColor(Color.White).textCenter();
          Text("Vagmr好帅啊,风流倜傥，玉树临风，人见人爱。+")
            .textSty()
          Text(this.msg).text_s_c({size:20,color:Color.White}).textCenter()
          Button("点击修改文本").margin({left:90,top:10})
            .btnSty(() => {
              this.msg = "消息有变"
            })
        }.height(240).backgroundColor("#666").width("90%")
        .alignItems(HorizontalAlign.Start).padding(10).margin({top:10,bottom:5})
        .borderRadius(10)
        Divider().margin({bottom:5})
        List(){
          ListItem(){
            Column(){
              State_Prop({content:this.msg})
              State_Link({content:$msg})
              State_Watch()
              State_game()
            }.width("100%")
          }
        }
        .layoutWeight(1)
        comButton().margin({top:30,bottom:10})
      }
      .width('100%')
      .height('100%')
  }
}
@Builder function State_sonBuilder(){
  Column({space:10}) {
    Text("子组件")
      .text_s_c().textCenter()
      .margin({ top: 10 })
    Text(this.content).text_s_c({color:Color.Brown,size:28})
    Button("消息的单向传递")
      .btnSty(() => {
      this.content = "子组件改变消息"
      })
  }.state_columnSty("#999",150).alignItems(HorizontalAlign.Center)
}

// 利用prop传递数据
@Component
struct  State_Prop{
  @Prop content:string //Prop属性不容许赋初值
  build(){
    State_sonBuilder()
  }
}
@Component
struct  State_Link{
  @Link content:string //Prop属性不容许赋初值
  build(){
    State_sonBuilder()
  }
}

@Component
struct State_game {
  @State  number:number  = 1
  build() {
    Column({space:8}){
        Text("逢七过小游戏").text_s_c({color:Color.White,size:25})
      if(this.number % 7 == 0 || this.number.toString().indexOf('7') != -1 ){
        Text(`过`)
          .text_s_c({color:Color.White,size:24})
      }else {
        Text(`数字是： ${this.number}`)
          .text_s_c({ color: Color.White, size: 20 })
      }
        Button("点击数字加一").btnSty(() => {
          this.number ++
      })
    }.state_columnSty(Color.Gray,140)
  }
}

@Component
struct  State_Watch {
  @State @Watch("change") count:number = 1
  @State pow:number = 0
  @State powNumber:number = 1
  change(){
    this.pow++
    this.powNumber = Math.pow(this.count,this.pow)
  }
  build() {
    Column(){
      Text(`原数据：${this.count}`)
        .text_s_c({color:Color.Brown,size:26})
        .onClick(() => {
        this.count++
        })
      Text(`次数：${this.pow}`)
        .text_s_c({color:Color.Brown,size:26})
      Text(`平方：${this.powNumber}`)
        .text_s_c({color:Color.Brown,size:26})
    }
    .state_columnSty(Color.Gray,130)
  }
}