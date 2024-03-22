import axios from '@ohos/axios';

const instance = axios.create({
  baseURL: 'https://baobab.kaiyanapp.com',
  timeout: 5000,
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
