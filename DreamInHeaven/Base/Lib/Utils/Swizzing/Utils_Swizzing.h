
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#define objc_runOldMethod(curClass,oldMethod,theSelf,theSEL,...)                                                    \
            (oldMethod || (oldMethod=(void*)class_getMethodImplementation(class_getSuperclass(curClass),theSEL)))                \
            ? oldMethod(theSelf, theSEL, ##__VA_ARGS__)                 \
            : oldMethod(theSelf, theSEL,##__VA_ARGS__);                 \
            if (oldMethod == (void*)class_getMethodImplementation(class_getSuperclass(curClass),theSEL)) {oldMethod = nil;};

// 更改函数基础函数
// 返回旧函数指针
void* objc_changeMethod(Class clazz,
                        SEL sel,
                        void *newFunction);

void* objc_changeMethod_Plus(Class clazz,
                             SEL sel,
                             void *newFunction,
                             BOOL *addOrReplace);


void* objc_changeClassMethod(Class clazz,
                             SEL sel,
                             void*newFunction);

void* objc_changeClassMethod_Plus(Class clazz,
                                  SEL sel,
                                  void*newFunction,
                                  BOOL *addOrReplace);
