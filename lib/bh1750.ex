defmodule BH1750 do
  @moduledoc """
  Use BH1750 16-bit ambient light sensor in Elixir.
  """

  use GenServer

  @type option() :: {:name, GenServer.name()} | BH1750.Sensor.option()

  @doc """
  Instantiates a BH1750 sensor.
  """
  def start_link(args \\ []) do
    GenServer.start_link(__MODULE__, args, name: args[:name])
  end

  @doc """
  Powers down the BH1750 sensor.
  """
  @spec power_down(GenServer.server()) :: :ok | {:error, any}
  def power_down(server \\ BH1750), do: GenServer.call(server, :power_down)

  @doc """
  Measures the ambient light.
  """
  @spec measure(GenServer.server()) :: {:ok, 0..0xFFFF} | {:error, any}
  def measure(server \\ BH1750), do: GenServer.call(server, :measure)

  @impl GenServer
  def init(args) do
    {:ok, BH1750.Sensor.new(args)}
  end

  @impl GenServer
  def handle_call(fn_name, _from, sensor) do
    {:reply, apply(BH1750.Sensor, fn_name, [sensor]), sensor}
  end
end
