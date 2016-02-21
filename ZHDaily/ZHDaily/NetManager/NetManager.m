//
//  NetManager.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/17.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "NetManager.h"
#import <AFNetworking.h>
#import "ServerIP.h"

@implementation NetManager

//
+ (void)getJSONDataWithURLString:(NSString *)URLString
                         success:(responseSuccessBlock)success
                         failure:(respoonFailureBlock)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URLString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        success(responseObject);
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"error: %@", error);
    }];
}

//获取launchScreen的图片的方法
+ (void)getLaunchImageWithsize:(NSString *)size
                       success:(responseSuccessBlock)success
        {
    NSString *image = [@"start-image/" stringByAppendingString:size];
    NSString *imageURLStr = [kIP_Prefix stringByAppendingString:image];
    [self getJSONDataWithURLString:imageURLStr success:^(id JSON) {
        success(JSON);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//获取最新日报的方法
+ (void)getLatestNewsWithsuccess:(responseSuccessBlock)success {
    NSString *latestNewsURL = [kIP_Prefix stringByAppendingString:@"news/latest"];
    [self getJSONDataWithURLString:latestNewsURL success:^(id JSON) {
        success(JSON);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}








@end
