{{- range $i, $m := .Manifests }}
{{- if eq $m.kind "Deployment" }}

# 2) metadata.labels → app=<name>
- op: set
  path: {{ $i }}.metadata.labels
  value:
    app: {{ $m.metadata.name }}

# 3) replicas → 3
- op: set
  path: {{ $i }}.spec.replicas
  value: 3

# 4) selector & pod-template labels
- op: set
  path: {{ $i }}.spec.selector.matchLabels
  value:
    app: {{ $m.metadata.name }}
- op: set
  path: {{ $i }}.spec.template.metadata.labels
  value:
    app: {{ $m.metadata.name }}

# 8) inject volumes so mounts have definitions
- op: set
  path: {{ $i }}.spec.template.spec.volumes
  value:
    - name: tmp
      emptyDir: {}
    - name: podname
      downwardAPI:
        items:
          - path: podname
            fieldRef:
              fieldPath: metadata.name

# 9) container-level patches (envFrom, mounts, security, probes, resources)
{{- range $cidx, $_ := $m.spec.template.spec.containers }}
- op: set
  path: {{ $i }}.spec.template.spec.containers.{{ $cidx }}.envFrom
  value:
    - configMapRef:
        name: {{ $m.metadata.name }}-cm

- op: set
  path: {{ $i }}.spec.template.spec.containers.{{ $cidx }}.volumeMounts
  value:
    - name: tmp
      mountPath: /tmp
    - name: podname
      subPath: podname
      mountPath: /usr/share/nginx/html/podname
      readOnly: true

{{- end }}

{{- end }}
{{- end }}
