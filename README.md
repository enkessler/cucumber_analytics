# CucumberAnalytics

[![Gem Version](https://badge.fury.io/rb/cucumber_analytics.png)](https://badge.fury.io/rb/cucumber_analytics)
[![Dependency Status](https://gemnasium.com/enkessler/cucumber_analytics.png)](https://gemnasium.com/enkessler/cucumber_analytics)
[![](https://codeclimate.com/github/enkessler/cucumber_analytics.png)](https://codeclimate.com/github/enkessler/cucumber_analytics)


---
**Attention**: The purpose and functionality provided by this gem has largely been superseded by the [cuke_modeler](https://github.com/enkessler/cuke_modeler) gem and 
other gem's that have been built on top of that gem. The only functionality that these new gems do not cover is that which falls outside the scope of feature files 
and the Gherkin language itself, so you should only need to use this gem if you need the functionality that involves step definitions.  
---


The intention of this gem is to provide a useful mechanism by which to answer
all of the burning questions that one might have about their Cucumber test base.

* Did old features get removed and leave dead step definitions behind? Or
perhaps the other way around and half of the steps in the code base are
undefined?

* Are there duplicate scenarios strewn about everywhere that only differ in
their step arguments and could be reduced into a single outline?

* Just how many different tags *are* there in this thing?

These are the kinds of questions that this gem aims to make answering easy,
either through directly providing the answer or by providing sufficient tools
that determining the answer yourself is just a few straightforward object
manipulations away.

## Installation

Add this line to your application's Gemfile:

    gem 'cucumber_analytics'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cucumber_analytics

## Usage

First things first. Load up the gem code.

    require 'cucumber_analytics'

Next, let's generate a model for our Cucumber suite.

      directory = CucumberAnalytics::Directory.new('path/to/the/code_directory')
      world = CucumberAnalytics::World

Now it's time to take a look around and see what we can see.

      all_tags = world.tags_in(directory)
      puts all_tags
      #=> ["@Unit", "@Fragile", "@wip", "@wip", "@Critical", "@Unit", "@wip", "@Deprecated", "@wip", "@wip"]
    
      puts all_tags.uniq
      #=> ["@Unit", "@Fragile", "@wip", "@Critical", "@Deprecated"]
    
      wip_tags = all_tags.select{ |tag| tag == '@wip' }
    
      puts wip_tags.count.to_f / all_tags.count
      #=> 0.5
    
    
      all_steps = world.steps_in(directory)
      puts all_steps.collect{ |step| step.base}
      #=> ["some step", "the user logs in", "the user will log in", "another step", "the user \"Bob\" logs in"]

So with a few simple commands we have discovered that there are five different
tags in our codebase and that @wip tags account for half of all usages. We have
also discovered that our team is creating several redundant steps that could be
rewritten into a single, reusable step.


### Other usages

* https://gist.github.com/enkessler/6408879 - Creating a step lexicon
* https://gist.github.com/enkessler/6519022 - Creating unique identifiers for all test cases

And why stop there? There are so many other tools that can be built with a little analysis!

* https://github.com/enkessler/cql
* https://github.com/enkessler/cuke_sniffer

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

I'm always looking for new ways to poke at a testbase. Feature requests are welcome.
