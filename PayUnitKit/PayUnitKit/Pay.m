//
//  Pay.m
//  PayUnitKit
//
//  Created by ZZLClick on 16/4/25.
//  Copyright © 2016年 Click. All rights reserved.
//

#import "Pay.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "APAuthV2Info.h"
@implementation Pay

-(void)alipayOrderId:(NSString *) orderId withProducatName:(NSString *)producatName withProducatDescription:(NSString *)producatDescription withPrice:(float)price{

    NSString *partner = @"2088221016697815";
    NSString *seller = @"paytreasuredeveloper@richstonedt.com";
    NSString *privateKey = @"MIICXwIBAAKBgQC67zHqzNhXVLDdChWSD2g/jqZFltgkRRSvpE6MiUkkUJQU231g1YQzvXrvkpqLO4Iz9siew5CTCsI916Aoapzs5/XKK0khBguqB7ueR4VvC5u+pSGx6oXFiIxW5o+nAzC23/BCVot9zo3oR+hCqmqznVq37O/i1CZQYq8iRqns+wIDAQABAoGBAIy3vsXXyguDj1f1XWOEAZ/GjFfaQ36aGgZWE2MrfUm+9pn02B7q3Afu3Po3S+r/svXXEhKheNWXxbyz8rY5+0H5phXPL4yzT51YPFEhKFmWnoTzzqv5p1kKQphdSN6FrMblYnRsPCLxn01tEvMQoKxwYzZhI04AaVz+wX6d5XMxAkEA4SYenOZFK3OeKJQwMfLceikB6t0c7C1yUAmdwytozUJuD6gzejD5pUkQhFsc78lECR4gFEtBKwOvQ4ftlB6PZwJBANSMkThSoLl/ABKJ1vrXRcjwqJo+G2vRdM6Hq52z/YqBtvemRc9YxD+CGaHx1hlYARjh/LXl/NsReivqdHRA/U0CQQC3aWJO1pdKimkxDWcliX5qVbWmKnJBQ9R3tx25vEcnzxHx10f4JqV4LEk0STUNcZvnAY+IeLWh4OKJ1NWJcEvJAkEAhYTcAOafAofOMtcWDjNHKkhLkcEsFpnYZ5kAbKvRvL1pg76Wof8gIMkIcxvpI7iNz+S+jEGyiqc6+PVqPFFLDQJBAMnKCXqySYT2nXEzjvV6CjZMBuH1xxb+IOz0bT76COP0JakJ3NV9p5+VpPqK1q9/WccWtYuQkSk9RBQhhNPtCGE=";
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        NSLog(@"缺少partner或者seller或者私钥。");
        return;
    }
    
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = orderId; //订单ID（由商家?自?行制定）
    order.productName = producatName; //商品标题
    order.productDescription = producatDescription; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",price]; //商品价格
    order.notifyURL = @"http://www.test.com"; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"shakeCoupon";
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];

        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            //【callback处理支付结果】
           NSLog(@"reslut = %@",resultDic);
           }];

    }


}

@end
