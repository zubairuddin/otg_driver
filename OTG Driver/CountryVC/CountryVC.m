//
//  CountryVC.m
//  OTG Driver
//
//  Created by Amit Prajapati on 19/03/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

#import "CountryVC.h"
#import "CountryCell.h"

@interface CountryVC (){
    NSArray *arrCountries;
}

@end

@implementation CountryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self doSomethingWithTheJson];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doSomethingWithTheJson
{
    NSDictionary *dictCountries = [self JSONFromFile];
    
    NSDictionary *data = [dictCountries objectForKey:@"Data"];
    arrCountries = [data objectForKey:@"list"];
    
    for (NSDictionary *country in arrCountries) {
        NSString *name = [country objectForKey:@"Name"];
        NSLog(@"country name: %@", name);
    }
    
    [self.tblCountryList reloadData];
}

- (NSDictionary *)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"countries" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
- (IBAction)btnCloseView:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrCountries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CountryCell";
    CountryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSDictionary *country = [arrCountries objectAtIndex:indexPath.row];
    cell.lblCountryName.text = [country valueForKey:@"Name"];
    cell.lblCountryCode.text = [NSString stringWithFormat:@"+%@", [country valueForKey:@"Phonecode"]];
    NSString *strImgName = [[country valueForKey:@"ISO"] lowercaseString];
    cell.imgCountryLogo.image = [UIImage imageNamed:strImgName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *country = [arrCountries objectAtIndex:indexPath.row];
    NSString *strImgName = [[country valueForKey:@"ISO"] lowercaseString];
    [self.delegate selectedCountry:[NSString stringWithFormat:@"%@",[country valueForKey:@"Phonecode"]] imageName:strImgName];
    [self dismissViewControllerAnimated:true completion:^{
    }];
}

@end
