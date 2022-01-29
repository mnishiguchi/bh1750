defmodule BH1750.Transport do
  @moduledoc false

  defstruct [
    :address,
    :read_fn,
    :ref,
    :write_fn,
    :write_read_fn
  ]

  def new(ref, address) when is_reference(ref) do
    %__MODULE__{
      ref: ref,
      address: address,
      read_fn: &Circuits.I2C.read(ref, address, &1),
      write_fn: &Circuits.I2C.write(ref, address, &1),
      write_read_fn: &Circuits.I2C.write_read(ref, address, &1, &2)
    }
  end

  def new(bus_name, address) do
    ref = open_i2c!(bus_name)
    new(ref, address)
  end

  def open_i2c!(bus_name) do
    {:ok, ref} = Circuits.I2C.open(bus_name)
    ref
  end
end
