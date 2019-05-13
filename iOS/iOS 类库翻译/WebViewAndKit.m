//
//  WebViewAndKit.m
//  NormalDemo
//
//  Created by YangTianCi on 2017/12/4.
//  Copyright © 2017年 ytc. All rights reserved.
//

#import "WebViewAndKit.h"

#import <WebKit/WebKit.h>

@implementation WebViewAndKit
//
//NS_INLINE void testMethod (){
//
//#pragma mark ======================= iOS - Web 加载相关
//
//    /**
//
//     关于一个完整的浏览器意义上的 webView 需要什么功能以及接口的概述
//
//     * 元素: url. htmlStr. data. cookie.
//
//     */
//
//
//    /**
//
//     关于 iOS 的 JS 交互解析
//
//     每个 App 如果使用 webView 加载了网页, 就会根据 App 的 bundle 生成对应的 storage ,并且实际上, 操作 cookie 以及 storage 的对象是以 app 为单位的单例对象, 甚至是全局的单例对象, 不过在操作实际的缓存的时候回自动根据当前 app 进行选择.
//
//     */
//
//#pragma mark ======================= WebView 整理
//
//    /**
//
//     WebView 整理
//
//     * 概述:
//         原生的 webview 的整个框架提供的 API 特别少, 除了主要的 数据源, 加载回调 等必须函数之外, 就只提供了四个最基本的功能, 以及十个以内的网页属性设置.
//
//     * WebView 提供的整体的所有功能:
//
//     1.加载流程 ( 数据源, 监听函数 - 几个监听阶段 ) - 监听阶段
//         * 数据源: 1.Request 2.HTMLString 3.HTML.Data
//         * 准备 - 加载
//         * 开始加载
//         * 加载成功
//         * 加载失败
//
//     2.附加行为
//         * 基本功能: 1.刷新 2.停止加载 3.前进.后退 4.加载 JS 数据
//
//     3.附加属性
//         * 页面缩放
//         * 是否检查电话号码
//         * 是否允许内联媒体回放
//         * 媒体回放需要用户操作
//         * 媒体回放允许 AirPlay
//         * 是否镇压增量渲染
//         * 键盘调起是否需要用户操作
//         * 是否允许画中画
//         * 是否允许链接预览
//         * WebPage 相关属性
//
//     */
//
//#pragma mark ======================= WebKit 整理
//
//    /**
//
//     WebKit 相关整理
//
//     */
//
//#import <WebKit/WKBackForwardList.h>
//    {
//
//        @Abstract: 装载 BackForwardItem 的列表, 记录了 WebView 加载过的网页, 将加载过的多个网页全部记录存储, 作为数组形式存在
//
//        @ API 整理:
//        1.获取当前 Item. 获取上一个 Item. 获取下一个 Item
//        2.根据 index 获取 Item, 获取前面的所有 Items. 获取后面的所有 Items
//
//        * 如果获取的 Item 超过了 List 的范围, 则会返回 nil.
//
//    }
//
//#import <WebKit/WKBackForwardListItem.h>
//    {
//        @Abstract: 记录 WebPageItem 的对象, 内部全是 readonly 属性, 主要提供了 URL 以及 title , 虽然有 init 函数, 但是因为没有 url 设置入口, 因此, 基本不会被用户使用.
//
//        @ API 整理:
//        1. URL
//        2. title
//        3. initialURL
//
//    }
//
//#import <WebKit/WKContentRuleList.h>
//    {
//
//        //关键网址: http://www.jb51.net/article/118145.htm
//
//        @Abstract: 本质上是可以对WebView的内容添加一些自定义的过滤规则, 属于 webView 的新增功能
//        @Abstract: 意译为内容管理列表, 实际使用方式不明
//
//        @ 功能使用思路: 提供一个 JSON 给 WebKit，这个 JSON 包括内容的触发规则（trigger）和对应的处理方式（action）, 具体的使用需要再研究.
//
//        @ API 整理:
//        * 只有一个 identifier 属性, 且为 readonly 属性, 解释为 内容扩展表示的拷贝副本
//
//    }
//
//#import <WebKit/WKContentRuleListStore.h>
//    {
//        @Abstract: 属于 ContentRule 功能的组成部分, 主要是存储, 以及获取存储的 ContentRule 内容并编译.
//
//        @API:
//        1.重要: 存储 ContentRule 函数.
//        2.功能: 主要有, 编译. 查看. 移除. 获取可用. ~ 内容规则, 基本参数为 Identifier 以及 回调.
//
//    }
//
//#import <WebKit/WKError.h>
//    {
//
//        @Abstract: 配置了 WKError 的错误域, 含有多个错误码.
//
//        @Classify: 9 种
//        未知错误.
//        网页内容进程终止.
//        webView 无效.
//        JS 解析发生异常.
//        JS 结果类型不支持.
//        ContentRule 编译失败. 查看失败. 移除失败. 版本匹配错误.
//
//    }
//
//#import <WebKit/WKFoundation.h>
//    {
//
//        @Abstract: 定义了平台以及处理器的版本宏定义.
//
//    }
//
//#import <WebKit/WKFrameInfo.h>
//    {
//
//        @Abstract: 网页的框架信息, 似乎就简单的是有关网页的框架信息的集合, 定义中解释为 Transient And DataOnly, 短暂且仅仅是数据的对象.
//
//        @Classfy:
//        内部只有只读信息的获取, 1.当前框架是主框架还是子框架 2.框架当前的请求对象( NSURLRequest ) 3.框架的安全源信息( WKSecurityOrginal: 其实就包含了 协议, host, 端口号 ) 4.包含此框架的网页的 webView
//
//    }
//
//#import <WebKit/WKHTTPCookieStore.h>
//    {
//
//        @Abstract: 仅仅是 WK 框架用来管理 cookie 的对象
//
//        @Classfy: 至于关于 cookie 的增删改查函数, 以及监听函数, 监听函数使用 KVO 方式的代理监听
//
//    }
//
//#import <WebKit/WKNavigation.h>
//    {
//        @Abstract: 定义中描述为用来追踪网页加载过程的对象
//
//        @Classfy: 无函数, 无属性.
//    }
//
//#import <WebKit/WKNavigationAction.h>
//    {
//        @Abstract: 包含有关可能导致导航的操作的信息, 用于制定策略决策, 其实就是可能会导致 Nav 发生改变, 也就是页面发生跳转的行为对象.
//
//        @Classfy: 内部只包含属性信息, 都是指示页面跳转之间的联系的数据.
//        * 请求对象, 导航改变类型(枚举类型: 例如表单提交, 页面刷新等操作), 原框架, 目标框架
//        * 还有两个属性, NSEventModifierFlags 不知为什么, buttonNumber 似乎是鼠标点击次数
//
//    }
//
//#import <WebKit/WKNavigationDelegate.h>
//    {
//        @Abstract: 主要是用来监听加载过程的代理对象, 在 WK 中页面的跳转行为, 基本就被称作 navigation .
//
//        @Classfy:
//
//        相比较与 WebView 的 Process Method , Wk 的 Method 数量更多, 可监听的位置共详细, 除了基本的, 开始, 结束, 失败等函数, 增加以下函数.
//        * 接收到重定向的函数
//        * 接收到服务器要求验证身份的函数
//        * WKNavigationAction & 两个 Policy : Action 内部区分了多种
//
//    }
//
//#import <WebKit/WKNavigationResponse.h>
//    {
//        @Abstract: 信息类-被动获取: 主要提供了 Request, 是否为主框架, 是否能展示 MIME 类型
//    }
//
//#import <WebKit/WKOpenPanelParameters.h>
//    {
//        @Abstract: 信息类-被动获取: 包含一个已经指定好的的文件上传参数
//
//        @Classfy: 只有一个参数: 文件上传是否允许多个文件上传.
//
//    }
//
//#import <WebKit/WKPreferences.h>
//    {
//
//        @Abstrac: 信息类-主动设置: 网页偏好设置
//
//        @Classfy:
//        * 字体缩放尺寸
//        * 1. 是否可以执行 JS 2.JS 能否自动打开窗口
//        * Java 能否执行
//        * 是否允许插件
//        * 选项卡是否连接焦点?
//    }
//
//#import <WebKit/WKPreviewActionItem.h>
//    {
//        @Abstract: 信息类-被动获取: 就是预览操作的 item 对象, 内部只包含一个 item 的 identifier .
//    }
//
//#import <WebKit/WKPreviewActionItemIdentifiers.h>
//    {
//        @Abstract: 信息类-被动获取: 只包含了几个 PreviewActionIdentifier 类型的字符串, 应该是从哪里能获取一个 infoDict, 这个是 key .
//    }
//
//#import <WebKit/WKPreviewElementInfo.h>
//    {
//        @Abstract: 信息类-被动获取: 预览元素信息, 其实只包含了预览元素的 url
//    }
//
//#import <WebKit/WKProcessPool.h>
//    {
//        @Abstract: 进程池对象, 内部无任何数据函数, 但是因为涉及到网页内容进程, 对于内存管理 以及 多控件的网页加载机制, 应该是有可以推敲的地方.
//    }
//
//#import <WebKit/WKScriptMessage.h>
//    {
//        @Abstract: 信息类-被动获取: 只是有关网页发出的脚本消息的相关信息
//
//        @Classfy:
//        * 主要可读信息为: 信息体. 脚本框架信息. 消息发送对象的名称. 发出消息的网页对象.
//    }
//
//#import <WebKit/WKScriptMessageHandler.h>
//    {
//        @Abstract: 函数类-代理被动监听: 只有一个代理协议, 用来监听 JS 消息运行/
//    }
//
//#import <WebKit/WKSecurityOrigin.h>
//    {
//        @Abstract: 信息类-被动获取, 本质就是一个安全的源地址的信息, 内部主要是三个属性: 协议, 主机地址, 端口号
//    }
//
//#import <WebKit/WKURLSchemeHandler.h>
//    {
//        @Abstract: 内部只有一份协议, 协议中函数能监听 webview 开始加载, 以及 停止加载 UrlSchemeTask .
//
//        @Classfy: 函数中有两个参数: 调用的 webView 以及执行的 URLSchemeTask 对象.
//    }
//
//#import <WebKit/WKURLSchemeTask.h>
//    {
//        @Abstract: 内部只有一份协议, 协议中暴露了 task 对象的 Request, 同时, 还有几个不同状态的监听函数.
//            * 使用方式: 其实是将 Task 对象作为了一个小的功能模块对象.
//
//        @Classfy:
//        * 1.接收响应header 2.拼接数据 3.完成 4.失败
//    }
//
//#import <WebKit/WKUserContentController.h>
//    {
//        @Abstract: 不太明了 Controller 的含义, 主要管理了有关页面内的三个主要对象 1.UserScript 2.ScriptMessageHandler 3.ContentRule , 包括了这些对象的增加以及删除函数. 类似于一个管理类.
//    }
//
//#import <WebKit/WKUserScript.h>
//    {
//        @Abstract: 数据对象: 主要含有 1. JS 代码 2. JS 注入时机枚举 3. JS 注入的框架是否为全局的 此外, 就只有一个初始化函数, 并且只能在初始化函数中设置以上属性, 其他时候属性为只读.
//    }
//
//#import <WebKit/WKWebsiteDataRecord.h>
//    {
//        @Abstract: 根据网址 ( DomainName ) 创建的数据存储对象, 对象的主要元素有两个, 1. 记录的名称( displayName ) 2. 存储数据的集合 , 集合中的字符串应该是 URL 数据, 文件中定义了多个字符串 key
//    }
//
//#import <WebKit/WKWebsiteDataStore.h>
//    {
//        @Abstract: 主要作用是管理一个网站的数据对象( Record ), 可以进行查找以及删除操作, 与 WKWebsiteDataRecord 相关联, 因为操作的对象就是 WKWebsiteDataRecord 对象的集合, 如果不希望 webview 存储数据, 设置 Store 的不保存临时数据即可.
//    }
//
//#import <WebKit/WKWindowFeatures.h>
//    {
//        @Abstract: 信息类-被动获取, 能获取关于窗口特色设置的信息, 即 WindowFeature , 实际上是 ContainingWiondow 的属性.
//        @Classfy: 可获取的主要是: 坐标 x. y. width. height. 以及 菜单条. 状态条. 工具条. 是否可见
//    }
//
//#import <WebKit/WebKitLegacy.h>
//    {
//        @Abstract: 不明所以的文件, 导入了 //#import <WebKitLegacy/WebKit.h> 文件 kit 遗产?
//    }
//
//#import <WebKit/WKWebView.h>
//    {
//        @Abstract: 是整个 WK 框架的核心, 围绕着加载网页, 衍生出了很多分支功能.
//
//        @Classfy: 脉络
//
//        * WKWebViewConfiguration: 网页本身的属性控制
//        * WKNavigationDelegate: 跳转控制相关
//        * WKUIDelegate: 用户交互相关
//        * BackForwardList:
//        *
//
//
//    }
//
//#import <WebKit/WKUIDelegate.h>
//    {
//        @Abstract: 分担了一部分 WebView 的主动功能, 属于主动部分
//
//    }
//
//#import <WebKit/WKWebViewConfiguration.h>
//    {
//        @Abstract: 主要是分担了 WebView 的页面设置的部分, 相对来说, 属于被动部分
//
//    }
//
//
//}
//
//
//
//// 一个目标库一定会有 * 函数功能类 ( 分为 1.主动调用 2.被动监听 ) * 信息提供类 ( 分为 1.主动设置 2.被动获取 )
//// 上面的是对库的架构的一般分析, 进行独立分析的时候还是要看类库之间的组织方式
//
//
//
///**
// WebView 类库主文件, 主要功能分为以下四个模块
// * WKBackForwardList
// * Configuration
// * NavgationDelegage
// * UIDelegate
// */
//#import <WebKit/WKWebView.h>
//
////常规宏定义文件 & 错误对象文件
//#import <WebKit/WKFoundation.h>
//#import <WebKit/WebKitLegacy.h>
//#import <WebKit/WKError.h>
//
////浏览记录
//#import <WebKit/WKBackForwardList.h> // 被动信息类- WebView 加载过的页面数组
//#import <WebKit/WKBackForwardListItem.h> // 被动信息类- Item 内包含了页面的基本信息
//
////网页配置信息
///**
// 主要配置可配置一下方面
// * 进程池
// * 偏好设置
// * 用户内容控制器
// * 网站数据存储
// * 杂项: .阻止过分渲染 .用户代理应用名称 .内联媒体播放器相关(画中画相关) .网页数据探测类型 .忽略页面缩放 .界面重定向策略 .URLScheme 相关管理 等
// */
//#import <WebKit/WKWebViewConfiguration.h>
//{
//    /**
//     FrameInfo -> SecurityOrginal
//     主要提供了当前网页的一系列相关信息
//     */
//    #import <WebKit/WKFrameInfo.h>// 被动信息类- 页面框架相关信息: 当前 view. 保密源. 请求对象. 是否为主框架.
//    #import <WebKit/WKSecurityOrigin.h>// 被动信息类- 保密源详细信息: 协议. 主机地址. 端口号.
//
//    /**
//     URLSchemeHandler -> URLSchemeTask
//     主要提供了 URLScheme 的相关活动监听接口
//     */
//    #import <WebKit/WKURLSchemeHandler.h>// 被动函数类- URLScheme 句柄协议: 提供了开始和结束的监听函数
//    #import <WebKit/WKURLSchemeTask.h>// 被动函数类- URLSchemeTask 协议: 提供了请求信息, 以及 接收响应. 接收数据. 完成. 失败. 的函数
//
//    /**
//     主要提供了 WebView 的进程池, 用来优化内存等, 类似于 tableview 的重用, 没有操作权限.
//     */
//    #import <WebKit/WKProcessPool.h> // 进程池
//
//    /**
//     主要提供了网页偏好设置的入口, 可以设置一些网页属性.
//     */
//    #import <WebKit/WKPreferences.h> // 主动设置类- 最小缩放比例. JS相关设置. 能否使用插件插件.
//
//    /**
//     UserContentController -> 1.ScriptMessageHandler 2.ContentRule 3.UserScript
//     主要功能是管理以上三种消息, 可以进行增删操作.
//     */
//    #import <WebKit/WKUserContentController.h> //信息类- 用户脚本 脚本消息 页面过滤规则
//    {
//        /**
//         ScriptMessageHandler -> ScriptMessage
//         脚本消息相关
//         */
//        #import <WebKit/WKScriptMessageHandler.h>// 被动函数类- 监听 JS 消息
//        #import <WebKit/WKScriptMessage.h>// 被动信息类- 提供 JS 消息的相关数据
//
//        /**
//         ContentRuleListStore -> ContentRuleList
//         页面过滤规则相关
//         */
//        #import <WebKit/WKContentRuleListStore.h>// 主动函数类- ContentRule 的增删改编译
//        #import <WebKit/WKContentRuleList.h>// 被动信息类- ContentRule 的标识符
//
//        /**
//         用户脚本相关操作以及属性获取
//         */
//        #import <WebKit/WKUserScript.h>// 主动函数+被动信息- 提供了 UserScript 的创建以及创建后的信息获取
//    }
//
//    /**
//     WebsitDataStore -> CookieStore & DataRecord
//     网站数据相关
//     */
//    #import <WebKit/WKWebsiteDataStore.h>// 主动函数类- 提供了网站数据 & cookie 的删查功能
//    #import <WebKit/WKHTTPCookieStore.h>// 主动+被动函数类- 提供了 cookie 的增删查功能以及监听功能.
//    #import <WebKit/WKWebsiteDataRecord.h>// 被动信息类- 提供网站数据
//}
//
///**
// NavigationDelegate -> Navigation. NavigationAction. NavigationResponse.
// 主要负责 WebView 在跳转时的相关信息传递以及函数监听
// */
//#import <WebKit/WKNavigationDelegate.h>
//{
//    #import <WebKit/WKNavigation.h>// 被动信息类- 主要为页面加载的进度做标识
//    #import <WebKit/WKNavigationAction.h>// 被动信息类- 主要提供页面跳转行为的相关信息, 网页前后框架信息. 跳转请求对象. 跳转行为. 点击次数.
//    #import <WebKit/WKNavigationResponse.h>// 被动信息类- 主要提供跳转后接收到的响应信息
//}
//
///**
// UIDelegate -> OpenPanelParameters & PreviewElement
// 主要负责页面相关变动的监听, 包括: 页面创建&关闭. JS 运行 提示框&确认框&输入框时的拦截. 执行预览时的监听.
// */
//#import <WebKit/WKUIDelegate.h>
//{
//
//    #import <WebKit/WKWindowFeatures.h>// 被动信息类- 提供了页面的 Feature 信息, 坐标. 宽高. 是否允许缩放. 工具条/状态栏/标签栏是否可见.
//    #import <WebKit/WKOpenPanelParameters.h>// 被动信息类- 是否允许多文件上传
//
//    /**
//     ActionItem -> ActionItemIdentifier & PreviewElementInfo
//     页面预览相关类目
//     */
//    #import <WebKit/WKPreviewElementInfo.h>// 被动信息类- 预览元素信息, 只提供 url
//    #import <WebKit/WKPreviewActionItem.h>// 被动信息类- 预览行为, 只有一个标识符属性用来标识预览行为的类型
//    #import <WebKit/WKPreviewActionItemIdentifiers.h>// 被动信息类- 预览行为类型标识符, 通过判断常量字符串判断预览行为类型, 打开. 添加列表. 拷贝. 分享.
//
//}
//

@end
