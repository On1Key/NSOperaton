//
//  NSString+scan.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/7/12.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "NSString+scan.h"

@implementation NSString (scan)
-(NSAttributedString *)replaceOriginalContainNumStringFromAttribute:(NSDictionary *)fromAtt toAttribute:(NSDictionary *)toAtt
{
    
    NSString *originalString = self;
    
    if (!originalString || ![originalString isKindOfClass:[NSString class]] || originalString.length <= 0) {
        return nil;
    }
    
    // Intermediate
    NSMutableAttributedString *numberString = [[NSMutableAttributedString alloc] initWithString:originalString attributes:fromAtt];
    NSString *tempStr;
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    
    while (![scanner isAtEnd]) {
        // Throw away characters before the first number.
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        // Collect numbers.
        [scanner scanCharactersFromSet:numbers intoString:&tempStr];
        
        NSAttributedString *att = [[NSAttributedString alloc] initWithString:tempStr attributes:toAtt];
        //        [numberString appendAttributedString:att];
        
        if (!([tempStr isEqualToString:@""] || !tempStr)) {
            NSRange attRange = [originalString rangeOfString:tempStr];
            [numberString replaceCharactersInRange:attRange withAttributedString:att];
        }
        
        tempStr = @"";
    }
    // Result.
    //    int number = [numberString intValue];
    
    return numberString;
}
@end
