//
//  ViewController.m
//  TestiOS-libexif
//  Sample code ref from: https://github.com/libexif/libexif/blob/master/contrib/examples
//
//  Created by sijie.shen on 2019/05/10.
//  Copyright © 2019 djij-solution. All rights reserved.
//

#import "ViewController.h"
#include <string>
#include <libexif/exif-loader.h>

@interface ViewController ()

@end

@implementation ViewController


/* Show the tag name and contents if the tag exists */
static void show_tag(ExifData *d, ExifIfd ifd, ExifTag tag)
{
    /* See if this tag exists */
    ExifEntry *entry = exif_content_get_entry(d->ifd[ifd],tag);
    if (entry) {
        char buf[1024];
        
        /* Get the contents of the tag in human-readable form */
        exif_entry_get_value(entry, buf, sizeof(buf));
        
        if (*buf) {
            printf("%s: %s\n", exif_tag_get_name_in_ifd(tag,ifd), buf);
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString * imagePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpg"];
    std::string imgStr = std::string([imagePath UTF8String]);
    
    ExifData *ed;
    /* Get a pointer to the EXIF data */
    ed = exif_data_new_from_file(imgStr.c_str());
    
    if (ed) {
        for (int i = 0; i < EXIF_IFD_COUNT; i++) {
            const char *ifd_name = exif_ifd_get_name(static_cast<ExifIfd>(i));
            if (!ifd_name) {
                continue;
            }
            
            printf("\n idf: %s", ifd_name);
            for (int t = 0; t < 0xffff; t++) {
                show_tag(ed, static_cast<ExifIfd>(i), static_cast<ExifTag>(t));
            }
        }
        
        /* Free the EXIF data */
        exif_data_unref(ed);
    }
}


@end
