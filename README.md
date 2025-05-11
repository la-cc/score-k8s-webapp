# 🔧 score.dev-examples – Practical Workflows for Kubernetes with Score.dev

This repository provides practical **examples and templates** for working with [Score.dev](https://score.dev), focused specifically on **Kubernetes deployments**.

It demonstrates how to define your own infrastructure logic using custom **provisioners**, optionally **patch default resources**, and generate production-ready Kubernetes manifests. The output can be directly integrated into a **GitOps** workflow or manually applied to your cluster.

---

## 📘 What Is Score.dev?

**Score.dev** is a developer-centric specification that allows you to define your application’s infrastructure needs once—using a simple YAML format—and generate platform-specific manifests such as Kubernetes or Docker Compose.

It aims to reduce the pain developers face when working with:

* Complex, environment-specific YAML files
* Duplicated configuration across different platforms (dev/stage/prod)
* Switching between Docker Compose and Kubernetes
* Having to understand infrastructure internals just to deploy an app

Learn more at [score.dev](https://score.dev)

---

## 📁 Example Structure

This repository contains two main example projects:

| Folder                                                                   | Description                                                                                                                            |
| ------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------- |
| [`all-in-one-patch-example`](provisioners/all-in-one-patch-example)                 | Uses custom provisioners **with patch templates** to extend or modify default behavior (e.g., labels, namespace injection).            |
| [`all-in-one-without-patch-example`](provisioners/all-in-one-without-patch-example) | Uses **only custom provisioners**, giving you full control over resource generation (e.g., replacing default `Deployment`, `Service`). |

Each example shows how to:

* Initialize a Score-based project
* Define Kubernetes resources via provisioners
* (Optionally) Patch existing default resources
* Generate Kubernetes manifests

---

## 🚀 GitOps-Ready Output

The generated Kubernetes manifests (via `score-k8s generate`) are clean, standalone YAML files. You can:

* Commit them into your **GitOps repository** (e.g., Argo CD or Flux)
* Integrate them into your **CI/CD pipelines**
* Apply them directly to your Kubernetes cluster

---

## 🐋 Note on Docker Compose Support

While Score.dev supports **Docker Compose** as a target platform, these examples are **built specifically for Kubernetes**.

To use them with Docker Compose, you would need to:

* Adapt the provisioners manually
* Remove or replace Kubernetes-specific resources like `Ingress` or `HPA`
* Use simpler constructs that map to Docker Compose (e.g., ports, services)

Refer to the [official Score documentation](https://score.dev/docs/) for Docker Compose support.

---

## ✍️ Upcoming Blog Post: Why Score.dev Matters for Developers

We’re preparing a blog post that highlights the **real pain points developers face** when managing infrastructure across environments—and how Score.dev addresses those.

It will cover:

* The challenges of multi-environment deployments
* Why developers struggle with Kubernetes YAML
* How Score.dev decouples application intent from platform implementation

📖 **Stay tuned!** The link will be added here once published.
