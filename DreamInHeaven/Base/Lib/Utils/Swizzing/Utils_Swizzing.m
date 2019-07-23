
#import "Utils_Swizzing.h"
#import <objc/runtime.h>
#import <objc/message.h>

void* objc_changeMethod_Plus(Class clazz,
                              SEL sel,
                              void *newFunction,
                              BOOL *addOrReplace)
{
    Method oldMethod = class_getInstanceMethod(clazz, sel);

    void* oldFuction = (void*)method_getImplementation(oldMethod);
    BOOL succeed = class_addMethod(clazz,
                                   sel,
                                   (IMP)newFunction,
                                   method_getTypeEncoding(oldMethod));
    if (oldMethod && succeed)
    {
        oldFuction = nil;
    }

    if (addOrReplace)
    {
        *addOrReplace = succeed;
    }
    if (!succeed)
    {
        oldFuction = method_setImplementation(oldMethod, (IMP)newFunction);
    }
    return oldFuction;
}

void* objc_changeMethod(Class clazz,
                        SEL sel,
                        void *newFunction)
{
    return objc_changeMethod_Plus(clazz,
                                   sel,
                                   newFunction, nil);
}



void* objc_changeClassMethod_Plus(Class clazz,
                                   SEL sel,
                                   void*newFunction,
                                   BOOL *addOrReplace)
{
    Method oldMethod = class_getClassMethod(clazz, sel);
    void* oldFuction = (void*)method_getImplementation(oldMethod);
    clazz = object_getClass((id)clazz);

    BOOL succeed = class_addMethod(clazz,
                                   sel,
                                   (IMP)newFunction,
                                   method_getTypeEncoding(oldMethod));
    if (addOrReplace)
    {
        *addOrReplace = succeed;
    }
    if (!succeed)
    {
        method_setImplementation(oldMethod, (IMP)newFunction);
    }
    return oldFuction;
}

void* objc_changeClassMethod(Class clazz,
                             SEL sel,
                             void*newFunction)
{
    return objc_changeClassMethod_Plus(clazz,sel, newFunction, nil);
}
