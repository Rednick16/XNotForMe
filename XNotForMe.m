#import <UIKit/UIKit.h>
#import "swizzling/swizzling.h"

#pragma mark - TFNScrollingSegmentedViewController

static Class THFHomeTimelineContainerVCClass = NULL;

@interface TFNScrollingSegmentedViewController : UIViewController
@end

static BOOL (*TFNScrollingSegmentedViewController$$orig__tfn_shouldHideLabelBar)(TFNScrollingSegmentedViewController* self, SEL _cmd) = NULL;
static BOOL TFNScrollingSegmentedViewController$$new__tfn_shouldHideLabelBar(TFNScrollingSegmentedViewController* self, SEL _cmd)
{
    // Only hide on the home page, so it dosn't effect other pages and break the UI
    if ([[self parentViewController] isKindOfClass:THFHomeTimelineContainerVCClass])
    {
        return YES;
    }

    return TFNScrollingSegmentedViewController$$orig__tfn_shouldHideLabelBar(self, _cmd);
}

static NSInteger (*TFNScrollingSegmentedViewController$$orig_pagingViewController$numberOfPagesInSection)(TFNScrollingSegmentedViewController*, SEL, id, id) = NULL;
static NSInteger TFNScrollingSegmentedViewController$$new_pagingViewController$numberOfPagesInSection(TFNScrollingSegmentedViewController* self, SEL _cmd, id arg1, id arg2)
{
    if ([[self parentViewController] isKindOfClass:THFHomeTimelineContainerVCClass])
    {
        return 1;
    }

    return TFNScrollingSegmentedViewController$$orig_pagingViewController$numberOfPagesInSection(self, _cmd, arg1, arg2);
}

static id (*TFNScrollingSegmentedViewController$$orig_pagingViewController$viewControllerAtIndexPath)(TFNScrollingSegmentedViewController*, SEL, UIViewController*, NSIndexPath*) = NULL;
static id TFNScrollingSegmentedViewController$$new_pagingViewController$viewControllerAtIndexPath(TFNScrollingSegmentedViewController* self, SEL _cmd, UIViewController* viewController, NSIndexPath* indexPath)
{
    if ([[self parentViewController] isKindOfClass:THFHomeTimelineContainerVCClass])
    {
        indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    }

    return TFNScrollingSegmentedViewController$$orig_pagingViewController$viewControllerAtIndexPath(self, _cmd, viewController, indexPath);
}

__attribute__((constructor)) static void entry(void)
{
    THFHomeTimelineContainerVCClass = objc_getClass("THFHomeTimelineContainerViewController");
    Class TFNScrollingSegmentedViewControllerClass = objc_getClass("TFNScrollingSegmentedViewController");

    SupportHookMessageEx(
        TFNScrollingSegmentedViewControllerClass, 
        sel_registerName("_tfn_shouldHideLabelBar"), 
        (IMP)&TFNScrollingSegmentedViewController$$new__tfn_shouldHideLabelBar, 
        (IMP*)&TFNScrollingSegmentedViewController$$orig__tfn_shouldHideLabelBar
    );

    SupportHookMessageEx(
        TFNScrollingSegmentedViewControllerClass, 
        sel_registerName("pagingViewController:numberOfPagesInSection:"), 
        (IMP)&TFNScrollingSegmentedViewController$$new_pagingViewController$numberOfPagesInSection, 
        (IMP*)&TFNScrollingSegmentedViewController$$orig_pagingViewController$numberOfPagesInSection
    );

    SupportHookMessageEx(
        TFNScrollingSegmentedViewControllerClass, 
        sel_registerName("pagingViewController:viewControllerAtIndexPath:"), 
        (IMP)&TFNScrollingSegmentedViewController$$new_pagingViewController$viewControllerAtIndexPath, 
        (IMP*)&TFNScrollingSegmentedViewController$$orig_pagingViewController$viewControllerAtIndexPath
    );
}