//
//  ImageConvertor.h
//  eZIPSDK
//
//  Created by Sifli on 2021/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageConvertor : NSObject


/// png格式文件转为ezipBin类型。转换失败返回nil。
/// @param pngData png文件数据
/// @param eColor 颜色字符串
/// @param eType eizp类型
/// @param binType bin类型
+(nullable NSData *)EBinFromPNGData:(NSData *)pngData eColor:(NSString *)eColor eType:(uint8_t)eType binType:(uint8_t)binType;

@end

NS_ASSUME_NONNULL_END
