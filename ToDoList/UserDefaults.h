//
//  UserDefaults.h
//  ToDoList
//
//  Created by Moataz on 11/05/2021.
//

#import <Foundation/Foundation.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserDefaults : NSObject{
    NSMutableArray<Task*> *tasksArray;
    NSUserDefaults *defaults;
}
-(NSMutableArray*)loadArrays;
-(void)updateArray:(NSMutableArray*) tasks;
@end

NS_ASSUME_NONNULL_END
