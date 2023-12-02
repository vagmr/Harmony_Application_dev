//导入webView
import web_webview from '@ohos.web.webview'
import comButton from '../components/Button'

@Entry
@Component
struct ShowWeb {

  controller: web_webview.WebviewController = new web_webview.WebviewController()
  build() {
      Column() {
        List(){
          ListItem(){
            Column() {
              Web({ src: 'https://reblog.vagmrgpt.top/about', controller: this.controller })
                .height(760)

              comButton()
            }
          }
        } .layoutWeight(1).width("100%")
      }
    .height('100%').justifyContent(FlexAlign.Start)
  }
}