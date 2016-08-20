//
//  SelectPhotoViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/19.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "SelectPhotoViewController.h"
#import <Photos/Photos.h>
#import "SelectPhotoCollectionViewCell.h"
#import "PhotoModel.h"
@interface SelectPhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *dataSource;
    UICollectionView *collection;
}
@end

@implementation SelectPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [NSMutableArray array];
    self.images = [NSMutableArray array];
    [self setUI];
    [self getPhoto];
}

- (void)getPhoto{
    PHFetchOptions *fetch = [PHFetchOptions new];
    PHFetchResult *allPhoto = [PHAsset fetchAssetsWithOptions:fetch];
    for (int i = 0; i < allPhoto.count; i++) {
        PHAsset *asset = allPhoto[i];
        PHImageManager *imageManager = [PHImageManager new];
        [imageManager requestImageForAsset:asset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            PhotoModel *p = [PhotoModel new];
            p.image = result;
            p.isSelect = NO;
            [dataSource addObject:p];
            dispatch_async(dispatch_get_main_queue(), ^{
                [collection reloadData];
            });

          
        }];
      
        
    }
   
}

- (void)setUI{
    self.title = @"相机胶卷";
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(100, 100);
    collection = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    collection.delegate = self;
    collection.dataSource = self;
    collection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collection];
    [collection registerNib:[UINib nibWithNibName:@"SelectPhotoCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([SelectPhotoCollectionViewCell class])];
    
    UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishAction)];
    self.navigationItem.rightBarButtonItem = finish;
}

- (void)finishAction{
    self.imagesHandle(self.images);
    [self.navigationController popViewControllerAnimated:YES];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SelectPhotoCollectionViewCell *cell = (SelectPhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"SelectPhotoCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.selectImageView.image = [UIImage imageNamed:@"photo"];
        cell.imagegao.hidden = YES;
        cell.selectPhotoButton.hidden = YES;
        return cell;
    }
    PhotoModel *p = dataSource[indexPath.row];
    cell.selectImageView.image = p.image;
    
    cell.selectPhotoButton.hidden = NO;
    cell.imagegao.hidden = NO;

    if (p.isSelect) {
        cell.imagegao.image = [UIImage imageNamed:@"selected"];

    }else{
        cell.imagegao.image = [UIImage imageNamed:@"unSelected"];
    }
    cell.selectPhotoButton.selected = p.isSelect;
    cell.isSelect = ^(BOOL isSelect){
        if (self.images.count >=9 && isSelect) {
            NSLog(@"九张");
        }else{
            p.isSelect = isSelect;
            if (p.isSelect) {
                [self.images addObject:p];
            }else{
                [self.images removeObject:p];
            }
            [collectionView reloadData];
        }
        
    };
 
     return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataSource.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
