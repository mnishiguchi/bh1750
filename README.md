# BH1750

Use BH1750 16-bit ambient light sensor in Elixir.

## Installation

Add `bh1750` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bh1750, "~> 0.1"}
  ]
end
```

## Usage
### I2C address

I2C address can be either `0x23` (default) or `0x5C`.

### Initialize the sensor

```elixir
sensor = BH1750.new
```

### Measure the ambient light

```elixir
{:ok, lux} = BH1750.measure(sensor)
```

For more information, see [documentation](https://hexdocs.pm/bh1750).
