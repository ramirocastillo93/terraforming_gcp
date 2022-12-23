{{/*
Common labels
*/}}

{{- define "common.labels" -}} 
app.kubernetes.io/name: {{ template "name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}