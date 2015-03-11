#import "DetailVC.h"
#import "Radar.h"

@implementation DetailVC
{
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_productLabel;
    IBOutlet UILabel *_productVersionLabel;
    IBOutlet UITextView *_textView;
}

- (void)setRadar:(Radar*)radar
{
    if (_radar != radar) {
        _radar = radar;

        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.radar) {
        self.title = self.radar.number;
        _titleLabel.text = self.radar.title;
        _productLabel.text = self.radar.product;
        _productVersionLabel.text = self.radar.productVersion;
        _textView.text = self.radar.text;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

@end
