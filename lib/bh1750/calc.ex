defmodule BH1750.Calc do
  @moduledoc false

  @doc """
  Converts raw value to LUX.

  ## Examples

      iex> BH1750.Calc.raw_to_lux(<<0b1000_0011, 0b1001_0000>>) |> round()
      28067

      iex> BH1750.Calc.raw_to_lux(<<0b0000_0001, 0b0001_0000>>) |> round()
      227

  """
  @spec raw_to_lux(<<_::16>>) :: float
  def raw_to_lux(<<raw::unsigned-16>>) do
    (raw * 10 + 5) / 12
  end
end
