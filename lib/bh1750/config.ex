defmodule BH1750.Config do
  @moduledoc false

  defstruct [
    :measurement_time,
    :mode,
    :opcode,
    :resolution
  ]

  def new(mode, resolution) do
    %__MODULE__{
      mode: mode,
      measurement_time: measurement_time(resolution),
      opcode: opcode(mode, resolution),
      resolution: resolution
    }
  end

  def opcode(:continuous, :high), do: 0b0001_0000
  def opcode(:continuous, :high2), do: 0b0001_0001
  def opcode(:continuous, :low), do: 0b0001_0011
  def opcode(:one_time, :high), do: 0b0010_0000
  def opcode(:one_time, :high2), do: 0b0010_0001
  def opcode(:one_time, :low), do: 0b0010_0011

  def measurement_time(:high), do: 180
  def measurement_time(:high2), do: 180
  def measurement_time(:low), do: 24
end
