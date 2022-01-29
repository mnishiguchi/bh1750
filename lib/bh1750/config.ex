defmodule BH1750.Config do
  @moduledoc """
  The configuration settings for the BH1750 sensor.
  """

  use TypedStruct

  @type mode :: :continuous | :one_time
  @type resolution :: :high | :high2 | :low

  typedstruct do
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
  defp opcode(:continuous, :high), do: 0b0001_0000
  defp opcode(:continuous, :high2), do: 0b0001_0001
  defp opcode(:continuous, :low), do: 0b0001_0011
  defp opcode(:one_time, :high), do: 0b0010_0000
  defp opcode(:one_time, :high2), do: 0b0010_0001
  defp opcode(:one_time, :low), do: 0b0010_0011

  @spec measurement_time(resolution) :: 24 | 180
  defp measurement_time(:high), do: 180
  defp measurement_time(:high2), do: 180
  defp measurement_time(:low), do: 24
end
