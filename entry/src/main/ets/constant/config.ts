import { RequestMethod } from '../../request/comRequest'
type RequestOptions = {
  url: string;
  method?: RequestMethod;
  data?: any;
};
export  default  RequestOptions