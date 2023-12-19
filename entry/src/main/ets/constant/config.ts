import { RequestMethod } from '../../request/comRequest'
export  enum comContentType {
  json = "application/json",
  form = "application/x-www-form-urlencoded",
  formData = "multipart/form-data"
}
type Header = {
  ContentType : comContentType
}
type RequestOptions = {
  url: string;
  method?: RequestMethod;
  data?: any;
  header?:Header
};
export  default  RequestOptions