//
//  UserDefaults.m
//  ToDoList
//
//  Created by Moataz on 11/05/2021.
//

#import "UserDefaults.h"

@implementation UserDefaults

- (instancetype)init
{
    self = [super init];
    if (self) {
        defaults = [NSUserDefaults standardUserDefaults];
        NSData *readData = [defaults objectForKey:@"tasksArray"];
        tasksArray = [NSKeyedUnarchiver unarchiveObjectWithData:readData];
       if ([tasksArray count]==0) {
            tasksArray = [NSMutableArray new];
        }

    }
    return self;
}

- (NSMutableArray *)loadArrays{
    return tasksArray;
}

- (void)saveArray:(NSMutableArray *)tasks{
    tasksArray = tasks;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tasksArray];
    [defaults setObject:data forKey:@"tasksArray"];
    [defaults synchronize];
}
@end
