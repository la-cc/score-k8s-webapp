# 🩹 all-in-one-patch-example – Customizing Kubernetes Resources with Score.dev

This repository demonstrates how to work with [Score.dev](https://score.dev) using a combination of **provisioners** and **patch templates** to define your own Kubernetes resource logic **and** extend or override the default behavior.

It serves as a practical **patching example** for platform teams and developers who want to:

* Customize existing Score.dev Kubernetes provisioners
* Dynamically inject values like namespaces, labels, or replicas
* Maintain reusable, layered infrastructure definitions

---

## ⚙️ What’s Included

* Custom provisioners for common Kubernetes resources (Deployment, Service, etc.)
* Patch templates to inject labels, annotations, or modify structure
* CLI-based manifest patching for dynamic configuration
* Clean separation of logic, ideal for CI/CD and multi-environment setups

---

## 📦 Getting Started

### Step 1: Initialize the Project

Run the following to initialize the setup with provisioners and patch templates:

```bash
score-k8s init \
  --no-sample \
  --provisioners all-in-one-patch-example/provisioners.yaml \
  --patch-templates all-in-one-patch-example/10-deployment-patcher.provisioners.yaml \
  --patch-templates all-in-one-patch-example/10-service-patcher.provisioners.yaml
```

---

## 🚀 Step 2: Generate Kubernetes Manifests

Generate the Kubernetes manifests and apply dynamic patches (like setting the namespace):

```bash
score-k8s generate all-in-one-patch-example/score.yaml \
  --patch-manifests '*/*/metadata.namespace=webapp'
```

---

## ⚠️ How Patching Works (and What to Watch Out For)

### Patch Order Matters

When working with both patch templates and CLI-based patching, Score applies changes in the following order:

1. **Generate**: The base Kubernetes manifests are generated from your Score file.
2. **CLI Patch**: Fields modified with `--patch-manifests` are applied (e.g., dynamic namespace).
3. **Patch Templates**: Templates from `--patch-templates` are applied **last** and override any previous changes. This is how it looks like to work.

### Namespace Conflicts

If your patch template defines a value for `metadata.namespace`, it will override the one provided via CLI.

#### ✅ Recommended Solution:

If you want to set the namespace dynamically (e.g., via `--patch-manifests`), **remove the `namespace` field** from your patch templates.

---

## ✅ Best Practices (imho)

* Use **patch templates** for reusable static changes (e.g., default labels, sidecars).
* Use **CLI patches** for values that vary per environment (e.g., namespace, replica count).
* Avoid defining the same field in both CLI and patch templates to prevent overwrites.

---

## 📁 Project Structure

```
.
├── all-in-one-patch-example/
│   ├── provisioners.yaml
│   ├── 10-deployment-patcher.provisioners.yaml
│   ├── 10-service-patcher.provisioners.yaml
│   └── score.yaml
└── README.md
```

