# GitStashRecover
Bash script to recover deleted stash

# How to use
**Before running this, BACK UP TO REMOTE!!! You should not lose bigger ones to save small one.**
1. move to terminal
2. copy stash_recover.sh to your git project
```
cp stash_recover.sh ~/workspace/your_project/
```
3. Grant permission to execute 
```
chmod 775 stash_recover.sh
```
4. Run! It takes some time. Take your patience.
``` 
./stash_recover.sh
```
5. Then it will show you lost stashes!
```
$ ./stash.sh 
Checking object directories: 100% (256/256), done.
Checking objects: 100% (10240/10240), done.
>>>>>>>>> Scan Begin <<<<<<<<<<
   Date: 2019-04-02 (3 days ago)
 Author: funccoder
Message: WIP on release/1.0.0: 26e5314 version up
   Hash: 5147d4d8f45ef5eec04f8e767f03ab8259d3cd52

   Date: 2019-04-05 (0 days ago)
 Author: funccoder
Message: WIP on feature/setting-fix: 170f912 blablabla
   Hash: abcdef1234567890abcdef1234567890abcdef12
>>>>>>>>> Scan End <<<<<<<<<<
```
6. Recover stash commit.
``` 
git reset --hard abcdef1234567890abcdef1234567890abcdef12
```

If you have any problem on here. Tell me anytime!
to my email funccoder@gmail.com
