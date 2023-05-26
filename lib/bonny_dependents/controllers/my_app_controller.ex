defmodule BonnyDependents.Controller.MyAppController do
  @moduledoc """
  BonnyDependents: MyAppController controller.
  """
  use Bonny.ControllerV2

  step Bonny.Pluggable.SkipObservedGenerations
  step :handle_event

  # apply the resource
  @spec handle_event(Bonny.Axn.t(), any) :: Bonny.Axn.t()
  def handle_event(%Bonny.Axn{action: action} = axn, _opts)
      when action in [:add, :modify, :reconcile] do
    IO.inspect(axn.resource)
    name = K8s.Resource.name(axn.resource)
    namespace = K8s.Resource.namespace(axn.resource)

    config_map = K8s.Resource.build("v1", "ConfigMap", namespace, name)

    deployment =
      K8s.Resource.build("apps/v1", "Deployment", namespace, name)
      |> Map.put("spec", %{
        "selector" => %{"matchLabels" => %{"app" => "myapp"}},
        "template" => %{
          "metadata" => %{"labels" => %{"app" => "myapp"}},
          "spec" => %{
            "containers" => [
              %{
                "name" => "myapp",
                "image" => "nginx",
                "resources" => %{"limits" => %{"memory" => "128Mi", "cpu" => "500m"}},
                "ports" => [%{"containerPort" => 80}]
              }
            ]
          }
        }
      })

    axn
    |> Bonny.Axn.register_descendant(config_map)
    |> Bonny.Axn.register_descendant(deployment)
    |> success_event()
  end

  # delete the resource
  def handle_event(%Bonny.Axn{action: :delete} = axn, _opts) do
    IO.inspect(axn.resource)
    axn
  end
end
