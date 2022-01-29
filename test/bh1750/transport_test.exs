defmodule BH1750.TransportTest do
  use ExUnit.Case

  test "new/1" do
    ref = make_ref()
    address = 0x23

    assert %BH1750.Transport{
             address: ^address,
             read_fn: _,
             ref: ^ref,
             write_fn: _,
             write_read_fn: _
           } = BH1750.Transport.new(ref, address)
  end
end
