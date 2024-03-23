import axios from '@ohos/axios';
import { AXIOS_TIME_OUT, BASE_URL } from '../../constants/url';

const instance = axios.create({
  baseURL: BASE_URL,
  timeout: AXIOS_TIME_OUT,
  headers: {
    'Content-Type': 'application-json'
  }
});

instance.interceptors.response.use(
  (response) => {
    const { status, data } = response;
    if(status === 200) {
      return data;
    }
    return Promise.reject(response);
  },
  (err) => {
    return Promise.reject(err);
  }
);

export default instance;
