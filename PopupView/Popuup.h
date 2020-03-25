//
//  Popuup.h
//  test_0
//
//  Created by apple on 24/3/2020.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 弹窗工具
 使用该弹窗工具可以让APP需要弹出显示的内容按照时间顺序有序挨个出,所有的方法需在主线程中执行
 例如：目前需要弹出a,b,c三个弹窗顺序安装a,b,c，则a显示完成才会显示b、b显示完成才会显示c
 **/

NS_ASSUME_NONNULL_BEGIN

@interface Popuup : NSObject

/*
 设置弹窗类型
 @parma:isModal NO非模态弹窗|YES模态弹窗 默认非模态
 **/
+(void)setIsModal:(BOOL)isModal;
/*
 设置视图弹出的效果
 showEffectsBlock：superView 弹窗的容器视图| subView弹窗的内容视图
 **/
+(void)showEffects:(void(^)(UIView *superView,UIView *subView))showEffectsBlock;

/*
 弹窗一个自定义视图
 @param:subView 添加显示的视图
 **/
+(void)view:(UIView*)subView;

/*
弹窗一个自定义视图
@param:subView 添加显示的视图
@param:offset 以中心为参考的偏移
**/
+(void)view:(UIView*)subView andCenterOffset:(CGPoint)offset;

/*
弹窗一个自定义视图
@param:subView 添加显示的视图
@param:time 弹窗显示的时长
**/
+(void)view:(UIView*)subView andUntil:(NSTimeInterval)time;

/*
弹窗一个自定义视图
@param:subView 添加显示的视图
@param:offset 以中心为参考的偏移
@param:time 弹窗显示的时长
**/
+(void)view:(UIView*)subView andCenterOffset:(CGPoint)offset andUntil:(NSTimeInterval)time;

/*
弹窗一个自定义视图
@param:text 添加显示的文本
**/
+(void)text:(NSString *)text;

/*
弹窗一个自定义视图
@param:text 添加显示的文本
@param:offset 以中心为参考的偏移
**/
+(void)text:(NSString *)text andCenterOffset:(CGPoint)offset;

/*
弹窗一个自定义视图
@param:text 添加显示的文本
@param:time 弹窗显示的时长
**/
+(void)text:(NSString *)text andUntil:(NSTimeInterval)time;

/*
弹窗一个自定义视图
@param:text 添加显示的文本
@param:offset 以中心为参考的偏移
@param:time 弹窗显示的时长
**/
+(void)text:(NSString *)text andCenterOffset:(CGPoint)offset andUntil:(NSTimeInterval)time;

/*
弹窗一个自定义视图
@param:text 添加显示的属性字符串文本
**/
+(void)attText:(NSAttributedString *)text;

/*
弹窗一个自定义视图
@param:text 添加显示的属性字符串文本
@param:offset 以中心为参考的偏移
**/
+(void)attText:(NSAttributedString *)text andCenterOffset:(CGPoint)offset;

/*
弹窗一个自定义视图
@param:text 添加显示的属性字符串文本
@param:time 弹窗显示的时长
**/
+(void)attText:(NSAttributedString *)text andUntil:(NSTimeInterval)time;

/*
弹窗一个自定义视图
@param:text 添加显示的属性字符串文本
@param:offset 以中心为参考的偏移
@param:time 弹窗显示的时长
**/
+(void)attText:(NSAttributedString *)text andCenterOffset:(CGPoint)offset andUntil:(NSTimeInterval)time;

/*
 移除弹窗，该方法只能移除没有添加显示时长的弹窗
 **/
+(void)remove;
@end

NS_ASSUME_NONNULL_END
