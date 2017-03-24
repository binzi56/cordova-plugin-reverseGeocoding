/********* reverseGeocoding.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <CoreLocation/CoreLocation.h>

@interface reverseGeocoding : CDVPlugin {

}

@property(nonatomic, strong) CLGeocoder *geocoder;

- (void)reverseGeocodingMethod:(CDVInvokedUrlCommand*)command;

@end

@implementation reverseGeocoding

#pragma mark-懒加载
-(CLGeocoder *)geocoder
{
    if (_geocoder==nil) {
        _geocoder=[[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (void)reverseGeocodingMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = nil;
    NSArray *tempArr = command.arguments;
    NSNumber *latNum = tempArr[0];
    NSNumber *lngNum = tempArr[1];

    if ((latNum.doubleValue == 0 || latNum == nil)|| (lngNum.doubleValue == 0 || lngNum == nil)) {
      // 当前经纬度不正确
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"暂无定位信息, 请检查后重试!"];
     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }else{
      CLLocationDegrees latitude= latNum.doubleValue;
      CLLocationDegrees longitude= lngNum.doubleValue;

      CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];

      // 逆地理编码
      [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CDVPluginResult *pluginResult = nil;
        if (error||placemarks.count==0) {
            // 地址没找到
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"你输入的地址没找到，可能在月球上"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }else{
            // 返回地址信息
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary: firstPlacemark.addressDictionary];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

        }


      }];
    }
}

@end
