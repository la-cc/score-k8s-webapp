# 🛠 all-in-one-without-patch-example – Custom Provisioners without Patch Templates

This example demonstrates how to use [Score.dev](https://score.dev) to define **fully custom Kubernetes provisioners** without relying on patch templates. It’s designed for users who want **full control** over how their Kubernetes resources are generated.

---

## 📌 What This Is

This is a **"without patches"** example. It shows how to:

* Define your own Kubernetes provisioners from scratch
* Avoid relying on the default behavior from Score.dev
* Take over full resource generation without using patch templates for defaults provisioners

---

## 📦 Getting Started

### Initialize the Project

Start by initializing the setup using only your custom provisioners:

```bash
score-k8s init \
  --no-sample \
  --provisioners all-in-one-without-patch-example/provisioners.yaml
```

Then generate your Kubernetes manifests:

```bash
score-k8s generate all-in-one-without-patch-example/score.yaml --namespace simple-webapp --generate-namespace
```

---

## 🧯 Double Resource Warning

When running this example, you may notice that some resources—such as `Deployment` and `Service`—are **generated twice**. This happens because:

* Score’s **default provisioners** are still being used under the hood
* You’ve defined your own custom provisioners for the same resource types

### Solution: Delete Default Resources

To fully replace the defaults, you can apply a "delete everything" patch to remove the default resources before injecting your own:

```yaml
# all-in-one-without-patch-example/delete-default-provisioners.provisioners.yaml
{{ range $i, $m := (reverse .Manifests) }}
{{ $i := sub (len $.Manifests) (add $i 1) }}
- op: delete
  path: {{ $i }}
{{ end }}
```

Apply it like this:

```bash
score-k8s init \
  --no-sample \
  --provisioners all-in-one-without-patch-example/provisioners.yaml \
  --patch-templates all-in-one-without-patch-example/delete-default-provisioners.provisioners.yaml
```

---

## 📁 Project Structure

```
.
├── all-in-one-without-patch-example/
│   ├── provisioners.yaml
│   ├── delete-default-provisioners.provisioners.yaml
│   └── score.yaml
└── README.md
```
