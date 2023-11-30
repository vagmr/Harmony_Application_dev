@Styles function  todoItem () {
  .backgroundColor(Color.Pink)
  .borderRadius(20)
  .margin({top:15.,left:5})
  .width("96%")
  .padding(10)

}
@Component
export   struct  TodoItems{
  @State text:string = "愿那少年，此志无双。"
  @State Checked:boolean = false
  build(){
    Row(){
      Image(this.Checked ?
      $r("app.media.todolist_ok"):$r("app.media.todolist")).width(25).height(25)
        .margin(3)
      Text(this.text).fontSize(18).fontColor(Color.Black)
        .width("90%")
        .decoration({type:this.Checked?TextDecorationType.LineThrough:
        TextDecorationType.None})
    }.todoItem()
    .onClick(() => {
      this.Checked = !this.Checked;
    })
  }
}
