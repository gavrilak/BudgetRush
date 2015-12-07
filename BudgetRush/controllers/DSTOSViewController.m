//
//  DSTOSViewController.m
//  BudgetRush
//
//  Created by Lena on 24.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSTOSViewController.h"

@interface DSTOSViewController () {

   __weak IBOutlet UILabel *_titleLabel;
   __weak IBOutlet UITextView *_tosTextView;

}

@end

#warning TODO: TOS тексты лучше вынести в отдельные файлы (txt, plist, json.....)

@implementation DSTOSViewController

- (void)viewDidLoad {
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [super viewDidLoad];
    if (self.showTOS) {
        self.navigationItem.title = NSLocalizedString(@"Terms of Service",nil);
        _titleLabel.text = @"The Big Wallet Terms of Service and Cookies Use";
        _tosTextView.text = @"A Terms of Service Agreement is a set of regulations which users must agree to follow in order to use a service. Terms of Use is often named Terms of Service and sometimes Terms and Conditions, as well as Disclaimer, mostly when addressing website usage. These terms cover a wide array of issues, such as the following examples: copyright notices, marketing policies of the respective company, what is the meaning of acceptable user behavior while online etc. Based on the Terms of Service agreement companies can decide to restrict or even terminate users’ access to their services in case they violate the terms in the contract. Just from the descriptions above, you should have by now a well shaped idea about why having this type of document set in place for your online business is important ";
        
    } else {
        self.navigationItem.title = NSLocalizedString(@"Privacy Policy",nil);
        _titleLabel.text = @"The Big Wallet Privacy Policy";
        _tosTextView.text = @"This page is designed to help businesses, especially BBB Accredited Businesses, create an online privacy policy for use on the Internet. When a business is conducting e-commerce or collecting sensitive data online, the BBB Code of Business Practices (BBB Accreditation Standards) requires that BBB Accredited Businesses have some sort of privacy policy on their website. To meet BBB accreditation standards, privacy policies must be based on the following five elements:\n • Policy (what personal information is being collected on the site) \n • Choice (what options the customer has about how/whether her data is collected and used)\n • Access (how a customer can see what data has been collected and change/correct it if necessary) \n • Security (state how any data that is collected is stored/protected)\n • Redress (what customer can do if privacy policy is not met) \n • Updates (how policy changes will be communicated)  This webpage will attempt to give some resources to use in developing your privacy policy. Whatever final policy you develop is up to you, and will be your responsibility to maintain. The Better Business Bureau does not recommend any one set of privacy practices, nor any single privacy policy. Your business bears full responsibility for the policy that you post. Once a privacy policy is posted online, it is crucial that a business adheres to it. An online service provider that doesn’t follow its privacy policy may violate state and federal consumer protection laws, the Texas Business and Commerce Code Sec. 501.052 and Section 5 of the Federal Trade Commission Act. Below is a sample privacy policy that you may want to use as a guide for your privacy policy. Note that there is a place for your business name or URL in the first paragraph, and a place for your phone number and email address in the last paragraph. Please make sure to personalize these. DO NOT simply cut-and-paste this policy as is";
    }
}


@end
