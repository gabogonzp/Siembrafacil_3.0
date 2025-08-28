"use client"

import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Badge } from "@/components/ui/badge"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import {
  ArrowLeft,
  BookOpen,
  Lightbulb,
  Thermometer,
  Droplets,
  Zap,
  Leaf,
  Sprout,
  ChevronRight,
  Play,
  Clock,
  Star,
} from "lucide-react"

export default function Education() {
  const basicConcepts = [
    {
      title: "¿Qué es el pH del suelo?",
      icon: <Zap className="w-6 h-6" />,
      difficulty: "Básico",
      readTime: "3 min",
      description: "Aprende qué significa el pH y por qué es crucial para tus cultivos",
      content:
        "El pH mide qué tan ácido o alcalino es tu suelo. Un pH de 7 es neutro, menos de 7 es ácido y más de 7 es alcalino.",
      tips: [
        "pH ideal para la mayoría de cultivos: 6.0-7.0",
        "Suelos ácidos (pH < 6): añadir cal",
        "Suelos alcalinos (pH > 8): añadir azufre",
        "Medir pH cada 6 meses",
      ],
    },
    {
      title: "Importancia de la Humedad",
      icon: <Droplets className="w-6 h-6" />,
      difficulty: "Básico",
      readTime: "4 min",
      description: "Cómo mantener el nivel correcto de agua en tu suelo",
      content: "La humedad del suelo afecta directamente el crecimiento de las plantas y la absorción de nutrientes.",
      tips: [
        "Humedad ideal: 50-70% para la mayoría de cultivos",
        "Regar temprano en la mañana",
        "Usar mulch para conservar humedad",
        "Evitar encharcamientos",
      ],
    },
    {
      title: "Nutrientes NPK Explicados",
      icon: <Leaf className="w-6 h-6" />,
      difficulty: "Intermedio",
      readTime: "5 min",
      description: "Nitrógeno, Fósforo y Potasio: los nutrientes esenciales",
      content: "NPK son los tres nutrientes principales que necesitan las plantas para crecer saludables.",
      tips: [
        "N (Nitrógeno): crecimiento de hojas verdes",
        "P (Fósforo): desarrollo de raíces y flores",
        "K (Potasio): resistencia a enfermedades",
        "Aplicar según la etapa de crecimiento",
      ],
    },
    {
      title: "Temperatura del Suelo",
      icon: <Thermometer className="w-6 h-6" />,
      difficulty: "Básico",
      readTime: "3 min",
      description: "Cómo la temperatura afecta el crecimiento de tus plantas",
      content: "La temperatura del suelo influye en la germinación, crecimiento de raíces y actividad microbiana.",
      tips: [
        "Temperatura ideal: 18-24°C para la mayoría",
        "Usar mulch para regular temperatura",
        "Plantar según la estación",
        "Proteger del frío extremo",
      ],
    },
  ]

  const bestPractices = [
    {
      title: "Rotación de Cultivos",
      icon: <Sprout className="w-6 h-6" />,
      category: "Manejo",
      description: "Alterna diferentes cultivos para mantener la salud del suelo",
      benefits: ["Previene plagas", "Mejora fertilidad", "Reduce enfermedades"],
      steps: [
        "Planifica rotación de 3-4 años",
        "Alterna cultivos de diferentes familias",
        "Incluye leguminosas para fijar nitrógeno",
        "Registra qué plantas en cada área",
      ],
    },
    {
      title: "Compostaje Casero",
      icon: <Leaf className="w-6 h-6" />,
      category: "Fertilización",
      description: "Crea tu propio abono orgánico con residuos caseros",
      benefits: ["Reduce residuos", "Mejora suelo", "Ahorra dinero"],
      steps: [
        "Mezcla materiales verdes y marrones",
        "Mantén humedad adecuada",
        "Voltea cada 2 semanas",
        "Usa cuando esté oscuro y sin olor",
      ],
    },
    {
      title: "Riego Eficiente",
      icon: <Droplets className="w-6 h-6" />,
      category: "Agua",
      description: "Técnicas para optimizar el uso del agua",
      benefits: ["Ahorra agua", "Mejor crecimiento", "Reduce costos"],
      steps: [
        "Riega temprano en la mañana",
        "Usa riego por goteo si es posible",
        "Aplica mulch alrededor de plantas",
        "Monitorea humedad del suelo",
      ],
    },
  ]

  const interpretationGuide = [
    {
      parameter: "pH",
      ranges: [
        { range: "< 5.5", status: "Muy ácido", color: "text-red-600", action: "Aplicar cal agrícola" },
        { range: "5.5-6.0", status: "Ácido", color: "text-orange-600", action: "Aplicar cal moderadamente" },
        { range: "6.0-7.0", status: "Ideal", color: "text-green-600", action: "Mantener nivel actual" },
        { range: "7.0-8.0", status: "Alcalino", color: "text-orange-600", action: "Aplicar azufre" },
        { range: "> 8.0", status: "Muy alcalino", color: "text-red-600", action: "Aplicar azufre y materia orgánica" },
      ],
    },
    {
      parameter: "Humedad (%)",
      ranges: [
        { range: "< 30", status: "Muy seco", color: "text-red-600", action: "Riego inmediato" },
        { range: "30-50", status: "Seco", color: "text-orange-600", action: "Aumentar riego" },
        { range: "50-70", status: "Ideal", color: "text-green-600", action: "Mantener nivel" },
        { range: "70-85", status: "Húmedo", color: "text-orange-600", action: "Reducir riego" },
        { range: "> 85", status: "Saturado", color: "text-red-600", action: "Mejorar drenaje" },
      ],
    },
  ]

  const getDifficultyColor = (difficulty: string) => {
    switch (difficulty) {
      case "Básico":
        return "bg-green-100 text-green-700"
      case "Intermedio":
        return "bg-yellow-100 text-yellow-700"
      case "Avanzado":
        return "bg-red-100 text-red-700"
      default:
        return "bg-gray-100 text-gray-700"
    }
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
            <h1 className="text-3xl font-bold text-green-800">Centro Educativo</h1>
            <p className="text-green-600">Aprende sobre agricultura y análisis de suelo</p>
          </div>
        </div>

        {/* Quick Stats */}
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
          <Card className="border-green-200">
            <CardContent className="pt-6">
              <div className="text-center">
                <BookOpen className="w-8 h-8 text-green-600 mx-auto mb-2" />
                <div className="text-2xl font-bold text-green-600">{basicConcepts.length}</div>
                <p className="text-sm text-green-600">Conceptos básicos</p>
              </div>
            </CardContent>
          </Card>
          <Card className="border-green-200">
            <CardContent className="pt-6">
              <div className="text-center">
                <Lightbulb className="w-8 h-8 text-green-600 mx-auto mb-2" />
                <div className="text-2xl font-bold text-green-600">{bestPractices.length}</div>
                <p className="text-sm text-green-600">Buenas prácticas</p>
              </div>
            </CardContent>
          </Card>
          <Card className="border-green-200">
            <CardContent className="pt-6">
              <div className="text-center">
                <Star className="w-8 h-8 text-green-600 mx-auto mb-2" />
                <div className="text-2xl font-bold text-green-600">2</div>
                <p className="text-sm text-green-600">Guías de interpretación</p>
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Main Tabs */}
        <Tabs defaultValue="concepts" className="space-y-4">
          <TabsList className="grid w-full grid-cols-3 bg-green-100">
            <TabsTrigger value="concepts" className="data-[state=active]:bg-green-600 data-[state=active]:text-white">
              Conceptos Básicos
            </TabsTrigger>
            <TabsTrigger value="practices" className="data-[state=active]:bg-green-600 data-[state=active]:text-white">
              Buenas Prácticas
            </TabsTrigger>
            <TabsTrigger
              value="interpretation"
              className="data-[state=active]:bg-green-600 data-[state=active]:text-white"
            >
              Interpretar Datos
            </TabsTrigger>
          </TabsList>

          <TabsContent value="concepts" className="space-y-4">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {basicConcepts.map((concept, index) => (
                <Card key={index} className="border-green-200 hover:shadow-md transition-shadow">
                  <CardHeader>
                    <CardTitle className="flex items-center justify-between">
                      <div className="flex items-center gap-3">
                        <div className="p-2 bg-green-100 rounded-lg">{concept.icon}</div>
                        <span className="text-green-800">{concept.title}</span>
                      </div>
                      <div className="flex items-center gap-2">
                        <Badge className={getDifficultyColor(concept.difficulty)}>{concept.difficulty}</Badge>
                      </div>
                    </CardTitle>
                    <CardDescription className="flex items-center gap-2">
                      <Clock className="w-4 h-4" />
                      {concept.readTime} de lectura
                    </CardDescription>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <p className="text-sm text-green-600">{concept.description}</p>
                    <p className="text-sm text-green-700">{concept.content}</p>

                    <div>
                      <h4 className="font-semibold text-green-800 mb-2">Consejos clave:</h4>
                      <ul className="text-sm text-green-600 space-y-1">
                        {concept.tips.map((tip, idx) => (
                          <li key={idx}>• {tip}</li>
                        ))}
                      </ul>
                    </div>

                    <Button className="w-full bg-green-600 hover:bg-green-700 text-white">
                      <Play className="w-4 h-4 mr-2" />
                      Leer Artículo Completo
                    </Button>
                  </CardContent>
                </Card>
              ))}
            </div>
          </TabsContent>

          <TabsContent value="practices" className="space-y-4">
            <div className="space-y-6">
              {bestPractices.map((practice, index) => (
                <Card key={index} className="border-green-200">
                  <CardHeader>
                    <CardTitle className="flex items-center gap-3">
                      <div className="p-2 bg-green-100 rounded-lg">{practice.icon}</div>
                      <div>
                        <span className="text-green-800">{practice.title}</span>
                        <Badge className="ml-2 bg-blue-100 text-blue-700">{practice.category}</Badge>
                      </div>
                    </CardTitle>
                    <CardDescription>{practice.description}</CardDescription>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div>
                      <h4 className="font-semibold text-green-800 mb-2">Beneficios:</h4>
                      <div className="flex flex-wrap gap-2">
                        {practice.benefits.map((benefit, idx) => (
                          <Badge key={idx} className="bg-green-100 text-green-700">
                            {benefit}
                          </Badge>
                        ))}
                      </div>
                    </div>

                    <div>
                      <h4 className="font-semibold text-green-800 mb-3">Pasos a seguir:</h4>
                      <div className="space-y-2">
                        {practice.steps.map((step, idx) => (
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
                      Ver Guía Detallada
                      <ChevronRight className="w-4 h-4 ml-2" />
                    </Button>
                  </CardContent>
                </Card>
              ))}
            </div>
          </TabsContent>

          <TabsContent value="interpretation" className="space-y-4">
            <Card className="border-green-200">
              <CardHeader>
                <CardTitle className="flex items-center gap-2 text-green-800">
                  <BookOpen className="w-5 h-5" />
                  Cómo Interpretar los Datos del Sensor
                </CardTitle>
                <CardDescription>Aprende a entender qué significan los valores y cómo actuar</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-6">
                  {interpretationGuide.map((guide, index) => (
                    <div key={index}>
                      <h3 className="text-lg font-semibold text-green-800 mb-4">{guide.parameter}</h3>
                      <div className="space-y-3">
                        {guide.ranges.map((range, idx) => (
                          <div
                            key={idx}
                            className="flex items-center justify-between p-3 bg-white rounded-lg border border-green-100"
                          >
                            <div className="flex items-center gap-4">
                              <Badge className="bg-gray-100 text-gray-700 font-mono">{range.range}</Badge>
                              <span className={`font-medium ${range.color}`}>{range.status}</span>
                            </div>
                            <span className="text-sm text-green-600">{range.action}</span>
                          </div>
                        ))}
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>

            <Card className="border-green-200 bg-green-50">
              <CardHeader>
                <CardTitle className="text-green-800">Consejos Generales</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <h4 className="font-semibold text-green-800 mb-2">Frecuencia de Medición:</h4>
                    <ul className="text-sm text-green-600 space-y-1">
                      <li>• pH: cada 6 meses</li>
                      <li>• Humedad: semanal</li>
                      <li>• Temperatura: diaria</li>
                      <li>• Nutrientes: cada 3 meses</li>
                    </ul>
                  </div>
                  <div>
                    <h4 className="font-semibold text-green-800 mb-2">Mejores Momentos:</h4>
                    <ul className="text-sm text-green-600 space-y-1">
                      <li>• Mañana temprano (6-8 AM)</li>
                      <li>• Suelo sin riego reciente</li>
                      <li>• Clima estable</li>
                      <li>• Antes de fertilizar</li>
                    </ul>
                  </div>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  )
}
