defmodule Choir.StrictMapTest do
  use ExUnit.Case, async: true

  alias Choir.StrictMap, as: StrictMap

  @accepted_keys MapSet.new(
    ["radiohead", "bon iver", "talk talk", "stars of the lid"])

  test "New strict maps can be created" do
    expected_default = %{
      "radiohead" => 0,
      "bon iver" => 0,
      "talk talk" => 0,
      "stars of the lid" => 0
    }
    expected_initialized = %{
      "radiohead" => 9,
      "bon iver" => 0,
      "talk talk" => 0,
      "stars of the lid" => 0
    }

    assert expected_default == StrictMap.new(@accepted_keys)
    assert expected_initialized == StrictMap.new(@accepted_keys,
                                                 %{"radiohead" => 9,
                                                   "bon iver" => -10})
  end


  test "Values can be added to a strict map" do
    old_map = StrictMap.new(@accepted_keys)

    new_map
      = old_map
      |> StrictMap.add("radiohead", @accepted_keys)
      |> StrictMap.add("stars of the lid", @accepted_keys)

    assert new_map == StrictMap.new(@accepted_keys,
                                    %{"radiohead" => 1,
                                      "stars of the lid" => 1})
  end


  test "Values can be removed from a strict map" do
    old_map = StrictMap.new(@accepted_keys,
                            %{"radiohead" => 10, "talk talk" => 3})

    new_map
      = old_map
      |> StrictMap.remove("talk talk", @accepted_keys)
      |> StrictMap.remove("stars of the lid", @accepted_keys)
      |> StrictMap.remove("gibberish", @accepted_keys, "stars of the lid")

    assert new_map == StrictMap.new(@accepted_keys,
                                    %{"radiohead" => 10, "talk talk" => 2})
  end
end
