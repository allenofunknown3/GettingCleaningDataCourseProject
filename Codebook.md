# Exploratory Data Week 4

Get Feature and Activity Names

```r
features<-read.table('./UCI HAR Dataset/features.txt')
activity<-read.table('./UCI HAR Dataset/activity_labels.txt')
```

Build test Data by filter columns for only mean and std types and attaching activity and subject column data as well

```r
dat_test_x<-read.table('./UCI HAR Dataset/test/X_test.txt')
colnames(dat_test_x)<-features$V2
dat_test_x2<-dat_test_x[,grep('[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]',colnames(dat_test_x))]

dat_test_y<-read.table('./UCI HAR Dataset/test/y_test.txt')
dat_test_y2<-merge(dat_test_y,activity, by.x="V1",by.y="V1")
colnames(dat_test_y2)<-c("act_code","act_name")

dat_test_sub<-read.table('./UCI HAR Dataset/test/subject_test.txt')
colnames(dat_test_sub)<-"subject"

dat_test<-cbind(dat_test_sub,dat_test_y2,dat_test_x2)
```

Build train Data by filter columns for only mean and std types and attaching activity and subject column data as well


```r
dat_train_x<-read.table('./UCI HAR Dataset/train/X_train.txt')
colnames(dat_train_x)<-features$V2
dat_train_x2<-dat_train_x[,grep('[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]',colnames(dat_train_x))]

dat_train_y<-read.table('./UCI HAR Dataset/train/y_train.txt')
dat_train_y2<-merge(dat_train_y,activity, by.x="V1",by.y="V1")
colnames(dat_train_y2)<-c("act_code","act_name")

dat_train_sub<-read.table('./UCI HAR Dataset/train/subject_train.txt')
colnames(dat_train_sub)<-"subject"

dat_train<-cbind(dat_train_sub,dat_train_y2,dat_train_x2)
```

Combine test and train data, make


```r
dat_all<-rbind(dat_train,dat_test)
dat_all$subject<-as.factor(dat_all$subject)
dat_all$act_name<-as.factor(dat_all$act_name)
dat_all$act_code<-as.factor(dat_all$act_code)
head(dat_all,3)
```

```
##   subject act_code act_name tBodyAcc-mean()-X tBodyAcc-mean()-Y
## 1       1        1  WALKING         0.2885845       -0.02029417
## 2       1        1  WALKING         0.2784188       -0.01641057
## 3       1        1  WALKING         0.2796531       -0.01946716
##   tBodyAcc-mean()-Z tBodyAcc-std()-X tBodyAcc-std()-Y tBodyAcc-std()-Z
## 1        -0.1329051       -0.9952786       -0.9831106       -0.9135264
## 2        -0.1235202       -0.9982453       -0.9753002       -0.9603220
## 3        -0.1134617       -0.9953796       -0.9671870       -0.9789440
##   tGravityAcc-mean()-X tGravityAcc-mean()-Y tGravityAcc-mean()-Z
## 1            0.9633961           -0.1408397            0.1153749
## 2            0.9665611           -0.1415513            0.1093788
## 3            0.9668781           -0.1420098            0.1018839
##   tGravityAcc-std()-X tGravityAcc-std()-Y tGravityAcc-std()-Z
## 1          -0.9852497          -0.9817084          -0.8776250
## 2          -0.9974113          -0.9894474          -0.9316387
## 3          -0.9995740          -0.9928658          -0.9929172
##   tBodyAccJerk-mean()-X tBodyAccJerk-mean()-Y tBodyAccJerk-mean()-Z
## 1            0.07799634           0.005000803          -0.067830808
## 2            0.07400671           0.005771104           0.029376633
## 3            0.07363596           0.003104037          -0.009045631
##   tBodyAccJerk-std()-X tBodyAccJerk-std()-Y tBodyAccJerk-std()-Z
## 1           -0.9935191           -0.9883600           -0.9935750
## 2           -0.9955481           -0.9810636           -0.9918457
## 3           -0.9907428           -0.9809556           -0.9896866
##   tBodyGyro-mean()-X tBodyGyro-mean()-Y tBodyGyro-mean()-Z
## 1       -0.006100849        -0.03136479         0.10772540
## 2       -0.016111620        -0.08389378         0.10058429
## 3       -0.031698294        -0.10233542         0.09612688
##   tBodyGyro-std()-X tBodyGyro-std()-Y tBodyGyro-std()-Z
## 1        -0.9853103        -0.9766234        -0.9922053
## 2        -0.9831200        -0.9890458        -0.9891212
## 3        -0.9762921        -0.9935518        -0.9863787
##   tBodyGyroJerk-mean()-X tBodyGyroJerk-mean()-Y tBodyGyroJerk-mean()-Z
## 1             -0.0991674            -0.05551737            -0.06198580
## 2             -0.1105028            -0.04481873            -0.05924282
## 3             -0.1084857            -0.04241031            -0.05582883
##   tBodyGyroJerk-std()-X tBodyGyroJerk-std()-Y tBodyGyroJerk-std()-Z
## 1            -0.9921107            -0.9925193            -0.9920553
## 2            -0.9898726            -0.9972926            -0.9938510
## 3            -0.9884618            -0.9956321            -0.9915318
##   tBodyAccMag-mean() tBodyAccMag-std() tGravityAccMag-mean()
## 1         -0.9594339        -0.9505515            -0.9594339
## 2         -0.9792892        -0.9760571            -0.9792892
## 3         -0.9837031        -0.9880196            -0.9837031
##   tGravityAccMag-std() tBodyAccJerkMag-mean() tBodyAccJerkMag-std()
## 1           -0.9505515             -0.9933059            -0.9943364
## 2           -0.9760571             -0.9912535            -0.9916944
## 3           -0.9880196             -0.9885313            -0.9903969
##   tBodyGyroMag-mean() tBodyGyroMag-std() tBodyGyroJerkMag-mean()
## 1          -0.9689591         -0.9643352              -0.9942478
## 2          -0.9806831         -0.9837542              -0.9951232
## 3          -0.9763171         -0.9860515              -0.9934032
##   tBodyGyroJerkMag-std() fBodyAcc-mean()-X fBodyAcc-mean()-Y
## 1             -0.9913676        -0.9947832        -0.9829841
## 2             -0.9961016        -0.9974507        -0.9768517
## 3             -0.9950910        -0.9935941        -0.9725115
##   fBodyAcc-mean()-Z fBodyAcc-std()-X fBodyAcc-std()-Y fBodyAcc-std()-Z
## 1        -0.9392687       -0.9954217       -0.9831330       -0.9061650
## 2        -0.9735227       -0.9986803       -0.9749298       -0.9554381
## 3        -0.9833040       -0.9963128       -0.9655059       -0.9770493
##   fBodyAcc-meanFreq()-X fBodyAcc-meanFreq()-Y fBodyAcc-meanFreq()-Z
## 1             0.2524829            0.13183575           -0.05205025
## 2             0.2713085            0.04286364           -0.01430976
## 3             0.1245312           -0.06461056            0.08267692
##   fBodyAccJerk-mean()-X fBodyAccJerk-mean()-Y fBodyAccJerk-mean()-Z
## 1            -0.9923325            -0.9871699            -0.9896961
## 2            -0.9950322            -0.9813115            -0.9897398
## 3            -0.9909937            -0.9816423            -0.9875663
##   fBodyAccJerk-std()-X fBodyAccJerk-std()-Y fBodyAccJerk-std()-Z
## 1           -0.9958207           -0.9909363           -0.9970517
## 2           -0.9966523           -0.9820839           -0.9926268
## 3           -0.9912488           -0.9814148           -0.9904159
##   fBodyAccJerk-meanFreq()-X fBodyAccJerk-meanFreq()-Y
## 1                 0.8703845                0.21069700
## 2                 0.6085135               -0.05367561
## 3                 0.1154340               -0.19343634
##   fBodyAccJerk-meanFreq()-Z fBodyGyro-mean()-X fBodyGyro-mean()-Y
## 1                0.26370789         -0.9865744         -0.9817615
## 2                0.06314827         -0.9773867         -0.9925300
## 3                0.03825433         -0.9754332         -0.9937147
##   fBodyGyro-mean()-Z fBodyGyro-std()-X fBodyGyro-std()-Y fBodyGyro-std()-Z
## 1         -0.9895148        -0.9850326        -0.9738861        -0.9940349
## 2         -0.9896058        -0.9849043        -0.9871681        -0.9897847
## 3         -0.9867557        -0.9766422        -0.9933990        -0.9873282
##   fBodyGyro-meanFreq()-X fBodyGyro-meanFreq()-Y fBodyGyro-meanFreq()-Z
## 1            -0.25754888             0.09794711             0.54715105
## 2            -0.04816744            -0.40160791            -0.06817833
## 3            -0.21668507            -0.01726417            -0.11072029
##   fBodyAccMag-mean() fBodyAccMag-std() fBodyAccMag-meanFreq()
## 1         -0.9521547        -0.9561340            -0.08843612
## 2         -0.9808566        -0.9758658            -0.04414989
## 3         -0.9877948        -0.9890155             0.25789914
##   fBodyBodyAccJerkMag-mean() fBodyBodyAccJerkMag-std()
## 1                 -0.9937257                -0.9937550
## 2                 -0.9903355                -0.9919603
## 3                 -0.9892801                -0.9908667
##   fBodyBodyAccJerkMag-meanFreq() fBodyBodyGyroMag-mean()
## 1                      0.3469885              -0.9801349
## 2                      0.5320605              -0.9882956
## 3                      0.6607950              -0.9892548
##   fBodyBodyGyroMag-std() fBodyBodyGyroMag-meanFreq()
## 1             -0.9613094                  -0.1289889
## 2             -0.9833219                  -0.2719585
## 3             -0.9860277                  -0.2127279
##   fBodyBodyGyroJerkMag-mean() fBodyBodyGyroJerkMag-std()
## 1                  -0.9919904                 -0.9906975
## 2                  -0.9958539                 -0.9963995
## 3                  -0.9950305                 -0.9951274
##   fBodyBodyGyroJerkMag-meanFreq() angle(tBodyAccMean,gravity)
## 1                     -0.07432303                 -0.11275434
## 2                      0.15807454                  0.05347695
## 3                      0.41450281                 -0.11855926
##   angle(tBodyAccJerkMean),gravityMean) angle(tBodyGyroMean,gravityMean)
## 1                          0.030400372                       -0.4647614
## 2                         -0.007434566                       -0.7326262
## 3                          0.177899480                        0.1006992
##   angle(tBodyGyroJerkMean,gravityMean) angle(X,gravityMean)
## 1                          -0.01844588           -0.8412468
## 2                           0.70351059           -0.8447876
## 3                           0.80852908           -0.8489335
##   angle(Y,gravityMean) angle(Z,gravityMean)
## 1            0.1799406          -0.05862692
## 2            0.1802889          -0.05431672
## 3            0.1806373          -0.04911782
```

Create tidy dataset according to Coursera's specifications: Avg by subject and activity name


```r
tidy_data<-aggregate(dat_all,by=list(dat_all$subject,dat_all$act_name),FUN="mean",na.rm=TRUE)
```

```
## Warning in mean.default(X[[1L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[2L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[3L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[4L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[5L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[6L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[7L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[8L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[9L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[10L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[11L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[12L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[13L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[14L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[15L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[16L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[17L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[18L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[19L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[20L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[21L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[22L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[23L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[24L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[25L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[26L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[27L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[28L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[29L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[30L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[31L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[32L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[33L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[34L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[35L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[36L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[37L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[38L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[39L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[40L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[1L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[2L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[3L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[4L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[5L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[6L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[7L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[8L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[9L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[10L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[11L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[12L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[13L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[14L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[15L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[16L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[17L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[18L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[19L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[20L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[21L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[22L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[23L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[24L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[25L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[26L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[27L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[28L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[29L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[30L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[31L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[32L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[33L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[34L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[35L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[36L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[37L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[38L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[39L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[40L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[1L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[2L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[3L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[4L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[5L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[6L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[7L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[8L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[9L]], ...): argument is not numeric or logical:
## returning NA
```

```
## Warning in mean.default(X[[10L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[11L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[12L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[13L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[14L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[15L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[16L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[17L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[18L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[19L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[20L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[21L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[22L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[23L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[24L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[25L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[26L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[27L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[28L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[29L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[30L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[31L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[32L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[33L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[34L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[35L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[36L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[37L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[38L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[39L]], ...): argument is not numeric or
## logical: returning NA
```

```
## Warning in mean.default(X[[40L]], ...): argument is not numeric or
## logical: returning NA
```

```r
tidy_data<-within(tidy_data, rm(subject, act_code, act_name))
tidy_data<-tidy_data[order(tidy_data$Group.1),] 
head(tidy_data,3)
```

```
##    Group.1 Group.2 tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
## 21       1 WALKING         0.2656969       -0.01829817        -0.1078457
## 22       2 WALKING         0.2731131       -0.01913232        -0.1156500
## 23       3 WALKING         0.2734287       -0.01785607        -0.1064926
##    tBodyAcc-std()-X tBodyAcc-std()-Y tBodyAcc-std()-Z tGravityAcc-mean()-X
## 21       -0.5457953       -0.3677162       -0.5026457            0.7448674
## 22       -0.6055865       -0.4289630       -0.5893601            0.6607829
## 23       -0.6234136       -0.4800159       -0.6536256            0.7078144
##    tGravityAcc-mean()-Y tGravityAcc-mean()-Z tGravityAcc-std()-X
## 21          -0.08255626           0.07233987          -0.9598594
## 22          -0.14721989           0.13486534          -0.9630155
## 23          -0.02605905           0.04809379          -0.9664576
##    tGravityAcc-std()-Y tGravityAcc-std()-Z tBodyAccJerk-mean()-X
## 21          -0.9511506          -0.9258176            0.07709305
## 22          -0.9600336          -0.9453654            0.07853532
## 23          -0.9445645          -0.9269663            0.07017313
##    tBodyAccJerk-mean()-Y tBodyAccJerk-mean()-Z tBodyAccJerk-std()-X
## 21           0.016590844         -0.0091075873           -0.5247219
## 22           0.007087712          0.0007557607           -0.5578096
## 23           0.014466433         -0.0005268189           -0.6354847
##    tBodyAccJerk-std()-Y tBodyAccJerk-std()-Z tBodyGyro-mean()-X
## 21           -0.4704124           -0.7173223        -0.02087641
## 22           -0.4918759           -0.7418854        -0.05170307
## 23           -0.5572119           -0.7960662        -0.02484907
##    tBodyGyro-mean()-Y tBodyGyro-mean()-Z tBodyGyro-std()-X
## 21        -0.08807227         0.08626417        -0.6865557
## 22        -0.05684202         0.08725994        -0.7106489
## 23        -0.07435653         0.08668755        -0.6992622
##    tBodyGyro-std()-Y tBodyGyro-std()-Z tBodyGyroJerk-mean()-X
## 21        -0.4509798        -0.5974961            -0.09711202
## 22        -0.7229437        -0.6348889            -0.08755875
## 23        -0.7630222        -0.7094834            -0.09915546
##    tBodyGyroJerk-mean()-Y tBodyGyroJerk-mean()-Z tBodyGyroJerk-std()-X
## 21            -0.04171648            -0.04713940            -0.6378127
## 22            -0.04339868            -0.05575418            -0.6716791
## 23            -0.04019239            -0.05211783            -0.6893284
##    tBodyGyroJerk-std()-Y tBodyGyroJerk-std()-Z tBodyAccMag-mean()
## 21            -0.6344722            -0.6645920         -0.4536329
## 22            -0.7835955            -0.6746119         -0.5352818
## 23            -0.8426599            -0.7430285         -0.5631408
##    tBodyAccMag-std() tGravityAccMag-mean() tGravityAccMag-std()
## 21        -0.4970964            -0.4536329           -0.4970964
## 22        -0.5528125            -0.5352818           -0.5528125
## 23        -0.5912248            -0.5631408           -0.5912248
##    tBodyAccJerkMag-mean() tBodyAccJerkMag-std() tBodyGyroMag-mean()
## 21             -0.5454316            -0.5159222          -0.4754048
## 22             -0.5877774            -0.5121153          -0.6147711
## 23             -0.6501824            -0.6076582          -0.6431501
##    tBodyGyroMag-std() tBodyGyroJerkMag-mean() tBodyGyroJerkMag-std()
## 21         -0.4998396              -0.6395174             -0.6520508
## 22         -0.6805849              -0.7465595             -0.7400887
## 23         -0.6740103              -0.7840567             -0.8036614
##    fBodyAcc-mean()-X fBodyAcc-mean()-Y fBodyAcc-mean()-Z fBodyAcc-std()-X
## 21        -0.5318952        -0.4064354        -0.5964112       -0.5530606
## 22        -0.5737709        -0.4325666        -0.6300812       -0.6197881
## 23        -0.6257333        -0.5017799        -0.6996568       -0.6238050
##    fBodyAcc-std()-Y fBodyAcc-std()-Z fBodyAcc-meanFreq()-X
## 21       -0.3901509       -0.4985831            -0.1805587
## 22       -0.4647239       -0.6006786            -0.1067634
## 23       -0.5027536       -0.6574438            -0.1928173
##    fBodyAcc-meanFreq()-Y fBodyAcc-meanFreq()-Z fBodyAccJerk-mean()-X
## 21            0.05762916           0.058369278            -0.5473489
## 22            0.10573418           0.087210586            -0.5616820
## 23            0.03892825           0.004472614            -0.6458935
##    fBodyAccJerk-mean()-Y fBodyAccJerk-mean()-Z fBodyAccJerk-std()-X
## 21            -0.5073436            -0.6953051           -0.5439798
## 22            -0.5089038            -0.7157453           -0.5951056
## 23            -0.5829499            -0.7801016           -0.6578441
##    fBodyAccJerk-std()-Y fBodyAccJerk-std()-Z fBodyAccJerk-meanFreq()-X
## 21           -0.4662517           -0.7378619               -0.04880060
## 22           -0.5091475           -0.7670870                0.08680005
## 23           -0.5598512           -0.8108060               -0.04769412
##    fBodyAccJerk-meanFreq()-Y fBodyAccJerk-meanFreq()-Z fBodyGyro-mean()-X
## 21                -0.2152792               -0.09644964         -0.6232192
## 22                -0.1397766               -0.09426519         -0.6387177
## 23                -0.2368742               -0.19365754         -0.6420977
##    fBodyGyro-mean()-Y fBodyGyro-mean()-Z fBodyGyro-std()-X
## 21         -0.5053094         -0.5535291        -0.7082634
## 22         -0.7220690         -0.6015949        -0.7345885
## 23         -0.7751450         -0.6707347        -0.7192766
##    fBodyGyro-std()-Y fBodyGyro-std()-Z fBodyGyro-meanFreq()-X
## 21        -0.4298258        -0.6504762           -0.032032410
## 22        -0.7271677        -0.6831145           -0.005765006
## 23        -0.7585053        -0.7510089           -0.102568068
##    fBodyGyro-meanFreq()-Y fBodyGyro-meanFreq()-Z fBodyAccMag-mean()
## 21            -0.09015172            -0.01800639         -0.4784485
## 22            -0.07021550             0.05136273         -0.5145699
## 23            -0.16767503            -0.03218627         -0.5790765
##    fBodyAccMag-std() fBodyAccMag-meanFreq() fBodyBodyAccJerkMag-mean()
## 21        -0.5897102             0.14206216                 -0.4990758
## 22        -0.6466623             0.19219974                 -0.5097464
## 23        -0.6630798             0.07706656                 -0.6047521
##    fBodyBodyAccJerkMag-std() fBodyBodyAccJerkMag-meanFreq()
## 21                -0.5418231                      0.2000552
## 22                -0.5188008                      0.1930668
## 23                -0.6156437                      0.1123198
##    fBodyBodyGyroMag-mean() fBodyBodyGyroMag-std()
## 21              -0.5350028             -0.5665767
## 22              -0.6997429             -0.7253103
## 23              -0.7168221             -0.7038394
##    fBodyBodyGyroMag-meanFreq() fBodyBodyGyroJerkMag-mean()
## 21                  0.06493094                  -0.6459707
## 22                  0.04713248                  -0.7516151
## 23                 -0.08460752                  -0.8100855
##    fBodyBodyGyroJerkMag-std() fBodyBodyGyroJerkMag-meanFreq()
## 21                 -0.6858113                      0.19803158
## 22                 -0.7441950                      0.12461207
## 23                 -0.8100327                      0.05996287
##    angle(tBodyAccMean,gravity) angle(tBodyAccJerkMean),gravityMean)
## 21                 0.037607706                          0.009018109
## 22                 0.009871767                          0.014044576
## 23                 0.014094389                          0.013450019
##    angle(tBodyGyroMean,gravityMean) angle(tBodyGyroJerkMean,gravityMean)
## 21                      -0.01345095                         -0.001630354
## 22                       0.07458505                         -0.037292798
## 23                       0.03590083                         -0.019207475
##    angle(X,gravityMean) angle(Y,gravityMean) angle(Z,gravityMean)
## 21           -0.5357738           0.12279025          -0.03907902
## 22           -0.4344867           0.17228684          -0.07886546
## 23           -0.5033234           0.07562628          -0.01749015
```
