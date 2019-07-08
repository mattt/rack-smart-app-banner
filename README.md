# rack-smart-app-banner

**Rack middleware to automatically include code for Smart App Banners on iOS**

> This project is no longer maintained.

---

> Make it easy for users to discover and download your app from a website on iOS.
> With Safari’s Smart App Banner
> you can display a banner that provides a direct link to your app on the App Store,
> or opens the app if the user already has it installed.
> Smart App Banners integrate seamlessly,
> have the same look and feel users know from the App Store,
> and are easy to implement.
> <cite><a href="https://developer.apple.com/safari/resources/">Resources - Safari - Apple Developer</a></cite>

## Requirements

- Ruby 1.9 or higher

## Installation

### Gemfile

```ruby
gem 'rack-smart-app-banner', require: 'rack/smart-app-banner'
```

## Usage

```ruby
use Rack::SmartAppBanner, app_id: "123456789",
                          affiliate_partner_id: 42,
                          affiliate_site_id: "abcdef123456",
                          app_argument: lambda { |request| request.path }
```

Include this in the `config.ru` file of your Rack application,
to inject a corresponding `<meta>` tag into the `<head>` of each HTML document.

```html
<meta
  name="apple-itunes-app"
  content="app-id=123456789, affiliate-data=partnerId=42&siteID=abcdef123456 app-argument=http://listings/123"
/>
```

### Parameters

- `app_id`: _Required_.
  Your app's unique identifier.
  To find your app ID from the [iTunes Link Maker](http://itunes.apple.com/linkmaker/),
  type the name of your app in the Search field,
  and select the appropriate country and media type.
  In the results, find your app and select iPhone App Link in the column on the right.
  Your app ID is the nine-digit number in between `id` and `?mt`.
- `affiliate_partner_id` & `affiliate_site_id`: _Optional_.
  Your iTunes affiliate details, if you are an iTunes affiliate.
  If you aren't, you can find out more about becoming an iTunes affiliate at
  http://www.apple.com/itunes/affiliates/.
- `app_argument`: _Optional_.
  A block that generates a URL that provides context to your native app.
  If you include this and the user has your app installed,
  they can jump from your website to the corresponding position in your iOS app.

## Contact

[Mattt](https://twitter.com/mattt)

## License

rack-smart-app-banner is available under the MIT license.
See the LICENSE file for more info.
