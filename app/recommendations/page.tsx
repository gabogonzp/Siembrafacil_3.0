"use client"

import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Badge } from "@/components/ui/badge"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { ArrowLeft, Droplets, Zap, Sun, Leaf, ChevronRight, Clock, TrendingUp } from "lucide-react"

export default function Recommendations() {
  const cropRecommendations = [
    {
      name: "Maíz",
      icon: "🌽",
      compatibility: 95,
      season: "Primavera-Verano",
      reason: "pH ideal y buena humedad",
      benefits: ["Alto rendimiento esperado", "Condiciones óptimas", "Buen drenaje"],
    },
    {
      name: "Frijol",
      icon: "🫘",
      compatibility: 88,
      season: "Todo el año",
      reason: "Excelente para fijar nitrógeno",
      benefits: ["Mejora el suelo", "Resistente", "Complementa otros cultivos"],
    },
    {
      name: "Tomate",
      icon: "🍅",
      compatibility: 82,
      season: "Primavera",
      reason: "Requiere ajuste menor de pH",
      benefits: ["Alto valor comercial", "Demanda constante", "Cultivo rentable"],
    },
    {
      name: "Lechuga",
      icon: "🥬",
      compatibility: 78,
      season: "Otoño-Invierno",
      reason: "Buena humedad, temperatura ideal",
      benefits: ["Ciclo corto", "Fácil manejo", "Mercado local"],
    },
  ]

  const soilImprovements = [
    {
      title: "Aplicar Fertilizante Fosfórico",
      priority: "Alta",
      icon: <Zap className="w-5 h-5" />,
      description: "El fósforo está en nivel crítico (38%). Aplicar 50kg/ha de superfosfato.",
      timeframe: "Inmediato",
      cost: "Medio",
      steps: [
        "Adquirir superfosfato triple (46% P2O5)",
        "Aplicar 50kg por hectárea",
        "Incorporar al suelo con rastra",
        "Regar ligeramente después de la aplicación",
      ],
    },
    {
      title: "Fertilización Nitrogenada",
      priority: "Media",
      icon: <Leaf className="w-5 h-5" />,
      description: "Nitrógeno en descenso (45%). Aplicar urea o sulfato de amonio.",
      timeframe: "1-2 semanas",
      cost: "Bajo",
      steps: [
        "Aplicar 30kg/ha de urea",
        "Dividir en 2 aplicaciones",
        "Aplicar cerca de las raíces",
        "Regar inmediatamente",
      ],
    },
    {
      title: "Optimizar Riego",
      priority: "Baja",
      icon: <Droplets className="w-5 h-5" />,
      description: "Mantener humedad actual (65%) con riego eficiente.",
      timeframe: "Continuo",
      cost: "Bajo",
      steps: [
        "Riego temprano en la mañana",
        "Evitar encharcamientos",
        "Usar mulch para conservar humedad",
        "Monitorear semanalmente",
      ],
    },
  ]

  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case "Alta":
        return "bg-red-100 text-red-700"
      case "Media":
        return "bg-yellow-100 text-yellow-700"
      case "Baja":
        return "bg-green-100 text-green-700"
      default:
        return "bg-gray-100 text-gray-700"
    }
  }

  const getCompatibilityColor = (compatibility: number) => {
    if (compatibility >= 90) return "text-green-600"
    if (compatibility >= 80) return "text-yellow-600"
    return "text-red-600"
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-green-50 to-amber-50 p-4">
      <div className="max-w-6xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4">
          <Button variant="outline" size="icon" className="border-green-200 bg-transparent">
            <ArrowLeft className="w-4 h-4" />
          </Button>
          <div>
            <h1 className="text-3xl font-bold text-green-800">Recomendaciones Inteligentes</h1>
            <p className="text-green-600">Basadas en tu análisis del 15 de Marzo, 2024</p>
          </div>
        </div>

        {/* Summary Card */}
        <Card className="border-green-200 bg-green-50">
          <CardHeader>
            <CardTitle className="flex items-center gap-2 text-green-800">
              <TrendingUp className="w-5 h-5" />
              Resumen de Recomendaciones
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div className="text-center">
                <div className="text-2xl font-bold text-green-600">4</div>
                <p className="text-sm text-green-600">Cultivos recomendados</p>
              </div>
              <div className="text-center">
                <div className="text-2xl font-bold text-yellow-600">3</div>
                <p className="text-sm text-yellow-600">Mejoras sugeridas</p>
              </div>
              <div className="text-center">
                <div className="text-2xl font-bold text-blue-600">85%</div>
                <p className="text-sm text-blue-600">Potencial del terreno</p>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Main Tabs */}
        <Tabs defaultValue="crops" className="space-y-4">
          <TabsList className="grid w-full grid-cols-2 bg-green-100">
            <TabsTrigger value="crops" className="data-[state=active]:bg-green-600 data-[state=active]:text-white">
              Qué Sembrar
            </TabsTrigger>
            <TabsTrigger
              value="improvements"
              className="data-[state=active]:bg-green-600 data-[state=active]:text-white"
            >
              Mejorar Terreno
            </TabsTrigger>
          </TabsList>

          <TabsContent value="crops" className="space-y-4">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {cropRecommendations.map((crop, index) => (
                <Card key={index} className="border-green-200 hover:shadow-md transition-shadow">
                  <CardHeader>
                    <CardTitle className="flex items-center justify-between">
                      <div className="flex items-center gap-3">
                        <span className="text-2xl">{crop.icon}</span>
                        <span className="text-green-800">{crop.name}</span>
                      </div>
                      <Badge className={`${getCompatibilityColor(crop.compatibility)} bg-transparent border`}>
                        {crop.compatibility}% compatible
                      </Badge>
                    </CardTitle>
                    <CardDescription className="flex items-center gap-2">
                      <Sun className="w-4 h-4" />
                      {crop.season}
                    </CardDescription>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <p className="text-sm text-green-600">
                      <strong>Por qué es ideal:</strong> {crop.reason}
                    </p>

                    <div>
                      <h4 className="font-semibold text-green-800 mb-2">Beneficios:</h4>
                      <ul className="text-sm text-green-600 space-y-1">
                        {crop.benefits.map((benefit, idx) => (
                          <li key={idx}>• {benefit}</li>
                        ))}
                      </ul>
                    </div>

                    <Button className="w-full bg-green-600 hover:bg-green-700 text-white">
                      Ver Guía de Cultivo
                      <ChevronRight className="w-4 h-4 ml-2" />
                    </Button>
                  </CardContent>
                </Card>
              ))}
            </div>
          </TabsContent>

          <TabsContent value="improvements" className="space-y-4">
            <div className="space-y-6">
              {soilImprovements.map((improvement, index) => (
                <Card key={index} className="border-green-200">
                  <CardHeader>
                    <CardTitle className="flex items-center justify-between">
                      <div className="flex items-center gap-3">
                        {improvement.icon}
                        <span className="text-green-800">{improvement.title}</span>
                      </div>
                      <div className="flex items-center gap-2">
                        <Badge className={getPriorityColor(improvement.priority)}>
                          Prioridad {improvement.priority}
                        </Badge>
                      </div>
                    </CardTitle>
                    <CardDescription>{improvement.description}</CardDescription>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 text-sm">
                      <div className="flex items-center gap-2">
                        <Clock className="w-4 h-4 text-green-500" />
                        <span className="text-green-600">
                          <strong>Tiempo:</strong> {improvement.timeframe}
                        </span>
                      </div>
                      <div className="flex items-center gap-2">
                        <span className="text-green-600">
                          <strong>Costo:</strong> {improvement.cost}
                        </span>
                      </div>
                    </div>

                    <div>
                      <h4 className="font-semibold text-green-800 mb-3">Pasos a seguir:</h4>
                      <div className="space-y-2">
                        {improvement.steps.map((step, idx) => (
                          <div key={idx} className="flex items-start gap-3">
                            <div className="w-6 h-6 bg-green-100 text-green-600 rounded-full flex items-center justify-center text-sm font-semibold flex-shrink-0 mt-0.5">
                              {idx + 1}
                            </div>
                            <p className="text-sm text-green-600">{step}</p>
                          </div>
                        ))}
                      </div>
                    </div>

                    <Button
                      variant="outline"
                      className="w-full border-green-200 text-green-700 hover:bg-green-50 bg-transparent"
                    >
                      Ver Más Detalles
                      <ChevronRight className="w-4 h-4 ml-2" />
                    </Button>
                  </CardContent>
                </Card>
              ))}
            </div>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  )
}
