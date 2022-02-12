# BH1750

[![Hex version](https://img.shields.io/hexpm/v/bh1750.svg 'Hex version')](https://hex.pm/packages/bh1750)
[![API docs](https://img.shields.io/hexpm/v/bh1750.svg?label=docs 'API docs')](https://hexdocs.pm/bh1750)
[![CI](https://github.com/mnishiguchi/bh1750/actions/workflows/ci.yml/badge.svg)](https://github.com/mnishiguchi/bh1750/actions/workflows/ci.yml)

Use BH1750 16-bit ambient light sensor in Elixir.

## Installation

Add `bh1750` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bh1750, "~> 0.2"}
  ]
end
```

## Usage
### I2C address

I2C address can be either `0x23` (default) or `0x5C`.

### Start a sensor server

```elixir
{:ok, sensor} = BH1750.start_link
```

### Measure the ambient light

```elixir
{:ok, lux} = BH1750.measure(sensor)
```

For more information, see [API reference](https://hexdocs.pm/bh1750/api-reference.html).
