# BonnyDependents

Tests regarding CR dependents.

## Usage

```
mix deps.get
mix bonny.gen.manifest

k3d cluster create
kubectl apply -f manifest.yaml

iex -S mix
kubectl apply -f test.yaml
```
