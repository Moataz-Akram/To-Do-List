//
//  EditTask.h
//  ToDoList
//
//  Created by Moataz on 05/04/2021.
//

#import <Foundation/Foundation.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@protocol EditTask <NSObject>
-(void)editTask : (Task*) task :(int) position;
//-(void)editTask : (Task*) task OldTask:(Task*) task2 :(int) position;

@end

NS_ASSUME_NONNULL_END
