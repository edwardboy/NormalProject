//
//  ViewController.m
//  NormalProject
//
//  Created by gyh on 2019/3/21.
//  Copyright © 2019 gyh. All rights reserved.
//

#import "ViewController.h"

#import "AMParam.h"
#import "AMContainer.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()

@property (nonatomic,strong) AMContainer *container;

@property (nonatomic,strong) UITextField *userNameTxf;
@property (nonatomic,strong) UITextField *passwordTxf;

@property (nonatomic,strong) UIButton *loginBtn;

@property (nonatomic,strong) RACSubject *loginSuccessSubject;

@end

@implementation ViewController

/** 登录成功回调*/
- (RACSubject *)loginSuccessSubject{
    if (!_loginSuccessSubject) {
        _loginSuccessSubject = [[RACSubject alloc] init];
        [_loginSuccessSubject subscribeNext:^(NSDictionary *userInfo) {
            NSLog(@"登录成功：%@",userInfo);
        }];
    }
    return _loginSuccessSubject;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testAMContainer];
    
    [self testReactiveObjc];
}


/**
 2、usage of ReactiveObjc
 */
- (void)testReactiveObjc{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 40.f;
    CGFloat margin = 30;
    
    self.userNameTxf = [[UITextField alloc] init];
    self.userNameTxf.borderStyle = UITextBorderStyleRoundedRect;
    self.userNameTxf.placeholder = @"UserName";
    self.userNameTxf.frame = CGRectMake(margin, margin, width - margin*2, height);
    [self.view addSubview:self.userNameTxf];
    
    self.passwordTxf = [[UITextField alloc] init];
    self.passwordTxf.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTxf.placeholder = @"Password";
    self.passwordTxf.frame = CGRectMake(margin, margin+(margin+height), width - margin*2, height);
    [self.view addSubview:self.passwordTxf];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(margin, margin+(margin+height)*2, width - margin*2, height);
    [self.loginBtn setBackgroundColor:[UIColor orangeColor]];
    [self.loginBtn setTitle:@"Click" forState:UIControlStateNormal];
    [self.view addSubview:self.loginBtn];
    
    [self.loginBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    /** 一、按钮事件监听 */
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(id  _Nullable x) {
        NSLog(@"TouchDown开始点击：%@",x);
    }];
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id  _Nullable x) {
        NSLog(@"UpInside结束点击：%@",x);
    }];
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchCancel] subscribeNext:^(id  _Nullable x) {
        NSLog(@"Cancel：%@",x);
    }];
    
    
    /** 二、监听loginBtn的状态 */
    // 1、
    RAC(self.loginBtn,enabled) = [RACSignal combineLatest:@[self.userNameTxf.rac_textSignal,self.passwordTxf.rac_textSignal] reduce:^id _Nullable(NSString *userName,NSString *pwd){
        
        BOOL isEnabled = userName.length && pwd.length;
        self.loginBtn.backgroundColor = isEnabled? [UIColor orangeColor]:[UIColor lightGrayColor];
        
        return @(isEnabled);
    }];
    
    // 2、KVO
    [RACObserve(self.loginBtn, enabled) subscribeNext:^(id  _Nullable x) {
        [x boolValue]?NSLog(@"enable to click"):NSLog(@"not enable to click");
    }];
    
    
    /** 三、监听container销毁 */
//    自定义RACSubject代替登录回调
    
    
    /** 四、监听container销毁 */
    [[self.container rac_willDeallocSignal] subscribeCompleted:^{
        NSLog(@"dealloc 完成");
    }];
    _container = nil;
    
    
    /** 五、Notification */
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable notification) {
        NSLog(@"notification:%@",notification.userInfo);
    }];
    
    
    /** 六、监听方法调用 */
    [[self rac_signalForSelector:@selector(touchesBegan:withEvent:)] subscribeNext:^(id  _Nullable x) {
        
//        x 为监听方法的参数
        if ([x isKindOfClass:[RACTuple class]]) {
            NSLog(@"tuple:%@",[(RACTuple *)x allObjects]);
        }
    }];
    
    
    /** 七、处理多个请求 */
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"send request 1"];
        });
        return nil;
    }];
    
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"send request 2"];
        return nil;
    }];
    
    [self rac_liftSelector:@selector(dealWithSthAfterRequestsFinishedObj1:obj2:) withSignalsFromArray:@[request1,request2]];
    
    
    
    /*
     介绍：
     1、RACEvent上面提到，响应式编程可以将变化的值通过数据流进行传播。为此，RAC中定义了一个事件的概念，即：`RACEvent`。事件分三种类型：Next类型，Completed类型和Error类型。其中Next类型和Error类型事件内部可以承载数据，而Completed类型并不。
     
     2、
     
     */
}

- (void)dealWithSthAfterRequestsFinishedObj1:(id)obj1  obj2:(id)obj2{
    NSLog(@"obj1:%@,obj2:%@",obj1,obj2);
}

- (void)click:(UIButton *)sender{
    NSLog(@"click outside");
    
    
    [self.loginSuccessSubject sendNext:@{@"username":@"Jack",@"pwd":@"123"}];
}


/**
 1、custom AMContainer
 */
- (void)testAMContainer{
    AMContainer *container = [[AMContainer alloc] init];
    self.container = container;
    container[@"a"] = @"abc";
    container[1] = @333;
    
    NSLog(@"container:%@",container);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:true];
}

@end
