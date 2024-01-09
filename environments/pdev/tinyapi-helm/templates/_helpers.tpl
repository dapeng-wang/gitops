{{/*
Return the metadata labels block
*/}}
{{- define "metadata.labels" -}}
labels:
    app: {{ .Values.application.name }}
    app.kubernetes.io/part-of: {{ .Values.application.group | default .Values.application.name }}
{{- end -}}