

## IBProperty

## 前言

对于 UI 界面的编写工作，是否应该用 xib/storyboard 完成，一直是iOS开发中的争议，然而本文并参与讨论这个话题。（手动笑脸）
有兴趣的朋友可以参考唐巧的[这篇文章](http://blog.devtang.com/2015/03/22/ios-dev-controversy-2/)
本文只是为喜欢使用或是想去使用 xib/storyboard 的朋友，提供一个强大的工具。在使用 xib/storyboard的时候，更加方便灵活，同时也为 xib/storyboard在添加约束，适配屏幕上做了一些改进，使之使用起来更加简单有效

## 更新日志

###### 2018-07-07 ~ cocoapods version 1.1.9
* 解决因为IBProperty 引起的 `Failed to render and update auto layout` 错误， 这是一个渲染错误，并不会影响代码的运行。
###### 2018-07-07 ~ cocoapods version 1.1.9
* 解决极少部分block循环引用的问题
###### 2018-06-18 ~ cocoapods version 1.1.8
* CornerRadius：移除mask实现方式，因为mask会触发离屏渲染。恢复并优化了Core Graphics绘制圆角
* 解决渐变和圆角同时设置偶尔会发生冲突的问题
* AdaptXBottowConstant：加入iPhone X底部约束适配
###### 2018-06-11 ~ cocoapods version 1.1.7
* 截图：此前有一张截图中的iPhone SE 显示不完整，是由于因为款 mac-pro 上 se模拟器缩放到最小，引发的渲染问题，类似于tableView的横线。感谢网友[limingLiuBaBa](https://github.com/limingLiuBaBa)指出
* Gradient：为所有视图加入了简单的渐变色处理，细节见文末。
* CornerRadius：由layer的mask 替换之前的Core Graphics绘制。 

所有属性见文末Property

## IBProperty

下图为IBProperty通过Storyboard搭建的效果图

![图1.png](https://upload-images.jianshu.io/upload_images/5192751-cf412c2dc9bb9b97.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![图2.png](https://upload-images.jianshu.io/upload_images/5192751-a464356a09246cdc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

IBProperty 通过IB_DESIGNABLE 和 IBInspectable 以类目的形式为xib/storyboard  添加了一些简单有效的新属性，如阴影、圆角、毛玻璃等（具体见本文最后）
在xib/storyboard上要做到完美适配，需要添加很多较为复杂的约束，如果需要让约束的常量适配的话，就需要通过代码去设置了；字体的适配也是如此，通过IBProperty只需要在xib/storyboard设置一个属性就OK了。这些适配不仅体现在约束和字体上，IBProperty还提供了一系列适配方式，让xib/storyboard 在屏幕适配上也更加简单。

## 安装

（oc、swift 无区别）
* 使用cocoapods (推荐)

pod 'IBProperty'  
* 手动下载    
从[Github地址](https://github.com/SunriseOYR/IBProperty) 下载项目，然后将IBProperty 和 Aspects(如果项目中已经集成 则不需要) 文件夹拖入到工程中即可

## 使用

**IBProperty只需要集成到项目中就可以为xib/storyboard服务了**

然后你就可以在xib/storyboard 选中对象赋值了（具体属性及含义参照本文最后）
比如你要适配一个约束（图3），或是为UITextView加上placeholder（图4）

![图3.png](http://upload-images.jianshu.io/upload_images/5192751-aba0b7dd32e38936.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![图4.png](http://upload-images.jianshu.io/upload_images/5192751-9d511d4820c53659.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

IBProperty不需要引用任何头文件，除非确实需要在代码中使用（事实上，并不推荐这么做）
因为IBProperty旨在服务于xib/storyboard，其中大部分属性都只是计算型属性，少部分属性无法间接获取的，通过getter 也将无法获取它，因为并没有为它真正开辟内存。此外，在代码中使用IBProperty，对同一个属性做多次赋值，可能会多次适配，导致一些奇怪的bug。**总之，如果确实需要在代码中使用IBProperty，一定要对源码比较熟悉才行**

## Property

* UIView  

        //border
        ib_borderWidth;
        ib_borderColor;

        //cornerRadius
        ib_cornerRadius;
        //视图的 cornerRadius 始终保持高度的一半
        ib_cornerCircle;

        //shadow
        ib_shadowOffset;
        ib_shadowColor;
        ib_shadowOpacity;
        ib_shadowRadius;

        /*
        * 渐变开始颜色 - 渐变结束颜色
        只设置开始颜色 渐变将由alpha 0.3 - 0.1； 只设置结束颜色 渐变将由alpha 0.1 - 0.3
        */
        ib_gradientStartColor;
        ib_gradientEndColor;

> 注: IBProperty对所有视图的圆角(ib_cornerRadius、ib_cornerCircle) 做了离屏渲染处理
下图（图5）上为只设置ib_gradientStartColor， 下为只设置ib_gradientEndColor

![图5.png](https://upload-images.jianshu.io/upload_images/5192751-71ebad74e8be3319.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


* UILabel    

        // 根据屏幕的宽度 适配 字体大小
        ib_adaptFont;
        // 给文字添加 下划线
        ib_underLine;
        // 给文字添加中间横线
        ib_middleLine;

* UIButton  

        // 根据屏幕的宽度 适配 字体大小
        ib_adaptFont;
        // 根据屏幕的宽度 适配 contentEdgeInsets、titleEdgeInsets、imageEdgeInsets
        ib_adaptInsets;

* UIControl  

        // 禁止重复点击（2秒内不能重复点击）
        ib_reClickEnabled;

* UITextField  

        // 根据屏幕的宽度 适配 字体大小
        ib_adaptFont;

* UITextView  

        // 根据屏幕的宽度 适配 字体大小
        ib_adaptFont;
        // 类似于UITextField的placeholder
        ib_placeholder;

* UIImageView    

        // 亮色模糊效果（毛玻璃）
        ib_darkEffect;
        // 暗色色模糊效果
        ib_lightEffect;
        // 模糊效果不透明度
        ib_effectOpacity;

* UICollectionViewFlowLayout  

        // 根据屏幕的宽度 适配 itemSize
        ib_adaptSize;
        // collectionView每行显示的item的个数,自动适配屏幕 
        ib_numberItemsForRow;

* NSLayoutConstraint  

        // 根据屏幕的宽度 适配 约束常量 constant
        ib_adaptConstant;
        / / 适配导航栏高度，若为YES constant将不会适配比例，而是在iPhone X 上加上24pt, 常用于 为自定义导航栏的子视图添加约束 
        ib_adaptXTopConstant;

## 后续

IBProperty处于不间断更新当中，读者有较好的建议或意见，都可以提出issue，每次更新都会在GitHub以及[简书](https://www.jianshu.com/p/9a758301c5f4)上记录更新日志。
喜欢的话给个小星星喔
