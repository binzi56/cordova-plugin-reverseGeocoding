# cordova-plugin-reverseGeocoding
一个OC版的cordova逆地理编码插件

### 该插件直`deviceready`事件发生后才可用;
```
   document.addEventListener("deviceready", onDeviceReady, false);
    function onDeviceReady() {
    console.log("deviceready");
    }
```

### 安装
```
cordova plugin add /Users/apple/Desktop/cordova-plugin-reverseGeocoding
```

### 支持的平台
`iOS`

### 使用示例
```
document.addEventListener("deviceready", onDeviceReady, false);
  function onDeviceReady() {
  function success(msg){
  alert("定位成功:" + msg);
};

  function error(msg){
  alert("定位失败:" + msg);
  };

  cordova.plugins.reverseGeocoding.address([24.840882, 102.843752], success, error);
}
```


