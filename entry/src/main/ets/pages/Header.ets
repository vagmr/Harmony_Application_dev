@Component
struct  comHeader{
  private message:string = "默认标题"
  build(){
    Row(){
      Image($r("app.media.Back")).width(30)
      Text(this.message)
        .fontSize(40)
        .fontWeight(300)
        .height(60).fontColor(Color.White)
      Blank()
      Image($r("app.media.Refresh")).width(30)
    }
    .width("100%").backgroundColor(Color.Brown)
  }
}
export default  comHeader