#import <Foundation/Foundation.h>

@interface Test : NSObject
@property NSString* s;
@end

@implementation Test
NSString* test() {
    Test* x = nil;
    return x->_s;
}
@end
