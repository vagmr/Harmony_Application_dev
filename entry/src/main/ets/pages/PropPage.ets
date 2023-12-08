
import comButton from '../components/Button'
// 任务类
// @Observed
class Task{
  static id: number = 0

  // 任务名称
  name: string
  constructor(taskName:string) {
    this.name =  `任务${Task.id++}：` + taskName
  }
  // 任务状态：是否完成
  finished: boolean = false
}
let  TaskInstance = new Task("测试")

// 统一的卡片样式
@Styles function card(){
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4})
}

// 任务完成样式
@Extend(Text) function finishedTask(){
  .decoration({type:TextDecorationType.LineThrough})
  .fontColor('#B1B2B1')
}

// 任务统计信息
class StatInfo {
  totalTask: number = 0
  finishTask: number = 0
}

@Entry
@Component
struct PropPage {
  // 统计信息
  @Provide stat: StatInfo = new StatInfo()
  // 传入的任务名称
  @State name:string = "任务"
  build() {
    Column({space: 10}){
      // 1.任务进度卡片
      TaskStatistics()
      TextInput({placeholder:"输入任务信息:"})
        .width("90%").height(50)
        .placeholderFont({size:20})
        .placeholderColor(Color.Brown)
        .border({width:2,radius:5})
        .fontSize(22)
        .onChange(val => {
          switch (val) {
            case "1":
              this.name = "暴打陌猪猪"
              break;
            case "2":
              this.name = "把陌猪打扁!"
              break;
            default:
              this.name = val
              break;
          }
        })
      // 2.任务列表
      TaskList({taskName:$name})
        .layoutWeight(1)
      .margin({bottom:30})
      Row(){
        comButton()
      }.height(60)

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')
  }
}


@Component
struct TaskStatistics {
  @Consume stat: StatInfo

  build() {
    Row(){
      Text('任务进度：')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
      Stack(){
        Progress({
          value: this.stat.finishTask,
          total: this.stat.totalTask,
          type: ProgressType.Ring
        })
          .width(100)
        Row(){
          Text(this.stat.finishTask.toString())
            .fontSize(24)
            .fontColor('#36D')
          Text(' / ' + this.stat.totalTask.toString())
            .fontSize(24)
        }
      }
    }
    .card()
    .margin({top: 20, bottom: 10})
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}

@Component
struct TaskList {
  // 总任务数量
  @Consume stat: StatInfo
  // 任务数组
  @State tasks: Task[] = []
  // 任务名称
  @Link taskName:string

  handleTaskChange(){
    // 1.更新任务总数量
    this.stat.totalTask = this.tasks.length
    // 2.更新已完成任务数量
    this.stat.finishTask = this.tasks.filter(item => item.finished).length
  }

  build() {
    Column(){
      // 2.新增任务按钮
      Button('新增任务')
        .width(200)
        .margin({bottom: 10})
        .onClick(() => {
          // 1.新增任务数据
          this.tasks.push(new Task(this.taskName))
          // 2.更新任务总数量
          this.handleTaskChange()
        })

      // 3.任务列表
      List({space: 10}){
        ForEach(
          this.tasks,
          (item: Task, index) => {
            ListItem(){
              TaskItem({item: item, onTaskChange: this.handleTaskChange.bind(this)})
            }
            //  添加右滑模块
            .swipeAction({end: this.DeleteButton(index)})
          }
        )
      }
      .width('100%')
      .alignListItem(ListItemAlign.Center)
    }
  }

  @Builder DeleteButton(index: number){
    Button(){
      Image($r('app.media.ic_public_delete_filled'))
        .fillColor(Color.White)
        .width(20)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin(5)
    .onClick(() => {
      this.tasks.splice(index, 1)
      this.handleTaskChange()
    })
  }
}

@Component
struct TaskItem {
 @State item: Task = TaskInstance
  onTaskChange: () => void

  build() {
    Row(){
      if(this.item.finished){
        Text(this.item.name)
          .finishedTask()
      }else{
        Text(this.item.name)
      }
      Checkbox()
        .select(this.item.finished)
        .onChange(val => {
          // 1.更新当前任务状态
          this.item.finished = val
          // 2.更新已完成任务数量
          this.onTaskChange()
        })
    }
    .card()
    .justifyContent(FlexAlign.SpaceBetween)
  }
}