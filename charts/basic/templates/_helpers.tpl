{{/*
Return the metadata labels block
*/}}
{{- define "metadata.labels" -}}
  labels:
    app: {{ .Values.application.name }}
{{- end -}}

{{- define "metadata.namespace" -}}
{{- if hasKey .Values.application "namespace" -}}
  namespace: {{ .Values.application.namespace }}
{{- end -}}
{{- end -}}
