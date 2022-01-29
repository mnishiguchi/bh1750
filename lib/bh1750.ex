defmodule BH1750 do
  @moduledoc """
  Documentation for `BH1750`.
  """

  @i2c_address1 0x23
  @cmd_power_down 0b0000_0000

  defstruct [:config, :transport]

  @doc """
  ## Examples

      bh = BH1750.new
      BH1750.read(bh)

  """
  def new(opts \\ []) do
    bus_name = Access.get(opts, :bus_name, "i2c-1")
    address = Access.get(opts, :address, @i2c_address1)
    mode = Access.get(opts, :mode, :continuous)
    resolution = Access.get(opts, :resolution, :high)

    %__MODULE__{
      config: BH1750.Config.new(mode, resolution),
      transport: BH1750.Transport.new(bus_name, address)
    }
    |> tap(&power_down/1)
  end

  def power_down(%{transport: transport}) do
    transport.write_fn.([@cmd_power_down])
  end

  def read(%{config: config, transport: transport}) do
    with {:ok, <<msb, lsb>>} <- transport.write_read_fn.([config.opcode], 2) do
      {:ok, BH1750.Calc.raw_to_lux(<<msb, lsb>>)}
    end
  end
end
