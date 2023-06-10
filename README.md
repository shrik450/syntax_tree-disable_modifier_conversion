# SyntaxTree::DisableModifierConversion

This is a plugin for
the [Syntax Tree Gem](https://github.com/ruby-syntax-tree/syntax_tree#plugins)
that disables conversion of a conditional into its modifier form if the entire body of
the conditional can be represented in a single line.

```ruby

# Code to be formatter

x =
  if true
    1
  end

# Before
x = (1 if true)

# After

x =
  if true
    1
  end
```

This might seem like a petty thing to care about, but it makes a big difference in
readability even at the level of a single line. For example, in a Rails project I'm
working on, syntax_tree produces the following output:

```ruby
title = (mail.subject unless mail.subject.start_with?("Re:"))
```

which is much harder to read than the original:

```ruby
title =
  unless mail.subject.start_with?("Re:")
    mail.subject
  end
```

Even the Ruby style guides that *do* allow modifier conditionals, such as the 
[Airbnb Ruby Style Guide](https://github.com/airbnb/ruby#conditional-expressions) only do 
so with the following condition:

> Modifier if/unless usage is okay when the body is simple, the condition is simple, and
> the whole thing fits on one line. Otherwise, avoid modifier if/unless

Given that a formatter can't "know" whether the predicate or the body of a conditional is
simple or not, this plugin takes the conservative approach of *never* converting a
conditional into its modifier form, even if it would fit on a single line.
