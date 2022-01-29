defmodule BH1750.ConfigTest do
  use ExUnit.Case

  test "new/1" do
    assert BH1750.Config.new(:continuous, :high) ==
             %BH1750.Config{
               measurement_time: 180,
               mode: :continuous,
               opcode: 16,
               resolution: :high
             }
  end
end
