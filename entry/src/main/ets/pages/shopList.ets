import  comButton from  "../pages/Button"
import comHeader from './Header'
// 构建函数
@Builder function  itemCard(el){
  Row() {
    Image(el.img).height("100%")
      .margin({ left: 5 })
    Column() {
      if (el.discount) {
        Text(el.title).fontColor(Color.Black)
          .fontSize(24)
        Text(`价格：￥${el.price}`).shopText()
          .decoration({ type: TextDecorationType.LineThrough })
        Text(`折后价：￥${el.price - el.discount} `)
        Text(`折扣：${el.discount}`).fontSize(18).fontColor("#333")
      }
      else {
        Text(el.title).fontColor(Color.Black)
          .fontSize(24)
        Text(`价格：￥${el.price}`).shopText()
      }
    }.justifyContent(FlexAlign.SpaceEvenly).height("100%")
    .margin({ left: 10 }).alignItems(HorizontalAlign.Start)
  }
  .height("18%")
  .width("100%")
  .backgroundColor("#eee")
  .padding(5)
  .borderRadius(5)
}
// 全局样式
@Styles function  fullScreen(){
  .width('100%')
  .height('100%')
}

//继承模式
@Extend(Text) function shopText(){
  .fontSize(20)
  .fontColor(Color.Red).fontWeight(300)
}

// 入口组件
@Entry
@Component
struct ShopList {
  @State message: string = '商品详情'
  private  shopList = [
    {title:"华为Mate60",img:$r("app.media.hwsj"),price:6000,discount:500},
    {title:"华为Mate60",img:$r("app.media.hwsj"),price:6000},
    {title:"华为Mate60",img:$r("app.media.hwsj"),price:6000},
    {title:"华为Mate60",img:$r("app.media.hwsj"),price:6000},
    {title:"华为Mate60",img:$r("app.media.hwsj"),price:6000},
    {title:"华为Mate60",img:$r("app.media.hwsj"),price:6000}
  ]
  build() {
      Column({space:8}) {
        comHeader({message:"商品列表"})
        List({space:10}){
          ForEach(this.shopList,el => {
            ListItem() {
             itemCard(el)
            }
          })
        }.layoutWeight(1).width("90%")
Row(){
  Divider()
  comButton({ buttonText: "back", positionY: 6 })
}.height(70)
      }.fullScreen();
  }

}