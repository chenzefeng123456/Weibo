//
//  ViewController.m
//  多线程
//
//  Created by 3014 on 16/8/17.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "ViewController.h"
#import "myOperation.h"
@interface ViewController ()
{
    NSInteger balance;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     程序运行就会执行一个主线程,叫做main线程,也叫UI线程(因为设置UI的东西需要在此线程完成)
     iOS多线程实现的三种方式:
        方式1.NSTHread,他是三种方式中最轻量级的,但是使用起来很复杂,需要自己管理thread的生命周期,线程之间的同步,线程共享同一个应用程序的部分内存空间,他们拥有对数据相同的访问权限,需要协调多个线程对同一个数据的访问,一般做法就是加锁,OC语言实现
        方式2.NSOperation,OC语言实现,类NSOperation一个面向对象的方式封装用户需要执行的操作,我们只需要关注我们要完成的事情,而不必太担心线程的管理,同步等事情,因为NSOperation为我们分装了这些功能,  NSOperation是一个抽象的基类,我们必须使用它的子类.
        方式3.GCD,他提供了一些新特性,以及运行库来支持多核运算,他是NSOperation的基础,C语言的方式
     
     */
    //一个NSThread对象控制一个线程,当需要OC的方法,放到独立的线程中运行的时候就可以使用这个类了,多线程使用于需要执行一个长时间的任务,却不想阻塞其他操作的时候.
    //创建NSthread对象
    //创建方式1
    NSLog(@"thread = %@",[NSThread currentThread]);
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(work) object:nil];
    [thread1 start];
    NSLog(@"thread = %@",[NSThread currentThread]);
    [self work];
    
    //方式2.该方式会立刻执行线程内容
    [NSThread detachNewThreadSelector:@selector(work) toTarget:self withObject:nil];
    //类似方式3
    [self performSelectorInBackground:@selector(work) withObject:nil];
    balance = 20000;
}

- (void)fetchMoneyWithName:(NSString *)who{
    @synchronized (self) {
        NSLog(@"%@取钱,,取钱之前的余额为%ld",who,balance);

        if (balance >= 15000) {
            //线程睡眠0.2秒
            [NSThread sleepForTimeInterval:0.2];
            balance -= 15000;
            NSLog(@"%@取钱后剩余%ld元",who,balance);

        }else{
            NSLog(@"%@取不出钱了",who);
        }
        
    }
    
}
- (IBAction)fireAction:(id)sender {
    myOperation *operation1 = [myOperation new];
    operation1.vc = self;
     myOperation *operation2 = [myOperation new];
    operation2.vc = self;
     myOperation *operation3 = [myOperation new];
    operation3.vc = self;
    NSOperationQueue *queue = [NSOperationQueue new];
    //队列的最大并发数,当为1时就是串行,需要放到添加操作之前,3就是并行
    queue.maxConcurrentOperationCount = 1;
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    //当operation1执行完后再执行operation2
    [operation2 addDependency:operation1];
    //设置优先级
    operation1.queuePriority = NSOperationQueuePriorityVeryHigh;
    //取消一个操作
    [operation3 cancel];
}
- (IBAction)fetchMoney:(id)sender {
    NSThread *man = [[NSThread alloc] initWithTarget:self selector:@selector(fetchMoneyWithName:) object:@"男人"];
    NSThread *women = [[NSThread alloc] initWithTarget:self selector:@selector(fetchMoneyWithName:) object:@"女人"];
    [man start];
    [women start];
}

- (void)work{
    NSLog(@"thread = %@",[NSThread currentThread]);

    NSLog(@"我有个密码想跟 你分享");
//    //线程之间的通信
//    //回到主线程完成某项工作
//    [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:YES];
//    //在指定线程中完成某项工作
//    [self performSelector:@selector(updateUI) onThread:[NSThread new] withObject:nil waitUntilDone:YES];
//    //在当前线程中等待多少秒后完成某项工作
//    [self performSelector:@selector(updateUI) withObject:nil afterDelay:2];
}
- (void)updateUI{
    NSLog(@"我在更新UI");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
