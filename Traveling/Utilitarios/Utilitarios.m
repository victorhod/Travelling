//
//  Utilitarios.m
//  Traveling
//
//  Created by Etica on 20/10/16.
//  Copyright © 2016 Victor Freitas. All rights reserved.
//

#import "Utilitarios.h"

@implementation Utilitarios


+ (void)saveCustomObjectArray:(NSArray *)object chave:(NSString *)key {
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
    
}

+(NSData *)readFromPlistFile:(NSString*)filename{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:filename];
    NSData * data = [NSData dataWithContentsOfFile:path];
    return  data;
}

+(BOOL)writeToPlistFile:(NSString*)filename dados:(NSData *)data{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:filename];
    BOOL didWriteSuccessfull = [data writeToFile:path atomically:YES];
    return didWriteSuccessfull;
}

+(void)alerta:(NSString *)msg{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alerta" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];
}

+ (NSString *) converteDataLocalString: (NSDate *) data{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *orignalDate  =  [dateFormatter stringFromDate: data];
    
    return orignalDate;
}

+(NSMutableArray*) myStaticArray
{
    static NSMutableArray* theArray = nil;
    @synchronized([Utilitarios class])
    {
        if (theArray == nil)
        {
            theArray = [[NSMutableArray alloc] init];
        }
    }    return theArray;
}

@end
