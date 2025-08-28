"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Badge } from "@/components/ui/badge"
import { Progress } from "@/components/ui/progress"
import {
  Leaf,
  Droplets,
  Thermometer,
  Zap,
  CheckCircle,
  AlertTriangle,
  XCircle,
  Plus,
  Bluetooth,
  Wifi,
  TrendingUp,
  Sun,
  Eye,
  BookOpen,
  Lightbulb,
  History,
  Phone,
  Mail,
} from "lucide-react"

export default function IntuitiveAgriculturalApp() {
  const [currentScreen, setCurrentScreen] = useState("login")
  const [isConnected, setIsConnected] = useState(false)

  // Datos simulados del sensor
  const soilData = {
    ph: 6.8,
    humidity: 65,
    temperature: 22,
    nitrogen: 45,
    phosphorus: 38,
    potassium: 52,
    overallStatus: "good", // good, warning, critical
    lastUpdate: "Hace 5 minutos",
  }

  const getStatusInfo = (status: string) => {
    switch (status) {
      case "good":
        return {
          icon: CheckCircle,
          color: "text-green-600 bg-green-50",
          text: "EXCELENTE",
          message: "Tu suelo está perfecto para sembrar",
        }
      case "warning":
        return {
          icon: AlertTriangle,
          color: "text-yellow-600 bg-yellow-50",
          text: "NECESITA ATENCIÓN",
          message: "Algunos valores necesitan mejorarse",
        }
      case "critical":
        return {
          icon: XCircle,
          color: "text-red-600 bg-red-50",
          text: "URGENTE",
          message: "Requiere acción inmediata",
        }
      default:
        return {
          icon: CheckCircle,
          color: "text-gray-600 bg-gray-50",
          text: "SIN DATOS",
          message: "Conecta tu sensor",
        }
    }
  }

  const statusInfo = getStatusInfo(soilData.overallStatus)
  const StatusIcon = statusInfo.icon

  // Pantalla de Login Ultra Simple
  const LoginScreen = () => (
    <div className="min-h-screen bg-gradient-to-b from-green-50 to-green-100 flex items-center justify-center p-6">
      <Card className="w-full max-w-sm shadow-xl">
        <CardHeader className="text-center pb-2">
          <div className="mx-auto w-20 h-20 bg-green-600 rounded-full flex items-center justify-center mb-4">
            <Leaf className="w-10 h-10 text-white" />
          </div>
          <CardTitle className="text-3xl font-bold text-green-800 mb-2">SoilTech</CardTitle>
          <p className="text-green-600 text-lg">Tu asistente agrícola</p>
        </CardHeader>
        <CardContent className="space-y-6">
          <div className="space-y-4">
            <Input
              type="email"
              placeholder="Tu correo electrónico"
              className="h-14 text-lg border-2 border-green-200 focus:border-green-500"
            />
            <Input
              type="password"
              placeholder="Tu contraseña"
              className="h-14 text-lg border-2 border-green-200 focus:border-green-500"
            />
          </div>

          <Button
            onClick={() => setCurrentScreen("dashboard")}
            className="w-full h-14 text-lg bg-green-600 hover:bg-green-700"
          >
            Entrar
          </Button>

          <div className="text-center space-y-2">
            <Button variant="link" className="text-green-600 text-base">
              ¿Primera vez? Crear cuenta
            </Button>
            <Button variant="link" className="text-amber-600 text-base">
              ¿Olvidaste tu contraseña?
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  )

  // Dashboard Principal Ultra Intuitivo
  const DashboardScreen = () => (
    <div className="min-h-screen bg-gradient-to-b from-green-50 to-white">
      {/* Header con estado del sensor */}
      <div className="bg-white shadow-sm border-b border-green-100 p-4">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-2xl font-bold text-green-800">Mi Terreno</h1>
            <p className="text-green-600">Parcela Norte</p>
          </div>
          <div className="flex items-center gap-2">
            <div
              className={`flex items-center gap-2 px-3 py-2 rounded-full ${isConnected ? "bg-green-100" : "bg-red-100"}`}
            >
              <div className={`w-3 h-3 rounded-full ${isConnected ? "bg-green-500" : "bg-red-500"}`}></div>
              <span className={`text-sm font-medium ${isConnected ? "text-green-700" : "text-red-700"}`}>
                {isConnected ? "Sensor Conectado" : "Sin Sensor"}
              </span>
            </div>
          </div>
        </div>
      </div>

      <div className="p-4 space-y-6">
        {/* Estado General - MUY PROMINENTE */}
        <Card className={`${statusInfo.color} border-2 shadow-lg`}>
          <CardContent className="p-6">
            <div className="flex items-center gap-4">
              <div className="p-4 bg-white rounded-full shadow-md">
                <StatusIcon className="w-8 h-8 text-green-600" />
              </div>
              <div className="flex-1">
                <h2 className="text-2xl font-bold text-green-800 mb-1">{statusInfo.text}</h2>
                <p className="text-lg text-green-700">{statusInfo.message}</p>
                <p className="text-sm text-green-600 mt-2">Última actualización: {soilData.lastUpdate}</p>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Botón de Nuevo Análisis - MUY VISIBLE */}
        <Button
          onClick={() => alert("Iniciando nuevo análisis...")}
          className="w-full h-16 text-xl bg-blue-600 hover:bg-blue-700 shadow-lg"
        >
          <Plus className="w-6 h-6 mr-3" />
          Analizar Suelo Ahora
        </Button>

        {/* Métricas Principales - GRANDES Y CLARAS */}
        <div className="grid grid-cols-2 gap-4">
          <Card className="shadow-md hover:shadow-lg transition-shadow">
            <CardContent className="p-6 text-center">
              <div className="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <Zap className="w-8 h-8 text-blue-600" />
              </div>
              <div className="text-3xl font-bold text-blue-600 mb-2">{soilData.ph}</div>
              <div className="text-lg font-medium text-gray-700 mb-3">Acidez (pH)</div>
              <Progress value={(soilData.ph / 14) * 100} className="h-3" />
              <p className="text-sm text-gray-600 mt-2">
                {soilData.ph < 6 ? "Muy ácido" : soilData.ph > 7.5 ? "Muy alcalino" : "Perfecto"}
              </p>
            </CardContent>
          </Card>

          <Card className="shadow-md hover:shadow-lg transition-shadow">
            <CardContent className="p-6 text-center">
              <div className="w-16 h-16 bg-cyan-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <Droplets className="w-8 h-8 text-cyan-600" />
              </div>
              <div className="text-3xl font-bold text-cyan-600 mb-2">{soilData.humidity}%</div>
              <div className="text-lg font-medium text-gray-700 mb-3">Humedad</div>
              <Progress value={soilData.humidity} className="h-3" />
              <p className="text-sm text-gray-600 mt-2">
                {soilData.humidity < 40 ? "Muy seco" : soilData.humidity > 80 ? "Muy húmedo" : "Ideal"}
              </p>
            </CardContent>
          </Card>

          <Card className="shadow-md hover:shadow-lg transition-shadow">
            <CardContent className="p-6 text-center">
              <div className="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <Thermometer className="w-8 h-8 text-orange-600" />
              </div>
              <div className="text-3xl font-bold text-orange-600 mb-2">{soilData.temperature}°C</div>
              <div className="text-lg font-medium text-gray-700 mb-3">Temperatura</div>
              <Progress value={(soilData.temperature / 40) * 100} className="h-3" />
              <p className="text-sm text-gray-600 mt-2">
                {soilData.temperature < 15 ? "Frío" : soilData.temperature > 30 ? "Caliente" : "Perfecto"}
              </p>
            </CardContent>
          </Card>

          <Card className="shadow-md hover:shadow-lg transition-shadow">
            <CardContent className="p-6 text-center">
              <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <Leaf className="w-8 h-8 text-green-600" />
              </div>
              <div className="text-3xl font-bold text-green-600 mb-2">
                {Math.round((soilData.nitrogen + soilData.phosphorus + soilData.potassium) / 3)}%
              </div>
              <div className="text-lg font-medium text-gray-700 mb-3">Nutrientes</div>
              <Progress value={(soilData.nitrogen + soilData.phosphorus + soilData.potassium) / 3} className="h-3" />
              <p className="text-sm text-gray-600 mt-2">NPK Promedio</p>
            </CardContent>
          </Card>
        </div>

        {/* Acciones Rápidas - BOTONES GRANDES */}
        <div className="grid grid-cols-2 gap-4">
          <Button
            onClick={() => setCurrentScreen("recommendations")}
            variant="outline"
            className="h-20 text-lg border-2 border-green-200 hover:bg-green-50"
          >
            <Lightbulb className="w-6 h-6 mr-2" />
            <div>
              <div className="font-bold">¿Qué Sembrar?</div>
              <div className="text-sm text-gray-600">Recomendaciones</div>
            </div>
          </Button>

          <Button
            onClick={() => setCurrentScreen("sensor")}
            variant="outline"
            className="h-20 text-lg border-2 border-blue-200 hover:bg-blue-50"
          >
            <Bluetooth className="w-6 h-6 mr-2" />
            <div>
              <div className="font-bold">Conectar Sensor</div>
              <div className="text-sm text-gray-600">Bluetooth/WiFi</div>
            </div>
          </Button>
        </div>

        {/* Clima Actual */}
        <Card className="bg-gradient-to-r from-blue-50 to-cyan-50 border-blue-200">
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <h3 className="text-xl font-bold text-blue-800 mb-2">Clima Hoy</h3>
                <div className="flex items-center gap-4">
                  <div className="text-3xl font-bold text-blue-600">28°C</div>
                  <div>
                    <p className="text-blue-700 font-medium">Soleado</p>
                    <p className="text-blue-600 text-sm">Ideal para trabajar</p>
                  </div>
                </div>
              </div>
              <Sun className="w-16 h-16 text-yellow-500" />
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Navegación Inferior - ICONOS GRANDES */}
      <div className="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 shadow-lg">
        <div className="grid grid-cols-5 py-2">
          {[
            { id: "dashboard", icon: Leaf, label: "Inicio", active: true },
            { id: "analysis", icon: Eye, label: "Análisis", active: false },
            { id: "history", icon: History, label: "Historial", active: false },
            { id: "recommendations", icon: Lightbulb, label: "Consejos", active: false },
            { id: "education", icon: BookOpen, label: "Aprender", active: false },
          ].map((item) => {
            const Icon = item.icon
            return (
              <button
                key={item.id}
                onClick={() => setCurrentScreen(item.id)}
                className={`flex flex-col items-center py-3 px-2 ${item.active ? "text-green-600" : "text-gray-400"}`}
              >
                <Icon className="w-7 h-7 mb-1" />
                <span className="text-xs font-medium">{item.label}</span>
              </button>
            )
          })}
        </div>
      </div>
    </div>
  )

  // Pantalla de Conexión de Sensor - SUPER SIMPLE
  const SensorScreen = () => (
    <div className="min-h-screen bg-gradient-to-b from-blue-50 to-white">
      <div className="bg-white shadow-sm border-b border-blue-100 p-4">
        <div className="flex items-center gap-3">
          <Button variant="ghost" onClick={() => setCurrentScreen("dashboard")} className="p-2">
            ←
          </Button>
          <h1 className="text-2xl font-bold text-blue-800">Conectar Sensor</h1>
        </div>
      </div>

      <div className="p-4 space-y-6">
        {/* Estado de Conexión */}
        <Card className={`${isConnected ? "bg-green-50 border-green-200" : "bg-red-50 border-red-200"} border-2`}>
          <CardContent className="p-6 text-center">
            <div
              className={`w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4 ${
                isConnected ? "bg-green-100" : "bg-red-100"
              }`}
            >
              {isConnected ? (
                <CheckCircle className="w-10 h-10 text-green-600" />
              ) : (
                <XCircle className="w-10 h-10 text-red-600" />
              )}
            </div>
            <h2 className={`text-2xl font-bold mb-2 ${isConnected ? "text-green-800" : "text-red-800"}`}>
              {isConnected ? "Sensor Conectado" : "Sin Conexión"}
            </h2>
            <p className={`text-lg ${isConnected ? "text-green-700" : "text-red-700"}`}>
              {isConnected ? "Recibiendo datos del suelo" : "Necesitas conectar un sensor"}
            </p>
          </CardContent>
        </Card>

        {/* Botones de Conexión - MUY GRANDES */}
        <div className="space-y-4">
          <Button
            onClick={() => setIsConnected(!isConnected)}
            className="w-full h-20 text-xl bg-blue-600 hover:bg-blue-700"
          >
            <Bluetooth className="w-8 h-8 mr-4" />
            <div className="text-left">
              <div className="font-bold">Conectar por Bluetooth</div>
              <div className="text-sm opacity-90">Buscar sensores cercanos</div>
            </div>
          </Button>

          <Button
            variant="outline"
            className="w-full h-20 text-xl border-2 border-blue-200 hover:bg-blue-50 bg-transparent"
          >
            <Wifi className="w-8 h-8 mr-4" />
            <div className="text-left">
              <div className="font-bold">Conectar por WiFi</div>
              <div className="text-sm text-gray-600">Sensor en red local</div>
            </div>
          </Button>
        </div>

        {/* Instrucciones Simples */}
        <Card className="bg-blue-50 border-blue-200">
          <CardContent className="p-6">
            <h3 className="text-xl font-bold text-blue-800 mb-4">📋 Pasos Simples</h3>
            <div className="space-y-3">
              <div className="flex items-start gap-3">
                <div className="w-8 h-8 bg-blue-600 text-white rounded-full flex items-center justify-center font-bold text-sm">
                  1
                </div>
                <p className="text-blue-700 text-lg">Enciende tu sensor de suelo</p>
              </div>
              <div className="flex items-start gap-3">
                <div className="w-8 h-8 bg-blue-600 text-white rounded-full flex items-center justify-center font-bold text-sm">
                  2
                </div>
                <p className="text-blue-700 text-lg">Presiona "Conectar por Bluetooth"</p>
              </div>
              <div className="flex items-start gap-3">
                <div className="w-8 h-8 bg-blue-600 text-white rounded-full flex items-center justify-center font-bold text-sm">
                  3
                </div>
                <p className="text-blue-700 text-lg">Selecciona tu sensor de la lista</p>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Ayuda */}
        <Card className="bg-amber-50 border-amber-200">
          <CardContent className="p-6 text-center">
            <h3 className="text-xl font-bold text-amber-800 mb-3">¿Necesitas Ayuda?</h3>
            <div className="flex gap-4 justify-center">
              <Button variant="outline" className="border-amber-300 text-amber-700 bg-transparent">
                <Phone className="w-5 h-5 mr-2" />
                Llamar Soporte
              </Button>
              <Button variant="outline" className="border-amber-300 text-amber-700 bg-transparent">
                <Mail className="w-5 h-5 mr-2" />
                Enviar Email
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  )

  // Pantalla de Recomendaciones - VISUAL Y SIMPLE
  const RecommendationsScreen = () => (
    <div className="min-h-screen bg-gradient-to-b from-green-50 to-white">
      <div className="bg-white shadow-sm border-b border-green-100 p-4">
        <div className="flex items-center gap-3">
          <Button variant="ghost" onClick={() => setCurrentScreen("dashboard")} className="p-2">
            ←
          </Button>
          <h1 className="text-2xl font-bold text-green-800">¿Qué Sembrar?</h1>
        </div>
      </div>

      <div className="p-4 space-y-6">
        {/* Recomendaciones de Cultivos - MUY VISUALES */}
        <div className="space-y-4">
          {[
            {
              name: "Maíz",
              emoji: "🌽",
              compatibility: 95,
              season: "Primavera-Verano",
              reason: "Tu suelo tiene el pH perfecto y buena humedad",
              difficulty: "Fácil",
              profit: "Alto",
            },
            {
              name: "Frijol",
              emoji: "🫘",
              compatibility: 88,
              season: "Todo el año",
              reason: "Mejorará tu suelo agregando nitrógeno natural",
              difficulty: "Muy Fácil",
              profit: "Medio",
            },
            {
              name: "Tomate",
              emoji: "🍅",
              compatibility: 82,
              season: "Primavera",
              reason: "Buen precio en el mercado, necesita poco ajuste",
              difficulty: "Medio",
              profit: "Muy Alto",
            },
          ].map((crop, index) => (
            <Card key={index} className="shadow-lg hover:shadow-xl transition-shadow border-2 border-green-100">
              <CardContent className="p-6">
                <div className="flex items-start gap-4">
                  <div className="text-6xl">{crop.emoji}</div>
                  <div className="flex-1">
                    <div className="flex items-center gap-3 mb-3">
                      <h3 className="text-2xl font-bold text-green-800">{crop.name}</h3>
                      <Badge
                        className={`text-lg px-3 py-1 ${
                          crop.compatibility >= 90
                            ? "bg-green-100 text-green-800"
                            : crop.compatibility >= 80
                              ? "bg-yellow-100 text-yellow-800"
                              : "bg-red-100 text-red-800"
                        }`}
                      >
                        {crop.compatibility}% Recomendado
                      </Badge>
                    </div>

                    <div className="grid grid-cols-2 gap-4 mb-4">
                      <div>
                        <p className="text-sm text-gray-600">Temporada</p>
                        <p className="font-semibold text-green-700">{crop.season}</p>
                      </div>
                      <div>
                        <p className="text-sm text-gray-600">Dificultad</p>
                        <p className="font-semibold text-blue-700">{crop.difficulty}</p>
                      </div>
                      <div>
                        <p className="text-sm text-gray-600">Ganancia</p>
                        <p className="font-semibold text-purple-700">{crop.profit}</p>
                      </div>
                    </div>

                    <div className="bg-green-50 p-4 rounded-lg mb-4">
                      <p className="text-green-800 font-medium">💡 {crop.reason}</p>
                    </div>

                    <Button className="w-full h-12 text-lg bg-green-600 hover:bg-green-700">
                      Ver Guía Completa de {crop.name}
                    </Button>
                  </div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>

        {/* Mejoras del Suelo - ACCIONES CLARAS */}
        <Card className="bg-blue-50 border-blue-200 border-2">
          <CardHeader>
            <CardTitle className="text-2xl text-blue-800 flex items-center gap-3">
              <TrendingUp className="w-8 h-8" />
              Mejorar Tu Suelo
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="bg-white p-4 rounded-lg border-l-4 border-red-500">
              <h4 className="font-bold text-red-800 text-lg mb-2">🚨 URGENTE: Falta Fósforo</h4>
              <p className="text-red-700 mb-3">Tu suelo necesita fertilizante fosfórico</p>
              <Button className="bg-red-600 hover:bg-red-700 text-white">Comprar Fertilizante Ahora</Button>
            </div>

            <div className="bg-white p-4 rounded-lg border-l-4 border-yellow-500">
              <h4 className="font-bold text-yellow-800 text-lg mb-2">⚠️ Mejorar: Nitrógeno Bajo</h4>
              <p className="text-yellow-700 mb-3">Aplica urea en 2 semanas</p>
              <Button variant="outline" className="border-yellow-500 text-yellow-700 bg-transparent">
                Ver Instrucciones
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  )

  // Renderizar la pantalla actual
  const renderScreen = () => {
    switch (currentScreen) {
      case "login":
        return <LoginScreen />
      case "dashboard":
        return <DashboardScreen />
      case "sensor":
        return <SensorScreen />
      case "recommendations":
        return <RecommendationsScreen />
      default:
        return <DashboardScreen />
    }
  }

  return renderScreen()
}
