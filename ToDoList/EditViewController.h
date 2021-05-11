//
//  EditViewController.h
//  ToDoList
//
//  Created by Moataz on 05/04/2021.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "EditTask.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditViewController : UIViewController
@property id <EditTask> editTaskProtocol;

@property Task *task;
@property Task *oldTask;
@property int objectNumber;
@end

NS_ASSUME_NONNULL_END
