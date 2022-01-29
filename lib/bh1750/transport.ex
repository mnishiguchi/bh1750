defmodule BH1750.Transport do
  @moduledoc false

  use TypedStruct

  typedstruct do
    @typedoc "The I2C transport to communiate with a device"

    field(:address, 0..127, enforce: true)
    field(:read_fn, fun, enforce: true)
    field(:ref, reference, enforce: true)
    field(:write_fn, fun, enforce: true)
    field(:write_read_fn, fun, enforce: true)
  end

  @spec new(reference, 0..127) :: BH1750.Transport.t()
  def new(ref, address) when is_reference(ref) do
    %__MODULE__{
      ref: ref,
      address: address,
      read_fn: &Circuits.I2C.read(ref, address, &1),
      write_fn: &Circuits.I2C.write(ref, address, &1),
      write_read_fn: &Circuits.I2C.write_read(ref, address, &1, &2)
    }
  end

  @spec new(reference, binary()) :: BH1750.Transport.t()
  def new(bus_name, address) do
    ref = open_i2c!(bus_name)
    new(ref, address)
  end

  @spec open_i2c!(binary) :: reference
  def open_i2c!(bus_name) do
    {:ok, ref} = Circuits.I2C.open(bus_name)
    ref
  end
end
