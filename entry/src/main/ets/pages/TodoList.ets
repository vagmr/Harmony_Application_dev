
import comButton from '../components/Button'
import { TodoItems } from '../components/TodoBox'
import router from '@ohos.router';


let text = router.getParams()["text"];
@Entry
@Component
struct TodoList {
  @State message: string = '诗文学习'
private  todoList = [
"",
"除非我不想赢，否则没人能让我输。",
"活在当下，珍惜眼前，不要为过去或未来而忧虑",
"总有一天，你会离开这个世界，就活出你的人生，这回忆值得你铭记",
  "枯萎的向日葵是抬不起头看太阳的",
  "行百里者半九十",
  "除非我不想赢，否则没人能让我输。",
  "活在当下，珍惜眼前，不要为过去或未来而忧虑",
  "总有一天，你会离开这个世界，就活出你的人生，这回忆值得你铭记",
  "枯萎的向日葵是抬不起头看太阳的",
  "行百里者半九十",
  text
]

  build() {
    Column() {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
      .height(50)
        List(){
          ForEach(this.todoList,el=>{
          ListItem() {
            if(el) {
              TodoItems({ text: el })
            }else {
              TodoItems()
            }
          }
            })
        }.layoutWeight(1)
        comButton()

    } .width('100%')
    .height('100%').alignItems(HorizontalAlign.Center)
  }
}