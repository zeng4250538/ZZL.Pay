//
//  Pay.h
//  PayUnitKit
//
//  Created by ZZLClick on 16/4/25.
//  Copyright © 2016年 Click. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>

@interface Pay : NSObject
-(void)alipayOrderId:(NSString *) orderId withProducatName:(NSString *)producatName withProducatDescription:(NSString *)producatDescription withPrice:(float)price;
@end
