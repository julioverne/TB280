#import <dlfcn.h>
#import <objc/runtime.h>
#import <substrate.h>

#define NSLog(...)

@interface PTHTweetbotPostDraft : NSObject
-(NSString*)postText;
@end

static void fixFor280Count(id selfInstance)
{
	PTHTweetbotPostDraft* _draft = (PTHTweetbotPostDraft*)object_getIvar(selfInstance, class_getInstanceVariable([selfInstance class], "_draft"));
	UILabel* _counterView = (UILabel*)object_getIvar(selfInstance, class_getInstanceVariable([selfInstance class], "_counterView"));
	if(!_counterView) {
		_counterView = (UILabel*)object_getIvar(selfInstance, class_getInstanceVariable([selfInstance class], "_counterLabel"));
	}
	if(_draft && _counterView) {
		_counterView.text = [NSString stringWithFormat:@"%d", (int)(280 - [[_draft postText] length])];
	}
}

%hook PTHTweetbotPostDraft
- (NSUInteger)length
{
	if([[self postText] length] <= 280) {
		return 10;
	}
	return %orig;
}
%end

%hook PTHTweetbotPostToolbarView
- (void)_draftDidChange
{
	%orig;
	fixFor280Count(self);
}
- (void)_draftDidUpdate
{
	%orig;
	fixFor280Count(self);
}
- (void)_draftSelectedRangeDidChange
{
	%orig;
	fixFor280Count(self);
}
- (void)viewWillLayoutSubviews
{
	%orig;
	fixFor280Count(self);
}
- (void)layoutSubviews
{
	%orig;
	fixFor280Count(self);
}
- (void)_updateView
{
	%orig;
	fixFor280Count(self);
}
%end

%hook PTHTweetbotPostController
- (void)_draftDidChange
{
	%orig;
	fixFor280Count(self);
}
- (void)_draftDidUpdate
{
	%orig;
	fixFor280Count(self);
}
- (void)_draftSelectedRangeDidChange
{
	%orig;
	fixFor280Count(self);
}
- (void)viewWillLayoutSubviews
{
	%orig;
	fixFor280Count(self);
}
%end

