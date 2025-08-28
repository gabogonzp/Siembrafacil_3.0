"use client"

import { Card, CardContent, CardDescription, CardHeader } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Badge } from "@/components/ui/badge"
import { Progress } from "@/components/ui/progress"
import { PageTitle, CardTitle, BodyText, BodySmall, MetricLarge, Label, HelperText } from "@/components/ui/typography"
import { Thermometer, Droplets, Zap, Leaf, Sun, Plus, TrendingUp, AlertTriangle, CheckCircle } from "lucide-react"

export default function Dashboard() {
  const soilData = {
    ph: 6.8,
    humidity: 65,
    temperature: 22,
    nitrogen: 45,
    phosphorus: 38,
    potassium: 52,
    overallStatus: "optimal",
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
        return <CheckCircle className="w-5 h-5" />
      case "warning":
        return <AlertTriangle className="w-5 h-5" />
      case "critical":
        return <AlertTriangle className="w-5 h-5" />
      default:
        return <CheckCircle className="w-5 h-5" />
    }
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-green-50 to-amber-50 p-4">
      <div className="max-w-6xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
          <div>
            <PageTitle>Dashboard</PageTitle>
            <BodyText className="text-green-600">Estado actual de tu terreno</BodyText>
          </div>
          <Button className="bg-green-600 hover:bg-green-700 text-white">
            <Plus className="w-4 h-4 mr-2" />
            Nuevo Análisis
          </Button>
        </div>

        {/* Status Overview */}
        <Card className="border-green-200">
          <CardHeader>
            <CardTitle className="flex items-center gap-2 text-green-800">
              <Leaf className="w-5 h-5" />
              Estado General del Terreno
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex items-center gap-3">
              <Badge className={`${getStatusColor(soilData.overallStatus)} flex items-center gap-2`}>
                {getStatusIcon(soilData.overallStatus)}
                {soilData.overallStatus === "optimal"
                  ? "Óptimo"
                  : soilData.overallStatus === "warning"
                    ? "Precaución"
                    : "Crítico"}
              </Badge>
              <BodySmall className="text-green-600">Condiciones favorables para el cultivo</BodySmall>
            </div>
          </CardContent>
        </Card>

        {/* Main Metrics Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {/* pH Card */}
          <Card className="border-blue-200">
            <CardHeader className="pb-3">
              <CardTitle className="flex items-center gap-2 text-blue-800">
                <Zap className="w-5 h-5" />
                pH del Suelo
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                <MetricLarge className="text-blue-600">{soilData.ph}</MetricLarge>
                <Progress value={(soilData.ph / 14) * 100} className="h-2" />
                <HelperText className="text-blue-600">Ligeramente ácido - Ideal</HelperText>
              </div>
            </CardContent>
          </Card>

          {/* Humidity Card */}
          <Card className="border-cyan-200">
            <CardHeader className="pb-3">
              <CardTitle className="flex items-center gap-2 text-cyan-800">
                <Droplets className="w-5 h-5" />
                Humedad
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                <MetricLarge className="text-cyan-600">{soilData.humidity}%</MetricLarge>
                <Progress value={soilData.humidity} className="h-2" />
                <HelperText className="text-cyan-600">Nivel óptimo de humedad</HelperText>
              </div>
            </CardContent>
          </Card>

          {/* Temperature Card */}
          <Card className="border-orange-200">
            <CardHeader className="pb-3">
              <CardTitle className="flex items-center gap-2 text-orange-800">
                <Thermometer className="w-5 h-5" />
                Temperatura
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                <MetricLarge className="text-orange-600">{soilData.temperature}°C</MetricLarge>
                <Progress value={(soilData.temperature / 40) * 100} className="h-2" />
                <HelperText className="text-orange-600">Temperatura ideal</HelperText>
              </div>
            </CardContent>
          </Card>
        </div>

        {/* NPK Nutrients */}
        <Card className="border-green-200">
          <CardHeader>
            <CardTitle className="flex items-center gap-2 text-green-800">
              <Leaf className="w-5 h-5" />
              Nutrientes (NPK)
            </CardTitle>
            <CardDescription>Niveles de nitrógeno, fósforo y potasio</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div className="space-y-2">
                <div className="flex justify-between items-center">
                  <Label className="text-green-700">Nitrógeno (N)</Label>
                  <BodySmall className="text-green-600">{soilData.nitrogen}%</BodySmall>
                </div>
                <Progress value={soilData.nitrogen} className="h-2" />
              </div>
              <div className="space-y-2">
                <div className="flex justify-between items-center">
                  <Label className="text-green-700">Fósforo (P)</Label>
                  <BodySmall className="text-green-600">{soilData.phosphorus}%</BodySmall>
                </div>
                <Progress value={soilData.phosphorus} className="h-2" />
              </div>
              <div className="space-y-2">
                <div className="flex justify-between items-center">
                  <Label className="text-green-700">Potasio (K)</Label>
                  <BodySmall className="text-green-600">{soilData.potassium}%</BodySmall>
                </div>
                <Progress value={soilData.potassium} className="h-2" />
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Climate Info */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <Card className="border-amber-200">
            <CardHeader>
              <CardTitle className="flex items-center gap-2 text-amber-800">
                <Sun className="w-5 h-5" />
                Clima Actual
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="flex items-center justify-between">
                <div>
                  <MetricLarge className="text-amber-600">28°C</MetricLarge>
                  <BodySmall className="text-amber-600">Soleado</BodySmall>
                </div>
                <Sun className="w-12 h-12 text-amber-500" />
              </div>
            </CardContent>
          </Card>

          <Card className="border-green-200">
            <CardHeader>
              <CardTitle className="flex items-center gap-2 text-green-800">
                <TrendingUp className="w-5 h-5" />
                Tendencia
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-2">
                <BodySmall className="text-green-600">Mejora del 15% esta semana</BodySmall>
                <BodySmall className="text-green-600">Condiciones estables</BodySmall>
                <Badge className="bg-green-100 text-green-700">Tendencia positiva</Badge>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  )
}
