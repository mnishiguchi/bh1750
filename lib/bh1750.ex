defmodule BH1750 do
  @moduledoc """
  Use BH1750 16-bit ambient light sensor in Elixir.
  """

  @default_bus_name "i2c-1"
  @default_address 0x23
  @default_mode :continuous
  @default_resolution :high

  @cmd_power_down 0b0000_0000

  @type lux :: 0..65535

  use TypedStruct

  typedstruct do
    @typedoc "The BH1750 sensor"

    field(:config, BH1750.Config.t(), enforce: true)
    field(:transport, BH1750.Transport.t(), enforce: true)
  end

  @doc """
  Instantiates a BH1750 sensor.
  """
  @spec new(keyword | map) :: BH1750.t()
  def new(opts \\ []) do
    bus_name = Access.get(opts, :bus_name, @default_bus_name)
    address = Access.get(opts, :address, @default_address)
    mode = Access.get(opts, :mode, @default_mode)
    resolution = Access.get(opts, :resolution, @default_resolution)

    %__MODULE__{
      config: BH1750.Config.new(mode, resolution),
      transport: BH1750.Transport.new(bus_name, address)
    }
    |> tap(&power_down/1)
  end

  @doc """
  Powers down the BH1750 sensor.
  """
  @spec power_down(BH1750.t()) :: :ok | {:error, any}
  def power_down(%__MODULE__{transport: transport}) do
    transport.write_fn.([@cmd_power_down])
  end

  @doc """
  Measures the ambient light.
  """
  @spec measure(BH1750.t()) :: {:ok, lux} | {:error, any}
  def measure(%__MODULE__{config: config, transport: transport}) do
    with :ok <- transport.write_fn.([config.opcode]),
         :ok <- Process.sleep(config.measurement_time),
         {:ok, <<msb, lsb>>} <- transport.write_read_fn.([config.opcode], 2) do
      {:ok, BH1750.Calc.raw_to_lux(<<msb, lsb>>)}
    end
  end
end
