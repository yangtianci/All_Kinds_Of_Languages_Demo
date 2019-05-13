//
//  Graphic.m
//  NormalDemo
//
//  Created by YangTianCi on 2017/11/20.
//  Copyright © 2017年 ytc. All rights reserved.
//

#import "Graphic.h"

#import <CoreGraphics/CoreGraphics.h>
 
// COreGraphic 类库结构整理

/**
 宏定义文件
 */
 #include <CoreGraphics/CGBase.h>
 #include <CoreGraphics/CGError.h>


 #include <CoreGraphics/CGAffineTransform.h>
#include <CoreGraphics/CGGeometry.h>// 定义了基本的集合数据结构体



 #include <CoreGraphics/CGContext.h>// 基本的 仿射, 绘制路径, 渲染, 剪裁, 文字, 锯齿.
 #include <CoreGraphics/CGBitmapContext.h>

 #include <CoreGraphics/CGPath.h>
 #include <CoreGraphics/CGPattern.h>
 #include <CoreGraphics/CGShading.h>

/**
 颜色系列
 */
 #include <CoreGraphics/CGColor.h>
 #include <CoreGraphics/CGColorSpace.h>// 用于界面颜色显示，通常颜色组成为RGBA（红，绿，蓝，透明度）四种，使用CGColorSpaceCreateDeviceRGB获取
 #include <CoreGraphics/CGColorConversionInfo.h>






 #include <CoreGraphics/CGFont.h>
 #include <CoreGraphics/CGFunction.h>

 #include <CoreGraphics/CGGradient.h>
 #include <CoreGraphics/CGImage.h>
 #include <CoreGraphics/CGLayer.h>

 #include <CoreGraphics/CGDataConsumer.h>
 #include <CoreGraphics/CGDataProvider.h>



 #include <CoreGraphics/CGPDFContext.h>

 #include <CoreGraphics/CGPDFDocument.h>// 核心数据类- 定义了 PDF 文档数据
 #include <CoreGraphics/CGPDFPage.h>// 核心数据类- 定义了 PDF 页
 #include <CoreGraphics/CGPDFArray.h>// 数据类- 数组形式的数据
 #include <CoreGraphics/CGPDFContentStream.h>// 数据类- 内容流形式的数据
 #include <CoreGraphics/CGPDFDictionary.h>// 被动数据类- 提供一个信息的结构体
 #include <CoreGraphics/CGPDFObject.h>// 被动数据类- 提供 PDF 对象类型信息等
 #include <CoreGraphics/CGPDFStream.h>// 被动数据类- 提供流形式的数据
 #include <CoreGraphics/CGPDFString.h>// 被动数据类- 提供字符串形式数据

 #include <CoreGraphics/CGPDFOperatorTable.h>
 #include <CoreGraphics/CGPDFScanner.h>




 
 



/**
 
 Quartz 2D是一个二维绘图引擎，同时支持iOS和Mac系统
 
 Quartz 2D能完成的工作
 
 绘制图形 : 线条\三角形\矩形\圆\弧等
 绘制文字
 绘制\生成图片(图像)
 读取\生成PDF
 截图\裁剪图片
 自定义UI控件

 Quartz2D提供了以下几种类型的Graphics Context：
 
 Bitmap Graphics Context 位图上下文，在这个上下文上绘制或者渲染的内容，可以获取成图片（需要主动创建一个位图上下文来使用，使用完毕，一定要销毁）
 PDF Graphics Context
 Window Graphics Context
 Layer Graphics Context 图层上下文，针对UI控件的上下文
 Printer Graphics Context
 
 */

/**
 
 根据 CG 框架的 API 形式, 以及正常的 OOP 函数类型可知, 一段正规函数的组成部分有: 参数, 函数名, 返回值
 如果是 CG 函数, 因为不是 OOP, 所以在每次操作数据的时候都需要将 context 传入
 
 */


/**
 
 总结规则:
 
 针对一批零散的 API, 如果需要总结, 实际上应该是以矢量分析法为主, 例如, 多个 PDF 相关文件, 并且内部有很多不能明确使用方式的 API , 此种情况下, 实际上应该先明确这些对象的本质目的是什么, 每个库文件甚至每个接口在达到目的的过程中起到了什么样的作用
 
 另: 其实在针对其他的任何陌生框架的分析时, 都应该使用矢量分析法, 因为无论哪个陌生的库中出现了哪个陌生的类, 或者看起来不能明确使用目的的接口, 实际上, 先得到整体的最终目的, 然后, 就能明确这些陌生的类和接口的使用.
 
 最重要规则: 因为只是在逻辑层按照类的功能 对函数进行了分类, 因此会出现以下几个使用特点
 
 1.不存在属性, 因此, 关于数据的使用只能使用变量, 并且会存在大量的重定义数据结构, 以及结构体
 2.函数调用方式, 因为不是严格意义的面向对象, 因此在调用函数的时候, 按照 C 语言的规则直接进行调用即可, 不需要创建对象等等, 但是, 因为函数的使用基础就是参数变量, 因此, 会存在很多结构体式的数据对象, 但是不是严格意义上的对象, 而是本质上的数据集合
 3.内存管理, 因为函数的调用方式以及数据的组织并非以对象为单位, 因此, 在使用的时候没有固定的规则对变量进行管理, 所以需要在使用的时候, 手动的创建内存控件保存数据以及释放数据
 
 源码内部部分规则解释:
 
 1.常量字符串 - (数据字典): 随着常量字符串出现的一定有一个字典类型的参数, 并且, 该字典的产生一般不由程序员定义, 而是由系统定义并提供, 因此, 常量字符串出现的含义其实就等同于提供一个一个 Get 函数
 2.函数调用方式: CG框架的函数除了拥有 C语言 函数的特性, 就是对结果的赋值会放在参数位中, 根据指针位置将结果输出, 并且还有 闭包 的使用, 使用方式一样是提供 闭包指针, 接收回调
 
 3.除了类与对象之外的数据组织结构, 例如 结构体, 另外定义的数据结构( typedef ), 其实大部分的本质都是基本结构, 最重要的是, 这些结构只有几种: 数字, 字符串 .
 
 4.实际上对于 CG 系列的库文件来讲, 每个文件中不存在 类与对象的关系, 因为没有类声明与函数声明之类的文字, 但是依照库文件的分类, 实际上还是从逻辑上将整个库区分为多个对象进行了划分, 也就是说, 对所有的接口进行了逻辑层面的类划分, 但是并没有从编译器角度进行划分, 因此, 此种类文件中不会存在属性值, 并且, 使用方式也是直接调用接口即可, 并且, 因为不存在类的概念, 因此, 内存需要自己管理
 
 
 */

/**
 
 CTM(上下文仿射矩阵) : Context Transform Matrix
 
 CGPath 框架核心类库解析:
 
 * UIKit 中的 UIBezierPath 实际上就是 CGPath 的面向对象结构, 只不过使用方式是面向对象的方式而已, 其他的基本相同
 * 对于 Path 而言, 问题实际上在于如何理解 API 到实际图形的映射, 如何理解参数决定 Gemotry .
 
 函数组成以及 API 形式实际上和 context 中的 path 部分相同, 只不过是为了能将 path 概念和 context 概念解绑, 而专门独立出来的类目吧

 主要的使用场景似乎是配合 UIKit 库的 UIBezierPath 对象进行使用
 
 
 CoreGraphic 框架核心类库解析:
 
 核心元素:
 
 上下文的 - 仿射 - 线样式 
 
 路径 - 画图形: 直线, 曲线, 矩形, 弧形, 椭圆 - 图形样式: fill, stroke
 
 图案 - 填充
 
 文字 - 样式
 
 其他: 透明图层, 坐标转换, PDF
 
 CGContext:
 因为本身目的就是创建一片可以操作的内存空间, 并且, 操作的主要内容就是进行绘图, 因此, 出于基础绘图的实现, 基本元素为 - 画布, 基本图形(统一为路径对象), 图片(pattern), 文字(Chacrater), PDF, 点在 UserSpace 以及 DeviceSpace 之间的切换
 {主要元素:
 
 ### Context(画布): 基本功能
 1.仿射变换函数相关 - 旋转平移缩放, 组合 CTM
 2.设置 line 相关属性 - 线宽, 线帽, 连接, 虚线, 平滑, 透明 ...
 3.设置 LinearGradient / RadialGradient 属性
 4.设置裁剪属性
 
 ## 绘制 Path 函数相关
 # 其中一个关键点为: 绘制 LinePath 的时候一定会有一个起点, 其实绘制的思想就类似于手工画线, 一定会有一个开始才能与其他点进行连线, 因此, moveToPoint 函数就是手动设置起点的函数, 如果没有调用此函数, 则不绘制, 并且, 需要最后渲染进 context
 
 # 绘制流程中必须执行的函数
 
 * 获取上下文: 一般在 view 的 drewRect 函数中才能获取
 * 开始路径 + 结束路径: 如果是绘制线条, 一定要设置初始点
 
 ### Path(路径): 基本功能
 1.绘制 point 以及在两点之间绘制 直线, 曲线等
 2.绘制 rect, ellipse, arc,
 3.设置 path 的填充渲染
 
 ### Pattern(图案): 基本功能
 * 类似与 h5 中设置背景图片, 可以设置铺设模式
 
 ### Shad(阴影): 基本功能
 * 设置阴影
 
 ### Text(文字): 基本功能
 * 设置文字的各种属性: 字符间距, 文字位置, 字符矩阵, 字体等
 * 设置 字体平滑, 抗锯齿 等
 
 ### Transparency layer(透明图层): 功能不明
 
 ### User space to device space tranformations(用户空间与设备空间之间的转换):
 * 提供了坐标系之间的转换关系
 
 ### PDF(便携式文档格式)
 * 可以根据 PDFPage 对象, 绘制界面

 }

 */

/**
 Base: 根据平台, 位数, 等环境变量, 对基本数据类型等作出 基本的宏定义
 */
#include <CoreGraphics/CGBase.h>

/**
 主要提供了 Context 类目, 以及对应的操作函数
 类的主要作用就是提供了一片可供绘制的上下文, 即提供了基本图形绘制, 也有文字绘制, 图片绘制, PDF 绘制等, 并且每种都有相应的设置 API 和 操作 API
 {主要元素
 Context: 关于 context 的操作, 主要问题是区别于的面向对象的 API , 使用的是面向过程的设计思想, 因此, 关于 context 的操作, 基本上都是, 打开-操作-关闭, 流程, 类似于 socket 万物皆文件 思想方式
 基本图形图绘制: 主要观察接口组织形式
 基本文字绘制:
 
 }
 */
#include <CoreGraphics/CGContext.h>

/**
 主要提供了 CGPath 类目, 以及其操作函数
 主要内容实际上和 context 中的 path 部分函数基本相同, 可以理解为, 单独除了一个 path 对象, 使 path 和 context 能独立使用
 */
#include <CoreGraphics/CGPath.h>

/**
 
 CGAffineTransform:
 
 1.定义了基本的 CGAffineTransform 对象:
 {结构体:
 CGFloat a, b, c, d;
 CGFloat tx, ty;
 }
 
 2.提供了充足且合理的 CGAffineTransform 对象的运算函数
 {函数包含:
 1.baseMethod: 旋转, 平移, 缩放-函数
 2.反转, 合并, 比对
 3.其他类型的对象 与 仿射对象的运算, point, size, rect-Apply类method, 并且这三个函数都是内联函数, 源码可见
 }
 */
#include <CoreGraphics/CGAffineTransform.h>

/**
 主要定义了 Pattern 类目, 只有几个函数
 类目的主要功能是提供了绘制图案的对象
 */
#include <CoreGraphics/CGPattern.h>

/**
 主要定义了 Shading 类目, 只有几个函数
 类目的主要功能是提供了绘制轴底纹, 或者放射状底纹的函数
 */
#include <CoreGraphics/CGShading.h>

/**
 
 CGBitmapContext
 
 1.展示了位图上下文的基本参数元素
 {基本参数元素包括:
 Data: 非空时指向一片至少 bytesPerRow * height字节的内存空间, 如果参数为空, 上下文将自己分配空间, 内存随着上下文释放
 Width:位图的宽度像素数量
 Height:位图的高度像素数量
 BitsPerComponet: 每个 Component 由多少个 Bit 组成
 BytesPerRow: 其实就是位图每行的字节数, 至少是宽度 pixel 换算后的字节数, 且, 至少为 每个像素字节数 的整数倍的整数数字
 Space: 指定位图每个 Pixel 由 多少个 Compnent 组成, 也可以指定目的颜色
 BitmapInfo: 指定位图是否包含 透明通道, 以及 透明通道如何生成, 为浮点数还是整形
 
 ReleaseInfo: 上下文释放时调用, 作为释放回调, 参数为 Data
 
 位图中的单位区分: Pixel 由 Component 组成, Component 由 byte 组成(颜色深度?)
 
 每个像素的字节数bytes == (NumberOfComponents's bits + 7) / 8
 }
 
 2.提供了基本函数
 {基本函数类型:
 创建函数: 通过提供各种数据创建位图, 通过既定图片创建位图
 获取函数: 通过函数获取指定的位图的数据值
 }
 */
#include <CoreGraphics/CGBitmapContext.h>

/**
 主要提供了 ColorSpace 的相关选项以及 创建/获取 函数
 关于色域, 主要是 sRGB 以及 CMYK 灰度 饱和度lab 之类的区分
 */
#include <CoreGraphics/CGColorSpace.h>

/**
 主要提供了 CGColorRef 类目, 以及对应的操作函数&获取函数
 {主要参数设置
 ColorSpace
 Gray
 Component
 ...
 }
 */
#include <CoreGraphics/CGColor.h>

/**
 主要提供了 CGColorConversionInfo 类目, 以及对应的操作函数
 类的主要作用提供了 CGColor 的 ColorSpace 转换
 */
#include <CoreGraphics/CGColorConversionInfo.h>

/**
 主要提供了 CGDataConsumer 类目, 以及简单的几个操作函数 (创建, 回调)
 翻译过来似乎是叫做 数据消费者 ??
 好像是作为从数据, url 等位置获取数据, 然后提供给其他类目使用的中间类目
 */
#include <CoreGraphics/CGDataConsumer.h>

/**
 主要提供了 CGDataProvider 类目, 以及简单的几个操作参数 (创建, 回调)
 翻译过来似乎是叫做 数据提供者 ???
 应该是和上面的 CGDataConsumer 相对应, 一个是数据消费者, 一个是数据提供者
 但是具体的使用方式已经使用目的还是不太清楚
 */
#include <CoreGraphics/CGDataProvider.h>

/**
 定义了 CoreGraphic 框架的错误代码
 */
#include <CoreGraphics/CGError.h>

/**
 主要提供了 CGFont 类目, 以及简单的几个操作函数, 主要是创建函数
 {字体相关参数值:
 PlatformFont
 FontName
 Glyph
 }
 */
#include <CoreGraphics/CGFont.h>

/**
 主要提供了 CGFunction 类目, 以及简单的操作函数
 {类目主要功能:
 CGFunction是一个通用浮点函数求值器，它使用一个
 用户指定的回调，将任意数量的输入映射到一个
 任意数量的输出
 }
 */
#include <CoreGraphics/CGFunction.h>

/**
 主要提供了几何结构体, 基本的 Point Size Point Victor 都在此文件中定义, 并且, 提供了大量的关于几何机构体的操作函数( 创建函数  )
 {
 基本几何数值结构体: Point Size Rect Victor
 数值极限值: Zero Infinit 等
 基本的获取函数: 获取中值, 最大值, 最小值等等
 基本的比较函数: 类似 p 是否在 rect 中, 两个 rect 是否相交之类
 
 最有意思的是, 这些基本的结构体的创建方式是使用 内联函数, 并且函数的内部实现可见
 
 }
 */
#include <CoreGraphics/CGGeometry.h>

/**
 主要提供了 Gradient 类目, 其实就是渐变色对象
 只提供了两个基本的设置函数, 按照颜色数组生成渐变色对象以及按照色域, 组件生成渐变色对象
 */
#include <CoreGraphics/CGGradient.h>

/**
 主要提供了 CGImage 类目, 就是简单的 Image 对象
 提供的函数主要为两大类 1.根据参数变量创建 CGImage 对象 2.根据 CGImage 对象获取参数
 {主要参数
 宽高, 组件, 组件位数, 组件比特数
 ImageMask, CGDataProvider
 ColorSpace 
 }
 */
#include <CoreGraphics/CGImage.h>

/**
 主要提供了 CALayer 类目, 以及简单的几个函数
 除了参数获取函数之外, 剩余的函数都是简单的根据 Context 创建layer, 以及将 layer 加入 context 中的简单函数
 */
#include <CoreGraphics/CGLayer.h>

/**
 主要提供了 CGPDFArray 类目, 但是没有具体的初始化函数, 所有的函数都是围绕着从 PDFArray 对象中获取各种类型的数据制定的
 例如: 从 PDFArray 中获取 流, 字符串, 数组, 整形等等对象并赋值给 value 对象
 */
#include <CoreGraphics/CGPDFArray.h>

/**
 主要提供了 CGPDFContentStream 类目, 其实就是在 PDF, PDFPage, PEDStream 各个对象中间起到了衔接作用
 主要函数包括: 从 PDFPage 中获取 stream, 从 stream 中创建 stream 以及反向函数等
 */
#include <CoreGraphics/CGPDFContentStream.h>

/**
 定义了 CGPDFContext 类目, 此类目应该为主类目, 内部主要包含了少量的 Context 操作函数, 初始化函数, 以及 众多的常量字符串
 {函数概况:
 初始化函数: 可以通过 consumer & 辅助信息创建, 也可以通过 url 创建 context 对象
 其他函数: 针对 context 对象操作, 例如打开, 关闭上下文等等
 }
 */
#include <CoreGraphics/CGPDFContext.h>

/**
 除了定义了 CGPDFDictionary 类目之外, 主要提供的函数没有操作函数, 只有从 Dictionary 中获取数据的获取函数
 执行获取函数的时候需要将 Dictionary 以及 key 以及 value 的指针传入, 同时, 在获取值之前需要知道对应的值为何种类型, 才能进一步判断使用某个函数
 */
#include <CoreGraphics/CGPDFDictionary.h>

/**
 主要定义了 CGPDFDocument 类目, 主要提供的函数有创建函数以及一部分的操作函数
 函数中, 可操作部分很少, 多数都为获取类函数, 并且含有数据字典
 */
#include <CoreGraphics/CGPDFDocument.h>

/**
 主要定义了 CGPDFObject 类目, 似乎并没有明显的创建方式, 应该属于是系统本身的保留数据结构, 主要提供的函数就是获取 Object 的各种 value 等, 并且, 还对各种类型进行了重新定义.
 */
#include <CoreGraphics/CGPDFObject.h>

/**
 主要定义了 CGPDFOpearatorTable 类目, 只提供了几个简单的函数( 初始话, 内存管理, 回调设置函数 )
 该类目的主要作用不明确
 */
#include <CoreGraphics/CGPDFOperatorTable.h>

/**
 主要定义了 CGPDFPage 类目, 以及多个操作函数
 类目本身的作用主要是展示 PDFPage , 因此除了初始化函数, 还包括了部分的操作函数
 */
#include <CoreGraphics/CGPDFPage.h>

/**
 主要定义了 CGPDFScanner 类目, 以及多个 scanner 函数
 类目本身的作用主要是根据 PDFContentStream 对象, 通过调取函数获取 Stream 对象中的数据并且赋值
 这个类的编写思想, 类似于面向对象, 将需要分析的数据赋值给类目, 之后, 调用类目函数进行操作
 */
#include <CoreGraphics/CGPDFScanner.h>

/**
 主要定义了 CGPDFStream 类目, 只有个别函数
 类目的主要功能就是根据 Stream 获取 Dictionary 或者 Data
 */
#include <CoreGraphics/CGPDFStream.h>

/**
 主要定义了 CGPDFString 类目, 只有几个函数
 类目的主要功能就是提供了 PDFString 与 String, Data 的转换函数, 以及长度字节获取函数
 */
#include <CoreGraphics/CGPDFString.h>



@implementation Graphic





NS_INLINE void TestFunc(){
    
    /**
     
     #include <CoreGraphics/CGBase.h>
     
     #include <CoreGraphics/CGAffineTransform.h>
     #include <CoreGraphics/CGBitmapContext.h>
     #include <CoreGraphics/CGColor.h>
     #include <CoreGraphics/CGColorConversionInfo.h>
     #include <CoreGraphics/CGColorSpace.h>
     #include <CoreGraphics/CGContext.h>
     #include <CoreGraphics/CGDataConsumer.h>
     #include <CoreGraphics/CGDataProvider.h>
     #include <CoreGraphics/CGError.h>
     #include <CoreGraphics/CGFont.h>
     #include <CoreGraphics/CGFunction.h>
     #include <CoreGraphics/CGGeometry.h>
     #include <CoreGraphics/CGGradient.h>
     #include <CoreGraphics/CGImage.h>
     #include <CoreGraphics/CGLayer.h>
     #include <CoreGraphics/CGPDFArray.h>
     #include <CoreGraphics/CGPDFContentStream.h>
     #include <CoreGraphics/CGPDFContext.h>
     #include <CoreGraphics/CGPDFDictionary.h>
     #include <CoreGraphics/CGPDFDocument.h>
     #include <CoreGraphics/CGPDFObject.h>
     #include <CoreGraphics/CGPDFOperatorTable.h>
     #include <CoreGraphics/CGPDFPage.h>
     #include <CoreGraphics/CGPDFScanner.h>
     #include <CoreGraphics/CGPDFStream.h>
     #include <CoreGraphics/CGPDFString.h>
     #include <CoreGraphics/CGPath.h>
     #include <CoreGraphics/CGPattern.h>
     #include <CoreGraphics/CGShading.h>
     
     */
    
    
    
    
}


-(void)drawRect:(CGRect)rect{
    
    TestFunc();
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextRelease(context);
    
}







@end
