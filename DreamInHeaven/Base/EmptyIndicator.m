
#import "EmptyIndicator.h"
#import "UIView+setFrame.h"
#import "FNTFoundation.h"
#define kTextFont       kCurNormalFontOfSize(13)
#define kIndicatorHeight  22

@interface EmptyIndicator(){
    UIControl *_emptyViewTipContainer;
}
@property(nonatomic, strong)UILabel*                emptyLabel;
@property(nonatomic, strong)UILabel*                subTitleLabel;
@property(nonatomic, strong)UIImageView *           loadFaildImageView;
@end

@implementation EmptyIndicator
@synthesize emptyViewTipContainer = _emptyViewTipContainer;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.loadFaildImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_empty_nonetwork.png"]];
        self.loadFaildImageView.center = CGPointMake(self.centerX, self.centerY - self.loadFaildImageView.height/2);
        self.loadFaildImageView.hidden = YES;
        [self addSubview:self.loadFaildImageView];
        
        // empty label
        self.emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (self.bounds.size.height - kIndicatorHeight ) / 2, self.bounds.size.width - 30, kIndicatorHeight)];
        self.emptyLabel.numberOfLines = 1;
        self.emptyLabel.backgroundColor = [UIColor clearColor];
        self.emptyLabel.font = [UIFont systemFontOfSize:13];
        self.emptyLabel.textColor = C_RGB(0xa4a4a4);
        self.emptyLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.emptyLabel];
        
        self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.emptyLabel.bottom, self.bounds.size.width - 30, kIndicatorHeight)];
        self.subTitleLabel.numberOfLines = 1;
        self.subTitleLabel.backgroundColor = [UIColor clearColor];
        self.subTitleLabel.font = [UIFont systemFontOfSize:11];
        self.subTitleLabel.textColor = C_RGB(0xbfbfbf);
        self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.subTitleLabel];
    }
    
    return self;
}

- (void)dealloc
{

}
- (UIControl *)emptyViewTipContainer{

    return nil;
}
- (void)layoutSubviews
{
//    [self.emptyLabel setFrame:CGRectMake(15, self.emptyOffsetTop + (self.bounds.size.height - self.emptyOffsetTop - kIndicatorHeight) / 2, self.bounds.size.width - 30, kIndicatorHeight)];
//    self.loadFaildImageView.centerX = self.centerX;
//    self.loadFaildImageView.y = self.emptyLabel.top - self.loadFaildImageView.height - 10;
//    if (self.loadFaildImageView.top<=0) {
//        self.loadFaildImageView.hidden = YES;
//    }
//    [self.subTitleLabel setY:self.emptyLabel.bottom];
}
#pragma mark - Override HTWRefreshIndicator
// 从HttpTableViewwrapper中回调
//- (void)setState:(RequestStatus)state HTW:(HttpTableViewWrapper*)htw task:(DataTask*)task
//{
//    switch (state) {
//        case REQUEST_ADDED: {
//            [self hide];
//        }
//            break;
//        case REQUEST_START: {
//
//        }
//            break;
//        case REQUEST_SUCCESS: {
//            if (htw && [htw.tableViewModel.modelItemArray count] <= 0) {
//                self.emptyViewState = TGMEmptyViewState_Tips;
////                self.emptyLabel.text = self.emptyText;
////                self.subTitleLabel.text = self.subTitleText;
////                self.loadFaildImageView.hidden = NO;
////                [self.loadFaildImageView setImage:[UIImage imageNamed:@"ic_empty_nosearchresult.png"]];
//                [self onShowEmptyText:htw.tableView];
//            }
//            else {
//                [self hide];
//            }
//        }
//            break;
//        case REQUEST_FAILED: {
//            if (htw && [htw.tableViewModel.modelItemArray count] <= 0) {
//                self.emptyViewStyle = TGMEmptyViewStyle_NoNetwork;
//                self.emptyViewState = TGMEmptyViewState_Tips;
////                self.emptyLabel.text = self.failedText;
////                self.loadFaildImageView.hidden = NO;
////                [self.loadFaildImageView setImage:[UIImage imageNamed:@"ic_empty_nonetwork"]];
//                [self onShowEmptyText:htw.tableView];
//            }
//            else {
//                [self hide];
//            }
//        }
//            break;
//        case REQUEST_CANCEL: {
//            [self hide];
//        }
//            break;
//        default:
//            break;
//    }
//
//    _state = state;
//}
//
//- (RequestStatus) getState
//{
//    return _state;
//}
//
//- (void) hide
//{
//    self.hidden = YES;
//    self.emptyView.state = TGMEmptyViewState_Hidden;
//}
//
//- (void) onShowEmptyText:(UITableView*)tableView
//{
//    if (self.emptyOffsetTop == 0) {
//        self.emptyOffsetTop = tableView.tableHeaderView.height;
//    }
//
//    self.hidden = NO;
//
//    [self setNeedsLayout];
//}

@end
