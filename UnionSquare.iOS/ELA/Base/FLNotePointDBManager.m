//
//  FLNotePointDBManager.m
//  elastos wallet
//
//  Created by 樊晓乐 on 2019/1/28.
//

#import "FLNotePointDBManager.h"


/*
 "ownerpublickey": "0341315fe4e1f26ba09c5c56bf76e1e97aaee992f59407b33c4fc9d42e11634bdc",
 "nodepublickey": "022e2fce0641869a1a8af60f735279a45d2e28dc1d4c54ef7f9872b777d718b624",
 "nickname": "arbiter-223",
 "url": "ela_test.org",
 "location": 112211,
 "active": true,
 "votes": "1858.40299068",
 "netaddress": "127.0.0.1",
 */

static FLNotePointDBManager *manager;
@implementation FLNotePointDBManager
+(instancetype)defult{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString  *dataBaseName=@"friendsss.db";
        NSString *sql;
        path = [path stringByAppendingPathComponent:dataBaseName];
        manager = [FLNotePointDBManager databaseWithPath:path];
        sql =@"create table if not exists NotePoint(nodepublickey text primary key ,ownerpublickey text,nickname text,url text,location text,active text,netaddress text,votes text,indexx text,voterate text)";

        [manager open];
        if ([manager executeUpdate:sql]) {
//            DLog(@"NotePoint 建表完成");
        }else{
//            DLog(@"NotePoint 建表失败");
        }
    });
    
    return manager;
}


//增加

-(BOOL)addRecord:(FLCoinPointInfoModel *)person{

    NSString *sql =[NSString stringWithFormat: @"insert into NotePoint (nodepublickey ,ownerpublickey,nickname ,url ,location ,active ,netaddress ,votes,indexx,voterate) values (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%d,\"%@\",\"%@\",%d,\"%@\");", person.nodepublickey,person.ownerpublickey,person.nickname,person.url,person.location,(int)person.active,person.netaddress,person.votes,(int)person.index,person.voterate];
    if ([manager  executeUpdate:sql]) {
        return YES;
    }else{
        return NO;
    }

}
//查
-(BOOL)hasModel:(FLCoinPointInfoModel*)note{
    NSString *sql =[NSString stringWithFormat: @"select * from NotePoint where ownerpublickey=\'%@\'" ,note.ownerpublickey];
    FMResultSet *set=[manager executeQuery:sql];
    if (set.next) {
        return YES;
    }else{
        return NO;
    }

}

-(NSArray*)allRecord{
    //数组 ， 这个数据用来存放查询结果转换的模型
    NSMutableArray *allRecords=[[NSMutableArray alloc]init];
    NSString *sql =@"select * from NotePoint  order by indexx asc ";
    FMResultSet *set=[self executeQuery:sql];
    //    一条一条的读取数据 并专程模型
    while (set.next) {
        //        模型
        FLCoinPointInfoModel * p= [[FLCoinPointInfoModel alloc]init];
        //        去出表中存放的内容给person赋值
        p.ownerpublickey =[set objectForColumn:@"ownerpublickey"];
        p.nodepublickey  =[set objectForColumn:@"nodepublickey"];
        p.nickname       =[set objectForColumn:@"nickname"];
        p.url            =[set objectForColumn:@"url"];
        p.location       =[set objectForColumn:@"location"];
        p.active         =[[set objectForColumn:@"active"] integerValue];
        p.votes          =[set objectForColumn:@"votes"];
        p.netaddress     =[set objectForColumn:@"netaddress"];
        p.index          = [[set objectForColumn:@"indexx"] integerValue];
        p.voterate       =[set objectForColumn:@"voterate"];

        //        添加到数组中
        [allRecords addObject:p];
    }
    
    return allRecords;
}
//删
-(BOOL)delectRecord:(FLCoinPointInfoModel *)person{
    
    NSString *sql =[NSString stringWithFormat: @"delete from NotePoint where nodepublickey =\'%@\'" ,person.nodepublickey];
    if ([manager executeUpdate:sql]) {
        
        return YES;
//        DLog(@"删除完成!");
    }else{
//        DLog(@"删除失败!");
        return NO;
    }
}
//改
-(BOOL)updateRecord:(FLCoinPointInfoModel *)person{
    BOOL re=YES;
/*    ownerpublickey
    nodepublickey
    nickname
    url
    location
    active
    votes
    netaddresss
  */
    
//    NSString *sql =@"Update NotePoint set  nodepublickey=?  nickname=? url=? location=? active=? votes=? netaddress=? indexx=? voterate=? where ownerpublickey=?";
    NSString *nodepublickey =@"Update NotePoint set nodepublickey=? where ownerpublickey=? ";
    
    NSString *nickname =@"Update NotePoint set nickname=? where ownerpublickey=? ";
    NSString *url =@"Update NotePoint set url=? where ownerpublickey=? ";
    NSString *location =@"Update NotePoint set location=? where ownerpublickey=? ";
    NSString *active =@"Update NotePoint set active=? where ownerpublickey=? ";
    
    NSString *votes =@"Update NotePoint set votes=? where ownerpublickey=? ";
    NSString *netaddress =@"Update NotePoint set netaddress=? where ownerpublickey=? ";
    NSString *indexx =@"Update NotePoint set indexx=? where ownerpublickey=? ";
    NSString *voterate =@"Update NotePoint set voterate=? where ownerpublickey=? ";
    if (person.url.length>0) {
        if ( [self executeQuery:url,person.url,person.ownerpublickey]) {
            
        }else{
            
            re=NO;
        }
       
        
        
    }
    if (person.nodepublickey.length>0) {
        if ( [self executeQuery:nodepublickey,person.nodepublickey,person.ownerpublickey]) {
            
        }else{
            
            re=NO;
        }
        
        
        
    }
    if (person.nickname.length>0) {
        if ([self executeQuery:nickname,person.nickname,person.ownerpublickey]) {
            
        }else{
            
            re=NO;
        }
        
        
        
    }
    if (person.location.length>0) {
        if ([self executeQuery:location,person.location,person.ownerpublickey]) {
            
        }else{
            
            re=NO;
        }
        
        
        
    }
   
    if (person.votes.length>0) {
        if ([self executeQuery:votes,person.votes,person.ownerpublickey]) {
            
        }else{
            
            re=NO;
        }
        
        
        
    }
    if (person.netaddress.length>0) {
        if ([self executeQuery:netaddress,person.netaddress,person.ownerpublickey]) {
            
        }else{
            
            re=NO;
        }
        
    }
    
    if (person.voterate.length>0) {
        if ([self executeQuery:voterate,person.voterate,person.ownerpublickey]) {
            
        }else{
            
            re=NO;
        }
        
        
    }
    
    if ([self executeQuery:indexx,[NSString stringWithFormat:@"%ld",person.index],person.ownerpublickey]&&[self executeQuery:active,[NSString stringWithFormat:@"%ld",person.active],person.ownerpublickey]){

    }else{

        re=NO;
    }
    
    
    return re;
    
   
    
  
}
@end
