import router from '@ohos.router';
@Component
struct  comButton{
  @State buttonText:string = "back"
  // @State positionY:number | string = "650";
  // @State positionX:number | string= "90";

  build(){
    // .position({ x: this.positionX, y: this.positionY })
      Button(this.buttonText)
        .width(200)
        .fontSize(25)
        .fontWeight(350)
        .height(50)
        .onClick(() => {
          router.back()
        })
        .align(Alignment.Center)
  }
}
export  default  comButton;