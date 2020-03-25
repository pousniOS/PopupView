//
//  Popuup.m
//  test_0
//
//  Created by apple on 24/3/2020.
//  Copyright © 2020 apple. All rights reserved.
//

#import "Popuup.h"

static Popuup *POPUP = nil;

@interface PopupModel : NSObject
@property(nonatomic,strong)UIView *subView;//显示的视图
@property(nonatomic,assign)NSTimeInterval longTime; //显示时长小于0则说明永久显示
@property(nonatomic,assign)BOOL postponeRemove; //是否需要延后移除默认为NO
@end

@implementation PopupModel
@end

@interface Popuup()<NSCopying,NSMutableCopying>
@property(nonatomic,strong)NSMutableArray<PopupModel *> *tasks;
@property(nonatomic,copy)void (^showEffectsBlock)(UIView * _Nonnull superView, UIView * _Nonnull subView);
@property(nonatomic,strong)UIView *superView;
@property(nonatomic,assign)BOOL isShow;
@end

@implementation Popuup

+(instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        POPUP = [[super allocWithZone:NULL] init];
        POPUP.tasks = [[NSMutableArray alloc] init];
        POPUP.superView = [[UIView alloc] init];
        POPUP.superView.userInteractionEnabled = NO;
    });
    return POPUP;
}

+(void)setIsModal:(BOOL)isModal{
    [Popuup share].superView.userInteractionEnabled = isModal;
}

-(void (^)(UIView * _Nonnull superView, UIView * _Nonnull subView))showEffectsBlock{
    if (!_showEffectsBlock) {
        _showEffectsBlock = ^(UIView * _Nonnull superView, UIView * _Nonnull subView){
            CGRect frame = subView.frame;
            CGPoint center = subView.center;
            subView.frame = CGRectZero;
            subView.center = center;
            [UIView animateWithDuration:0.2 animations:^{
                subView.frame = frame;
            }];
        };
    }
    return _showEffectsBlock;
}

-(id)copyWithZone:(NSZone *)zone{
    return [Popuup share];
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    return [Popuup share];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [Popuup share];
}

+(UIWindow *)currentWindow{
    return [[UIApplication sharedApplication].windows lastObject];
}

+(void)view:(UIView*)subView{
    [Popuup view:subView andCenterOffset:CGPointZero];
}

+(void)view:(UIView*)subView andCenterOffset:(CGPoint)offset{
    [Popuup view:subView andCenterOffset:offset andUntil:0.0f];
}

+(void)view:(UIView *)subView andUntil:(NSTimeInterval)time{
    [Popuup view:subView andCenterOffset:CGPointZero andUntil:time];
}

+(void)view:(UIView*)subView andCenterOffset:(CGPoint)offset andUntil:(NSTimeInterval)time{
    [Popuup share].superView.frame = [Popuup currentWindow].frame;
    subView.center = CGPointMake([Popuup share].superView.center.x + offset.x, [Popuup share].superView.center.y + offset.y);
    
    PopupModel *model = [[PopupModel alloc] init];
    model.longTime = time;
    model.subView = subView;
    [[Popuup share].tasks addObject:model];
    if ([Popuup share].isShow == NO) {
        [Popuup show];
    }
}

+(void)text:(NSString *)text{
    [self text:text andCenterOffset:CGPointZero andUntil:0.0f];
}

+(void)text:(NSString *)text andCenterOffset:(CGPoint)offset{
    [self text:text andCenterOffset:offset andUntil:0.0f];
}

+(void)text:(NSString *)text andUntil:(NSTimeInterval)time{
    [self text:text andCenterOffset:CGPointZero andUntil:time];
}

+(void)text:(NSString *)text andCenterOffset:(CGPoint)offset andUntil:(NSTimeInterval)time{
    UILabel *lable = [[UILabel alloc] init];
    lable.numberOfLines = 0;
    lable.text = [@"  " stringByAppendingString:text];
    lable.lineBreakMode = NSLineBreakByCharWrapping;
    lable.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    lable.textColor = [UIColor whiteColor];
    lable.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.5];
    lable.layer.cornerRadius = 4.0f;
    lable.layer.masksToBounds = YES;
    CGSize fitSize = [lable sizeThatFits:CGSizeMake([Popuup currentWindow].frame.size.width - 10-70, 10000)];
    lable.frame=CGRectMake(0, 0, fitSize.width+10, fitSize.height+10);
    [Popuup view:lable andCenterOffset:offset andUntil:time];
}

+(void)attText:(NSAttributedString *)text{
    [Popuup attText:text andCenterOffset:CGPointZero];
}

+(void)attText:(NSAttributedString *)text andCenterOffset:(CGPoint)offset{
    [Popuup attText:text andCenterOffset:offset andUntil:0.0f];
}

+(void)attText:(NSAttributedString *)text andUntil:(NSTimeInterval)time{
    [Popuup attText:text andCenterOffset:CGPointZero andUntil:time];
}

+(void)attText:(NSAttributedString *)text andCenterOffset:(CGPoint)offset andUntil:(NSTimeInterval)time{
    UILabel *lable = [[UILabel alloc] init];
    lable.numberOfLines = 0;
    lable.attributedText = text;
    CGSize fitSize = [lable sizeThatFits:CGSizeMake([Popuup currentWindow].frame.size.width - 10-70, 10000)];
    lable.frame=CGRectMake(0, 0, fitSize.width+10, fitSize.height+10);
    [Popuup view:lable andCenterOffset:offset andUntil:time];
}
+(void)showEffects:(void(^)(UIView *superView,UIView *subView))showEffectsBlock{
    [Popuup share].showEffectsBlock = showEffectsBlock;
}
+(void)show{
    if ([Popuup share].tasks.count <= 0) {
        return;
    }
    PopupModel *object = [[Popuup share].tasks firstObject];
    UIView *subView = object.subView;
    NSTimeInterval time = object.longTime;

    if ([Popuup share].isShow == NO) {
        [Popuup share].isShow = YES;
        [[Popuup share].superView addSubview:subView];
        [[Popuup currentWindow] addSubview:[Popuup share].superView];
        [Popuup share].showEffectsBlock([Popuup share].superView, subView);
        if (time>0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self removeWithObject:object];

                //检测是否有需要延迟移除的手动移除弹窗
                PopupModel *object = [[Popuup share].tasks firstObject];
                if (object.postponeRemove == YES) {
                    [self removeWithObject:object];
                }
            });
        }
    }
}
+(void)removeWithObject:(PopupModel *)object{
    UIView *subView = object.subView;
    [subView removeFromSuperview];
    [[Popuup share].superView removeFromSuperview];
    [[Popuup share].tasks removeObject:object];
    [Popuup share].isShow = NO;
    [self show];
}

//手动移除当前弹窗
+(void)remove{
    if ([Popuup share].tasks.count <= 0) {
        [Popuup share].isShow = NO;
        return;
    }
    /*
    1.移除当前弹窗时需要判断当前弹窗的弹窗是否为需要手动移除型弹窗（longtime <= 0 的问需要手动移除弹窗）；
    2.如若不是，则需要在tasks任务列表中查找到需要移除的手动弹窗将其标记为 postponeRemove == YES 延迟移除；
    3.在执行完成自动移除弹窗时去检测当前弹窗是否为 postponeRemove == YES，若是则执行移除
     **/
    PopupModel *object = [[Popuup share].tasks firstObject];
    if (object.longTime > 0) {
        //标记需要自动弹出的视图
        NSInteger count = [Popuup share].tasks.count;
        NSArray<PopupModel*> *popModels =[Popuup share].tasks;
        for (NSInteger i = 0; i<count; i++) {
            PopupModel *popModel = popModels[count-i-1];
            if (popModel.longTime <= 0 && popModel.postponeRemove == NO) {
                popModel.postponeRemove = YES;
                break;
            }
        }
        return;
    }
    [self removeWithObject:[Popuup share].tasks.firstObject];
}
@end
