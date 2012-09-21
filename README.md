rack-smart-app-banner
=====================

**Rack middleware to automatically include code for Smart App Banner, introduced in iOS 6**

![Smart App Banner Example](http://cl.ly/image/1K0W2F050a0h/smartappbanner.png)



According to the ["Promoting Apps with Smart App Banners"](https://developer.apple.com/library/safari/#documentation/AppleApplications/Reference/SafariWebContent/PromotingAppswithAppBanners/PromotingAppswithAppBanners.html) section of the [Safari Web Content Guide](https://developer.apple.com/library/safari/#documentation/AppleApplications/Reference/SafariWebContent/Introduction/Introduction.html#//apple_ref/doc/uid/TP40002051-CH1-SW1):

> Smart App Banners vastly improve users’ browsing experience compared to other promotional methods. ... [Users] will appreciate that banners are presented unobtrusively at the top of a webpage, instead of as a full-screen ad interrupting the web content. And with a large and prominent close button, a banner is easy for users to dismiss.
>
> If the app is already installed on a user's device, the banner intelligently changes its action, and tapping the banner will simply open the app. If the user doesn’t have your app on his device, tapping on the banner will take him to the app’s entry in the App Store.



## Usage

```ruby
require "rack/smart-app-banner"
  
use Rack::SmartAppBanner, app_id: "123456789",
                          affiliate_partner_id: 42,
                          affiliate_site_id: "abcdef123456",
                          app_argument: lambda {|request| request.path}
```

Including this in the `config.ru` file of your Rack application will automatically inject the corresponding `<meta>` tag into the `<head>` of each HTML document.

```html
<meta name="apple-itunes-app" content="app-id=123456789, affiliate-data=partnerId=42&siteID=abcdef123456 app-argument=http://listings/123" />
```

### Parameters

- `app_id`: _Required_. Your app's unique identifier. To find your app ID from the [iTunes Link Maker](http://itunes.apple.com/linkmaker/), type the name of your app in the Search field, and select the appropriate country and media type. In the results, find your app and select iPhone App Link in the column on the right. Your app ID is the nine-digit number in between id and ?mt.
- `affiliate_partner_id` & `affiliate_site_id`: _Optional_. Your iTunes affiliate details, if you are an iTunes affiliate. If you are not, find out more about becoming an iTunes affiliate at http://www.apple.com/itunes/affiliates/.
- `app_argument`: _Optional_. A block that generates a URL that provides context to your native app. If you include this, and the user has your app installed, she can jump from your website to the corresponding position in your iOS app.

## Installation

Add `rack-smart-app-banner` to your application's `Gemfile`:

### Gemfile

```ruby
gem 'rack-smart-app-banner', require: 'rack/smart-app-banner'
```

## Requirements

- Ruby 1.9

## Contact

Mattt Thompson

- http://github.com/mattt
- http://twitter.com/mattt
- m@mattt.me

## License

rack-smart-app-banner is available under the MIT license. See the LICENSE file for more info.
