defmodule BonnyDependents.Controller.MyAppControllerTest do
  @moduledoc false
  use ExUnit.Case, async: false
  use Bonny.Axn.Test

  alias BonnyDependents.Controller.MyAppController

  test "add is handled and returns axn" do
    axn = axn(:add)
    result = MyAppController.call(axn, [])
    assert is_struct(result, Bonny.Axn)
  end

  test "modify is handled and returns axn" do
    axn = axn(:modify)
    result = MyAppController.call(axn, [])
    assert is_struct(result, Bonny.Axn)
  end

  test "reconcile is handled and returns axn" do
    axn = axn(:reconcile)
    result = MyAppController.call(axn, [])
    assert is_struct(result, Bonny.Axn)
  end

  test "delete is handled and returns axn" do
    axn = axn(:delete)
    result = MyAppController.call(axn, [])
    assert is_struct(result, Bonny.Axn)
  end
end
