//
//  Utilitarios.h
//  Traveling
//
//  Created by Etica on 20/10/16.
//  Copyright © 2016 Victor Freitas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utilitarios : NSObject



+(void)saveCustomObjectArray:(NSArray *)object chave:(NSString *)key;

+(NSData *)readFromPlistFile:(NSString*)filename;
+(BOOL)writeToPlistFile:(NSString*)filename dados:(NSData *)data;
+(void)alerta:(NSString *)msg;
+(NSString *) converteDataLocalString: (NSDate *) data;
+(NSMutableArray*) myStaticArray;

@end
