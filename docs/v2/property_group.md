# V2 Property Groups

`PlentyClient::V2::Item::PropertyGroup` provides methods for managing property groups via the PlentyMarkets REST API v2.

**Base endpoint:** `/v2/properties/groups`

## Methods

### List all property groups

```ruby
PlentyClient::V2::Item::PropertyGroup.list
```

With parameters:

```ruby
PlentyClient::V2::Item::PropertyGroup.list(
  'with' => 'names,options',
  'orderBy' => 'position',
  'itemsPerPage' => 25
)
```

With pagination block:

```ruby
PlentyClient::V2::Item::PropertyGroup.list({}) do |entry|
  puts entry['id']
end
```

### Find a property group

```ruby
PlentyClient::V2::Item::PropertyGroup.find(group_id)
```

With parameters:

```ruby
PlentyClient::V2::Item::PropertyGroup.find(group_id, 'with' => 'names,options')
```

### Create a property group

```ruby
PlentyClient::V2::Item::PropertyGroup.create(
  'position' => 1,
  'names' => [
    { 'lang' => 'en', 'name' => 'My Group', 'description' => 'A property group' }
  ],
  'options' => [
    { 'type' => 'surchargeType', 'value' => 'flat' }
  ]
)
```

| Parameter   | Type    | Required | Description                          |
|-------------|---------|----------|--------------------------------------|
| `position`  | Integer | No       | The position of the property group   |
| `names`     | Array   | Yes      | At least one name must be provided   |
| `options`   | Array   | No       | Property group options               |

**Name object fields:**

| Field         | Type   | Description                     |
|---------------|--------|---------------------------------|
| `lang`        | String | ISO 639-1 language code (e.g. `en`, `de`) |
| `name`        | String | Name of the property group      |
| `description` | String | Description of the property group |

**Option object fields:**

| Field   | Type   | Description        |
|---------|--------|--------------------|
| `type`  | String | Option identifier  |
| `value` | String | Option value       |

### Update a property group

```ruby
PlentyClient::V2::Item::PropertyGroup.update(
  group_id,
  'position' => 2,
  'names' => [
    { 'lang' => 'en', 'name' => 'Updated Group' }
  ]
)
```

### Delete a property group

```ruby
PlentyClient::V2::Item::PropertyGroup.destroy(group_id)
```
