# Pondus

A ruby gem to implemented scored sorting for ActiveRecord Models.

## NOTICE

THIS GEM IS VERY MUCH WORK IN PROGRESS!!
IT GREW OUT OF THE NEED IN A CLIENT PROJECT AND IS NOW BEING DEVELOPED
TO SOLVE AN ISSUE THAT OTHERS MIGHT ALSO HAVE.

**API WILL CHANGE!**

## Installation

```ruby
Gemfile
gem 'pondus'

app/models/model.rb
class Model
  extend Pondus
end
```
    
## Attributes for sorting


```ruby
scored_by [COLUMN_NAME] => 

scored_by :title
scored_by :description
```

## Weight of attribute

```ruby
scored_by :description, weight: 10
scored_by :first_name, weight: 25
scored_by :last_name, weight: 25
scored_by :middle_name, weight: 20
scored_by :title, weight: 25
```

## Weight strategy

```ruby
scored_by :description, weight: 10
scored_by :first_name, weight: 25
scored_by :last_name, weight: 25
scored_by :middle_name, weight: 20
scored_by :title, weight_strategy: :auto # will be re-weighted to 25 (100 - reserved_weight)
```

The system will auto assign a weight to each attribute if no static weight or strategy is given.

```ruby
scored_by :description # Weight is 100 / count_of_attributes(5) => 20
scored_by :first_name
scored_by :last_name
scored_by :middle_name
scored_by :title
```

## Scoring Strategy

### String Match
Will return a score between 0 and 100 depending on the similarity of the 'search' term and the column value.

```ruby
scored_by :description, strategy: :string_match
```

## Param Key

When passing the 'sorting' parameters to the scored scope (Model.scored(params)) multiple scored_attributes can use
the same value for their matching by assigning them the same 'param_key'.

```ruby
scored_by :title, param_key: :search
scored_by :description, param_key: :search
```
