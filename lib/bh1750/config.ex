defmodule BH1750.Config do
  @moduledoc false

  use TypedStruct

  @type mode :: :continuous | :one_time
  @type resolution :: :high | :high2 | :low

  typedstruct do
    @typedoc "The configuration settings for the BH1750 sensor"

    field(:measurement_time, non_neg_integer, enforce: true)
    field(:mode, mode, enforce: true)
    field(:opcode, byte, enforce: true)
    field(:resolution, resolution, enforce: true)
  end

  @spec new(mode, resolution) :: BH1750.Config.t()
  def new(mode, resolution) do
    %__MODULE__{
      mode: mode,
      measurement_time: measurement_time(resolution),
      opcode: opcode(mode, resolution),
      resolution: resolution
    }
  end

  @spec opcode(mode, resolution) :: byte
  def opcode(:continuous, :high), do: 0b0001_0000
  def opcode(:continuous, :high2), do: 0b0001_0001
  def opcode(:continuous, :low), do: 0b0001_0011
  def opcode(:one_time, :high), do: 0b0010_0000
  def opcode(:one_time, :high2), do: 0b0010_0001
  def opcode(:one_time, :low), do: 0b0010_0011

  @spec measurement_time(resolution) :: 24 | 180
  def measurement_time(:high), do: 180
  def measurement_time(:high2), do: 180
  def measurement_time(:low), do: 24
end
