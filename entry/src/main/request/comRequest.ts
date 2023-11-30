// 引入包名
import http from '@ohos.net.http';
enum RequestMethod {
  GET = "GET",
  POST = "POST",
  PUT = "PUT",
  DELETE = "DELETE"
}
// 响应对象的接口
//添加类型，支持泛型
interface Data<T> {
  code: string
  msg: string
  result: T
}

/**
* 创建一个HTTP请求实例，并使用指定的方法和数据向指定的URL发送HTTP请求。
*
* @param {string} url - 将要发送请求的URL。
* @param {RequestMethod} [method=RequestMethod.GET] - HTTP请求方法。
* @param {any} data - 需要发送的数据。
* @return {Promise<Data<T>>} 如果请求成功，则返回一个解析后的响应数据的Promise,可加泛型
* 如果请求失败，则返回一个带有错误信息的Promise。
*/
export const requestInstance =
  <T>({ url, method = RequestMethod.GET, data }: { url: string, method?: RequestMethod, data?: any })
    : Promise<Data<T>> => {
    //返回一个promise对象
    return new Promise<Data<T>>((resolve, reject) => {
      // 每一个httpRequest对应一个HTTP请求任务，不可复用
      let httpRequest = http.createHttp();
      // 用于订阅HTTP响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
      // 从API 8开始，使用on('headersReceive', Callback)替代on('headerReceive', AsyncCallback)。 8+
      httpRequest.on('headersReceive', (header) => {
        console.info('header: ' + JSON.stringify(header));
      });
      httpRequest.request(
        // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
        url,
        {
          method: method, // 可选，默认为http.RequestMethod.GET
          // 开发者根据自身业务需要添加header字段
          header: {
            'Content-Type': 'application/json'
          },
          // 当使用POST请求时此字段用于传递内容
          extraData: {
            "data": JSON.stringify(data),
          },
          // expectDataType: http.HttpDataType.STRING, // 可选，指定返回数据的类型
          usingCache: true, // 可选，默认为true
          priority: 1, // 可选，默认为1
          connectTimeout: 80000, // 可选，默认为60000ms
          readTimeout: 60000, // 可选，默认为60000ms
          // usingProtocol: http.HttpProtocol.HTTP1_1, // 可选，协议类型默认值由系统自动指定
        }, (err, data) => {
          if (!err) {
            // data.result为HTTP响应内容，可根据业务需要进行解析
            console.info('Result:' + JSON.stringify(data.result));
            console.info('code:' + JSON.stringify(data.responseCode));
            // data.header为HTTP响应头，可根据业务需要进行解析
            console.info('header:' + JSON.stringify(data.header));
            console.info('cookies:' + JSON.stringify(data)); // 8+
            resolve(data.result as Data<T>);
            // 取消订阅HTTP响应头事件
            httpRequest.off('headersReceive');
            // 当该请求使用完毕时，调用destroy方法主动销毁
            httpRequest.destroy();
          } else {
            console.info('error:' + JSON.stringify(err));
            reject(err);
            // 取消订阅HTTP响应头事件
            httpRequest.off('headersReceive');
            // 当该请求使用完毕时，调用destroy方法主动销毁。
            httpRequest.destroy();
          }
        }
      );
    });
  }