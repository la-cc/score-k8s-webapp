{{- range $i, $m := .Manifests }}
{{- if eq $m.kind "Service" }}
# 1) metadata.labels → app=<serviceName>
- op: set
  path: {{ $i }}.metadata.labels
  value:
    app: {{ $m.metadata.name }}

# 2) spec.selector → { app: <serviceName> }
- op: set
  path: {{ $i }}.spec.selector
  value:
    app: {{ $m.metadata.name }}
{{- end }}
{{- end }}