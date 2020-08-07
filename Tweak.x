@interface _UIBackdropViewSettings
@property (nonatomic, assign) long long style;
@property (nonatomic, assign) double blurRadius;
@property (nonatomic, assign) long long blurHardEdges;
@property (nonatomic, copy) NSString *blurQuality;
- (instancetype)initWithDefaultValues;
@end

@interface _UIBackdropView : UIView
@property (nonatomic, retain) _UIBackdropViewSettings *outputSettings;
- (instancetype)initWithFrame:(CGRect)frame autosizesToFitSuperview:(BOOL)autosizesToFitSuperview settings:(_UIBackdropViewSettings *)settings;
@end

@interface SBControlCenterContentContainerView : UIView
@property (nonatomic, retain) UIView *backdropView;
@end

@interface SBControlCenterContainerView : UIView
@property (nonatomic, retain) SBControlCenterContentContainerView *contentContainerView;
@end

@interface SBControlCenterViewController : UIViewController
@property (nonatomic, retain) SBControlCenterContainerView *view;
@property (nonatomic, retain) _UIBackdropView *customBackdrop;
@end

%hook SBControlCenterViewController

%property (nonatomic, retain) _UIBackdropView *customBackdrop;

- (void)viewDidLoad {
  %orig;
  self.view.contentContainerView.backdropView.hidden = YES;
  _UIBackdropViewSettings *settings = [[%c(_UIBackdropViewSettings) alloc] initWithDefaultValues];
  settings.style = 1;
  settings.blurRadius = 16.0f;
  settings.blurHardEdges = 3;
  settings.blurQuality = @"default";
  self.customBackdrop = [[%c(_UIBackdropView) alloc] initWithFrame:CGRectZero autosizesToFitSuperview:YES settings:settings];
  self.customBackdrop.outputSettings.blurRadius = 0;
  self.customBackdrop.alpha = 0;
  [self.view insertSubview:self.customBackdrop atIndex:0];
}

- (void)setRevealPercentage:(double)revealPercentage {
  self.customBackdrop.alpha = revealPercentage;
  %orig;
}

%end

%hook SBControlCenterGrabberView
- (CGRect)_grabberRect { return CGRectNull; }
%end

%hook SBControlCenterContainerView
- (void)_updateDarkeningFrame {}
%end
