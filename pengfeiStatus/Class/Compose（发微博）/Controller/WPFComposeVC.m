//
//  WPFComposeVC.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/7.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFComposeVC.h"
#import "WPFComposeTItle.h"
#import "WPFComposeTextView.h"
#import "WPFComposeTabBar.h"
#import "WPFComposePhotoView.h"
#import "WPFSendRequset.h"
#import "WPFAccount.h"
#import "WPFHttpTool.h"
#import "MBProgressHUD+MJ.h"
#import "WPFEmotionKeyboard.h"
#import "WPFEmotion.h"
#import "WPFEmotionView.h"

@interface WPFComposeVC ()<UITextViewDelegate,WPFComposeTabBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, weak) WPFComposeTextView *textView;
@property (nonatomic, weak) WPFComposePhotoView *photoView;
@property (nonatomic, weak) WPFComposeTabBar *tabBar;
@property (nonatomic, strong) WPFEmotionKeyboard *keyboard;
//@property (nonatomic, assign) BOOL isChangeKeyboard;
@end


@implementation WPFComposeVC


- (WPFEmotionKeyboard *)keyboard
{
    if (!_keyboard) {
        _keyboard = [[WPFEmotionKeyboard alloc] init];
        _keyboard.width = SCREEN_WIDTH;
        _keyboard.height = 216;
    }
    return _keyboard;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupBarButtonItem];
    
    [self setupTextView];
    
    [self setupTabBar];
    
    [self setupPhotoView];
    
    // 将图片写入相册
//    for (int i = 0; i < 3; ++i) {
//        NSString *name = [NSString stringWithFormat:@"%d",i +1];
//        UIImage *image = [UIImage imageNamed:name];
////        [UIImagePNGRepresentation(image) writeToFile:<#(NSString *)#> atomically:YES]
//        UIImageWriteToSavedPhotosAlbum([UIImage imageNamed:name], nil, nil, nil);
//    }
   

}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 键盘弹出  和消失
- (void)KeyboardDidShow:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.tabBar.transform = CGAffineTransformMakeTranslation(0,  -rect.size.height);
    }];
   
}
- (void)KeyboardDidHide:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.tabBar.transform = CGAffineTransformIdentity;
    }];

}

#pragma mark - 添加控件
- (void)setupTabBar
{
    WPFComposeTabBar *tabBar = [[WPFComposeTabBar alloc] init];
    tabBar.delegate = self;
    tabBar.width = self.view.width;
    tabBar.height = 44;
    tabBar.x = 0;
    tabBar.y = self.view.height - tabBar.height;
    //tabBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:tabBar];
    self.tabBar = tabBar;
}
- (void)setupTextView
{
    WPFComposeTextView *textView = [[WPFComposeTextView alloc] init];
    textView.delegate = self;
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:18.0];
    // 让textview能拖动 
    textView.alwaysBounceVertical = YES;
    [self.view addSubview:textView];
    self.textView = textView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteTextView:) name:DELETE_EMOTIONVIEW_NOTIFICATION object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectEmoionView:) name:SELECT_EMOTIONVIEW_NOTIFICATION object:nil];
}

- (void)selectEmoionView:(NSNotification *)note
{
    WPFEmotion *emotion = [note.userInfo[SELECT_EMOTIONVIEW] emotion];
    
    [self.textView appendEmotion:emotion];
    [self textViewDidChange:self.textView];
}
- (void)deleteTextView:(NSNotificationCenter *)note
{
    [self.textView deleteBackward];
    
}
- (void)setupBarButtonItem
{
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendStatus)];
    // 连着一起设置
    rightBarItem.enabled = NO;
    [rightBarItem setBackgroundImage:[UIImage imageNamed:@"tabbar_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
    self.navigationItem.rightBarButtonItem = rightBarItem;
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    self.navigationItem.titleView = [[WPFComposeTItle alloc] init];
    
}

- (void)setupPhotoView
{
    WPFComposePhotoView *photoView = [[WPFComposePhotoView alloc] init];
    CGFloat x = 0;
    CGFloat y = 100;
    CGFloat w = self.view.width;
    CGFloat h = self.view.height - y;
    photoView.frame = CGRectMake(x, y, w, h);
    [self.textView addSubview:photoView];
    self.photoView = photoView;
    
}

#pragma mark - 点击导航栏图标
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendStatus
{
    if (self.photoView.images.count) {
        [self sendMessageWithImage];
    }else{
        [self sendMessageWithoutImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendMessageWithImage
{
    
//    WPFSendRequset *params = [[WPFSendRequset alloc] init];
//    params.access_token = [WPFAccount account].access_token;
//    params.status = self.textView.text.length ? self.textView.text : @"分享图片";
    
}
- (void)sendMessageWithoutImage
{
    WPFSendRequset *params = [[WPFSendRequset alloc] init];
    params.access_token = [WPFAccount account].access_token;
    params.status = self.textView.realString;
    
    [WPFHttpTool post:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id responsObj) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        WPFLog(@"WPFSendRequset");
    }];
}
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.textView resignFirstResponder];
}

#pragma mark - WPFComposeTabBarDelegate
- (void)composeTabBar:(WPFComposeTabBar *)composeTabBar onClick:(WPFComposeToolbarButtonType)type
{
    switch (type) {
        case WPFComposeToolbarButtonTypeCamera:
        {
        
        }
            break;
        case WPFComposeToolbarButtonTypeEmotion:
        {
            [self openEmotion];
        }
            break;
        case WPFComposeToolbarButtonTypeMention:
        {
            
        }
            break;
        case WPFComposeToolbarButtonTypePicture:
        {
            [self openPicture];
        }
            break;
        case WPFComposeToolbarButtonTypeTrend:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)openEmotion
{
    if (nil == self.textView.inputView) {
        self.textView.inputView = self.keyboard;
    }else{
        self.textView.inputView = nil;
    }
    
    [self.textView resignFirstResponder];
    
    [self.textView becomeFirstResponder];
}
- (void)openPicture
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *pick = [[UIImagePickerController alloc] init];
        pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pick.delegate = self;
        [self presentViewController:pick animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photoView addImage:image];
}
- (void)viewDidAppear:(BOOL)animated
{
    [self.textView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.textView resignFirstResponder];
}
@end
