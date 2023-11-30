import router from '@ohos.router';
@Component
struct  comButton{
  @State buttonText:string = "back"
  @State positionY:number = 680;
  @State positionX:number = 85;

  build(){
    Button(this.buttonText).position({x:this.positionX,y:this.positionY})
      .width(200).fontSize(25).fontWeight(350)
      .height(50).onClick(() => {router.back()})
  }
}
export  default  comButton;