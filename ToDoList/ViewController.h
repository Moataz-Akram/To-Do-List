//
//  ViewController.h
//  ToDoList
//
//  Created by Moataz on 05/04/2021.
//

#import <UIKit/UIKit.h>
#import "AddTask.h"
@interface ViewController : UIViewController<UITextFieldDelegate>

@property id <AddTask> addTaskProtocol;
@property int tid;

@end

