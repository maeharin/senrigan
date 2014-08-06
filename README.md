# Senrigan

Visualizer for any dependencies. For Example template engine like JSP, ERB, Smarty etc..

- Now, only JSP supportted...

## Usage

```
$ bundle exec bin/senrigan jsp <<jsp directory path>>
```

see images/routes.gif

![visualized JSP dependencies](https://github.com/maeharin/senrigan/blob/master/images/sample_jsp.gif)

## Installation

Senrigan depend on graphviz

```
$ brew install graphviz
```

Add this line to your application's Gemfile:

    gem 'senrigan'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install senrigan

