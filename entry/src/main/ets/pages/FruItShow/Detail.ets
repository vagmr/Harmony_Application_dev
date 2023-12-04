import router from '@ohos.router'
import comButton from '../../components/Button'
import type{ FoodInfo } from '../../type/FruitShowType/FruitType'
let params = router.getParams()
@Entry
@Component
struct Detail {

  @State message: FoodInfo = {} as FoodInfo

  aboutToAppear() {
    this.message = params as FoodInfo
  }
  build() {
      Column() {
        // Button({type:ButtonType.Normal}){
        //   Text("点击显示参数").fontSize(28)
        // }.height(60).margin({top:5,bottom:10})
        // .onClick(() => {
        //   console.log(JSON.stringify(this.message))
        // })
        Text("详情页").align(Alignment.Center)
        .fontSize(35).height(35)
        .margin({top:10,bottom:10})
      Column({space:5}){
        Image(this.message.img).height("50%").width("90%")
          .border({width:1,radius:10}).backgroundColor(Color.White)
          .shadow({radius:5,color:Color.Brown,offsetX:0,offsetY:10})
        Text(this.message.name).align(Alignment.Center)
          .fontSize(36)
        Column(){
         LineContent("#ffaaaa","热量",this.message.rl,'千卡')
        LineContent('#aaffaa', '营养元素', this.message.rl, '克')
          LineContent('#aaaaff', '脂肪', this.message.zf, '克')
        }.height("40%").width("80%").align(Alignment.Center)
        .backgroundColor(Color.White)
        .clip(new Rect({width:"100%",height:"100%",radius:8}))
        .padding({top:50,bottom:20,left:10,right:10})
      }.width("100%")
        .height("85%")
        comButton({buttonText:"返回食物详情"})
      }
      .width('100%')
    .height('100%')
    .backgroundColor("#bbb")
  }
}
@Builder function  LineContent(color: ResourceColor, name: string, count: number, unit: string) {
  Row() {
    Circle({width: 10, height: 10})
      .margin({right: 12})
      .fill(color)
    Text(name).fontSize(22).fontColor(0x3E3E3E)
    Blank()
    Text(count + ' ' + unit).fontSize(22).fontColor(0x3E3E3E)
  }
  .width('100%')
  .margin(10)
  .padding({left: 10, right: 10})
}