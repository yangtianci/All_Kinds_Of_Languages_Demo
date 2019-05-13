//
//  JavaScriptCore.m
//  NormalDemo
//
//  Created by YangTianCi on 2017/12/7.
//  Copyright © 2017年 ytc. All rights reserved.
//

#import "JavaScriptCore.h"

@interface JavaScriptCore ()<NSURLProtocolClient>

@end 

@implementation JavaScriptCore

/**
 
 - 因为在实际应用中不可能去写 JS 代码, 还是写的 OC 代码, 所以 JSC 库的所有 API 本质还是通过 OC 代码实现 JS 函数的调用或者是通过 JS 调用 OC 代码
 
 - 特性
     * JS 中的对象引用都是强引用
     *
 
 - 矢量节点: JS 整个的执行元素以及执行流程. JS -> OC. OC -> JS.
 
 - 矢量节点剖析:
     * 组成元素: VirtualMachine -> Context -> Value + ManagedValue
 
     * VirtualMachine: JS 实际运行的虚拟机, 有独立的堆控件和垃圾回收机制, 可以同时控制多个 Context 对象, 并且多个 context 使用同一堆内存和垃圾回收机制, 因此, 同一个 VM 下 context 可以互相传值不会引起内存泄漏, 但是如果是多个 VM 的情况下, 就会垃圾回收机制的错乱, 导致内存泄漏.
     * JSContext: JS 的主要执行环境, 环境中应用的 JSValue 内存通过 JSVM 进行管理, 并且每个 JSValue 都和 Context 相关联并且强引用于 JSContext.
     * JSValue: 本质就是数据对象, 只不过是 Hybrid 对象, 也就是作用与 JS 以及 OC 的数据对象之间的转换对象, 但是一般在使用的时候会经过转换, 因为 JSValue 本身会引用一个 JSContext 并且本身也会被 JSVM 所强引用.
     * JSManagedValue: 辅助管理内存空间的对象,由于JS内存管理是垃圾回收，并且JS中的对象都是强引用，而OC是引用计数。如果双方相互引用，势必会造成循环引用，而导致内存泄露。我们可以用JSManagedValue保存JSValue来避免.
     * JSExport (Protocol): 一个协议，如果JS对象想直接调用OC对象里面的方法和属性，那么这个OC对象只要实现这个JSExport协议就可以了.
 
 - 整体的运行框架: JS 的运行原理是 -> 创建一个虚拟机( VirtualMatchin ) 虚拟机创建一个执行 JS 的内存空间上下文 ( JSContext ) 上下文中加载进需要执行的 JS 代码,
 
 - [参考文章以及 JS 与 OC 通信的详细内容](http://www.jianshu.com/p/a329cd4a67ee)
 
 */


NS_INLINE void testMethod(){

//#import "JSContext.h"
//#import "JSValue.h"
//#import "JSManagedValue.h"
//#import "JSVirtualMachine.h"
//#import "JSExport.h"
    
}



@end
