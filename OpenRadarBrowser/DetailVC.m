#import "DetailVC.h"
#import "Radar.h"

@implementation DetailVC
{
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_productLabel;
    IBOutlet UILabel *_productVersionLabel;
    IBOutlet UITextView *_textView;
    IBOutlet UILabel *_originatedDateLabel;
    IBOutlet UILabel *_resolvedDateLabel;
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
        NSDateFormatter * dateFormatter = [NSDateFormatter new];
        dateFormatter.calendar = NSCalendar.currentCalendar;
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        _originatedDateLabel.text = [dateFormatter stringFromDate:self.radar.originated];
        _resolvedDateLabel.text = [dateFormatter stringFromDate:self.radar.resolved];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

@end
