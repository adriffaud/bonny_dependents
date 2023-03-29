defmodule BonnyDependents.Operator do
  @moduledoc """
  Defines the operator.

  The operator resource defines custom resources, watch queries and their
  controllers and serves as the entry point to the watching and handling
  processes.
  """

  use Bonny.Operator, default_watch_namespace: "default"

  step(Bonny.Pluggable.Logger, level: :info)
  step(:delegate_to_controller)
  step(Bonny.Pluggable.ApplyStatus)
  step(Bonny.Pluggable.ApplyDescendants)

  @impl Bonny.Operator
  def controllers(watching_namespace, _opts) do
    [
      %{
        query:
          K8s.Client.watch("test.driffaud.fr/v1alpha1", "MyApp", namespace: watching_namespace),
        controller: BonnyDependents.Controller.MyAppController
      }
    ]
  end

  @impl Bonny.Operator
  def crds() do
    [
      %Bonny.API.CRD{
        names: %{kind: "MyApp", plural: "myapps", shortNames: [], singular: "myapp"},
        group: "test.driffaud.fr",
        versions: [BonnyDependents.API.V1Alpha1.MyApp],
        scope: :Namespaced
      }
    ]
  end
end
