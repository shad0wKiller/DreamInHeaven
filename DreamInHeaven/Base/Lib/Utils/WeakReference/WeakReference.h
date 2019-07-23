//
//  WeakReference.h
//  MFWSdk
//
// @reference http://stackoverflow.com/questions/14209070/collections-of-zeroing-weak-references-under-arc


#import <Foundation/Foundation.h>

@interface WeakReference : NSObject
{
    __weak id nonretainedObjectValue;
    __unsafe_unretained id originalObjectValue;
}

+ (WeakReference *) weakReferenceWithObject:(id) object;

- (id) nonretainedObjectValue;
- (void *) originalObjectValue;
@end
