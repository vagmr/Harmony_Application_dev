@Entry
@Component
struct FlexPage {
  build() {
    Column() {
      Flex({
        // 设置主轴方向
        direction:FlexDirection.Row
        //设置主轴的对齐方式
        ,justifyContent:FlexAlign.SpaceEvenly
        // 设置交叉轴的对齐方式
        ,alignItems:ItemAlign.Center,
        // 容许换行
        wrap:FlexWrap.Wrap,
        // 设置多行的对齐方式
        alignContent:FlexAlign.Center
      }) {
       ForEach([1,2,3,4],() => {
         Text("这是一行的文本示例").fontSize(24).fontColor("#f1356d")
           .width("40%").border({width:2,color:Color.Blue})
           .margin({bottom:10}).textAlign(TextAlign.Center)
           .padding(5)
       })
      }
      .width('80%')
      .height(300)
      .border({ width: 3, color: Color.Black })
      .margin({top:10}).padding(5)
    }.width('100%').height('100%')
    }
}