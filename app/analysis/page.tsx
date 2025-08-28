"use client"

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Badge } from "@/components/ui/badge"
import { Progress } from "@/components/ui/progress"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import {
  ArrowLeft,
  Thermometer,
  Droplets,
  Zap,
  Leaf,
  TrendingUp,
  TrendingDown,
  Minus,
  CheckCircle,
  AlertTriangle,
  XCircle,
} from "lucide-react"

export default function SoilAnalysis() {
  const analysisData = {
    date: "15 de Marzo, 2024",
    time: "14:30",
    location: "Parcela Norte",
    ph: { value: 6.8, status: "optimal", trend: "up" },
    humidity: { value: 65, status: "optimal", trend: "stable" },
    temperature: { value: 22, status: "optimal", trend: "up" },
    nitrogen: { value: 45, status: "warning", trend: "down" },
    phosphorus: { value: 38, status: "critical", trend: "down" },
    potassium: { value: 52, status: "optimal", trend: "up" },
    organicMatter: { value: 3.2, status: "optimal", trend: "stable" },
    conductivity: { value: 1.8, status: "optimal", trend: "stable" },
  }

  const getStatusColor = (status: string) => {
    switch (status) {
      case "optimal":
        return "text-green-600 bg-green-100"
      case "warning":
        return "text-yellow-600 bg-yellow-100"
      case "critical":
        return "text-red-600 bg-red-100"
      default:
        return "text-gray-600 bg-gray-100"
    }
  }

  const getStatusIcon = (status: string) => {
    switch (status) {
      case "optimal":
        return <CheckCircle className="w-4 h-4" />
      case "warning":
        return <AlertTriangle className="w-4 h-4" />
      case "critical":
        return <XCircle className="w-4 h-4" />
      default:
        return <CheckCircle className="w-4 h-4" />
    }
  }

  const getTrendIcon = (trend: string) => {
    switch (trend) {
      case "up":
        return <TrendingUp className="w-4 h-4 text-green-500" />
      case "down":
        return <TrendingDown className="w-4 h-4 text-red-500" />
      case "stable":
        return <Minus className="w-4 h-4 text-gray-500" />
      default:
        return <Minus className="w-4 h-4 text-gray-500" />
    }
  }

  const MetricCard = ({ title, icon, data, unit = "", description }: any) => (
    <Card className="border-green-200">
      <CardHeader className="pb-3">
        <CardTitle className="flex items-center justify-between text-green-800">
          <div className="flex items-center gap-2">
            {icon}
            {title}
          </div>
          {getTrendIcon(data.trend)}
        </CardTitle>
      </CardHeader>
      <CardContent>
        <div className="space-y-3">
          <div className="flex items-center justify-between">
            <span className="text-3xl font-bold text-green-600">
              {data.value}
              {unit}
            </span>
            <Badge className={`${getStatusColor(data.status)} flex items-center gap-1`}>
              {getStatusIcon(data.status)}
              {data.status === "optimal" ? "Óptimo" : data.status === "warning" ? "Precaución" : "Crítico"}
            </Badge>
          </div>
          <Progress value={data.value > 100 ? 100 : data.value} className="h-2" />
          <p className="text-sm text-green-600">{description}</p>
        </div>
      </CardContent>
    </Card>
  )

  return (
    <div className="min-h-screen bg-gradient-to-br from-green-50 to-amber-50 p-4">
      <div className="max-w-6xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4">
          <Button variant="outline" size="icon" className="border-green-200 bg-transparent">
            <ArrowLeft className="w-4 h-4" />
          </Button>
          <div>
            <h1 className="text-3xl font-bold text-green-800">Análisis Detallado</h1>
            <p className="text-green-600">
              {analysisData.date} - {analysisData.time}
            </p>
            <p className="text-sm text-green-500">{analysisData.location}</p>
          </div>
        </div>

        {/* Diagnosis Card */}
        <Card className="border-green-200 bg-green-50">
          <CardHeader>
            <CardTitle className="flex items-center gap-2 text-green-800">
              <Leaf className="w-5 h-5" />
              Diagnóstico Automático
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-3">
              <p className="text-green-700">
                <strong>Estado General:</strong> El suelo presenta condiciones mayormente favorables para el cultivo.
              </p>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="space-y-2">
                  <h4 className="font-semibold text-green-800">Aspectos Positivos:</h4>
                  <ul className="text-sm text-green-600 space-y-1">
                    <li>• pH en rango óptimo (6.5-7.0)</li>
                    <li>• Humedad adecuada para cultivos</li>
                    <li>• Temperatura ideal</li>
                    <li>• Buen nivel de potasio</li>
                  </ul>
                </div>
                <div className="space-y-2">
                  <h4 className="font-semibold text-red-800">Áreas de Mejora:</h4>
                  <ul className="text-sm text-red-600 space-y-1">
                    <li>• Fósforo por debajo del nivel óptimo</li>
                    <li>• Nitrógeno en descenso</li>
                    <li>• Requiere fertilización NPK</li>
                  </ul>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Analysis Tabs */}
        <Tabs defaultValue="physical" className="space-y-4">
          <TabsList className="grid w-full grid-cols-3 bg-green-100">
            <TabsTrigger value="physical" className="data-[state=active]:bg-green-600 data-[state=active]:text-white">
              Propiedades Físicas
            </TabsTrigger>
            <TabsTrigger value="chemical" className="data-[state=active]:bg-green-600 data-[state=active]:text-white">
              Propiedades Químicas
            </TabsTrigger>
            <TabsTrigger value="nutrients" className="data-[state=active]:bg-green-600 data-[state=active]:text-white">
              Nutrientes
            </TabsTrigger>
          </TabsList>

          <TabsContent value="physical" className="space-y-4">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <MetricCard
                title="Humedad"
                icon={<Droplets className="w-5 h-5" />}
                data={analysisData.humidity}
                unit="%"
                description="Nivel óptimo para la mayoría de cultivos"
              />
              <MetricCard
                title="Temperatura"
                icon={<Thermometer className="w-5 h-5" />}
                data={analysisData.temperature}
                unit="°C"
                description="Temperatura ideal para germinación"
              />
            </div>
          </TabsContent>

          <TabsContent value="chemical" className="space-y-4">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <MetricCard
                title="pH del Suelo"
                icon={<Zap className="w-5 h-5" />}
                data={analysisData.ph}
                description="Ligeramente ácido - Ideal para nutrientes"
              />
              <MetricCard
                title="Conductividad"
                icon={<Zap className="w-5 h-5" />}
                data={analysisData.conductivity}
                unit=" dS/m"
                description="Salinidad dentro del rango normal"
              />
              <MetricCard
                title="Materia Orgánica"
                icon={<Leaf className="w-5 h-5" />}
                data={analysisData.organicMatter}
                unit="%"
                description="Buen contenido de materia orgánica"
              />
            </div>
          </TabsContent>

          <TabsContent value="nutrients" className="space-y-4">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <MetricCard
                title="Nitrógeno (N)"
                icon={<Leaf className="w-5 h-5" />}
                data={analysisData.nitrogen}
                unit="%"
                description="Necesita fertilización nitrogenada"
              />
              <MetricCard
                title="Fósforo (P)"
                icon={<Leaf className="w-5 h-5" />}
                data={analysisData.phosphorus}
                unit="%"
                description="Nivel crítico - Aplicar fertilizante fosfórico"
              />
              <MetricCard
                title="Potasio (K)"
                icon={<Leaf className="w-5 h-5" />}
                data={analysisData.potassium}
                unit="%"
                description="Excelente nivel de potasio"
              />
            </div>
          </TabsContent>
        </Tabs>

        {/* Action Buttons */}
        <div className="flex flex-col sm:flex-row gap-4">
          <Button className="bg-green-600 hover:bg-green-700 text-white flex-1">Ver Recomendaciones</Button>
          <Button variant="outline" className="border-green-200 text-green-700 flex-1 bg-transparent">
            Exportar Reporte
          </Button>
          <Button variant="outline" className="border-green-200 text-green-700 flex-1 bg-transparent">
            Comparar con Anterior
          </Button>
        </div>
      </div>
    </div>
  )
}
