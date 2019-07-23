

#import <objc/runtime.h>
#import <Foundation/Foundation.h>

@interface NSObject(Associative)

- (void)setAssignProperty:(id)obj byKey:(const void *)aKey;
- (void)setRetainNonatomicProperty:(id)obj byKey:(const void *)aKey;
- (void)setRetainAtomicProperty:(id)obj byKey:(const void *)aKey;
- (void)setCopyNonatomicProperty:(id)obj byKey:(const void *)aKey;
- (void)setCopyAtomicProperty:(id)obj byKey:(const void *)aKey;

- (id)getAssociativeValue:(const void *)aKey;

@end
