# PrettyMailer

Apply stylesheets to your emails.

## Installation

Add this line to your application's Gemfile:

    gem 'pretty_mailer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pretty_mailer

## Usage

```ruby
class ExampleMailer < ActionMailer::Base
  include PrettyMailer # include the module in your mailer
  
  # you can specify a default style for the whole mailer
  default css: 'email.css'
  # or, you can optionally pass a whole array of stylesheets
  default css: ['email.css', 'other_styles.css']
  
  def foomail
    # you can also specify stylesheets per email
    mail to: 'some@one.com' from: 'another@guy.com', subject: 'Pretty mailer is awesome', css: 'awesome.css' # array syntax works here too
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
