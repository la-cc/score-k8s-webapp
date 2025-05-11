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
score-k8s generate all-in-one-without-patch-example/score.yaml
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
{{ range $i, $m := .Manifests }}
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

## 🐞 Known Issue

As of now, due to [a bug in `score-k8s`](https://github.com/score-spec/score-k8s/issues/167), it's **not yet possible** to delete default `Deployment` and `Service` resources using a patch template.

👉 **Temporary workaround:** Delete the duplicated resources manually from the generated manifests until this is fixed in an upcoming release.

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
