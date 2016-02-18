//
//  NetManager.h
//  ZHDaily
//
//  Created by 王豪 on 16/2/17.
//  Copyright © 2016年 hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^responseSuccessBlock)(id JSON);

@interface NetManager : NSObject



+ (void)getLaunchImageWithsize:(NSString *)size
                       success:(responseSuccessBlock)success;
@end
