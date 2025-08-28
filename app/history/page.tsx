"use client"

import { useState } from "react"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Badge } from "@/components/ui/badge"
import { Input } from "@/components/ui/input"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import {
  ArrowLeft,
  Calendar,
  Search,
  Filter,
  TrendingUp,
  TrendingDown,
  CheckCircle,
  AlertTriangle,
  XCircle,
  Eye,
  Download,
} from "lucide-react"

export default function AnalysisHistory() {
  const [searchTerm, setSearchTerm] = useState("")
  const [statusFilter, setStatusFilter] = useState("all")

  const historyData = [
    {
      id: 1,
      date: "15 Mar 2024",
      time: "14:30",
      location: "Parcela Norte",
      status: "optimal",
      ph: 6.8,
      humidity: 65,
      temperature: 22,
      trend: "up",
    },
    {
      id: 2,
      date: "10 Mar 2024",
      time: "09:15",
      location: "Parcela Sur",
      status: "warning",
      ph: 5.9,
      humidity: 45,
      temperature: 25,
      trend: "down",
    },
    {
      id: 3,
      date: "05 Mar 2024",
      time: "16:45",
      location: "Parcela Este",
      status: "critical",
      ph: 5.2,
      humidity: 30,
      temperature: 28,
      trend: "down",
    },
    {
      id: 4,
      date: "01 Mar 2024",
      time: "11:20",
      location: "Parcela Norte",
      status: "optimal",
      ph: 6.5,
      humidity: 70,
      temperature: 20,
      trend: "up",
    },
    {
      id: 5,
      date: "25 Feb 2024",
      time: "13:10",
      location: "Parcela Oeste",
      status: "warning",
      ph: 7.2,
      humidity: 55,
      temperature: 24,
      trend: "stable",
    },
  ]

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

  const getStatusText = (status: string) => {
    switch (status) {
      case "optimal":
        return "Óptimo"
      case "warning":
        return "Precaución"
      case "critical":
        return "Crítico"
      default:
        return "Desconocido"
    }
  }

  const getTrendIcon = (trend: string) => {
    switch (trend) {
      case "up":
        return <TrendingUp className="w-4 h-4 text-green-500" />
      case "down":
        return <TrendingDown className="w-4 h-4 text-red-500" />
      default:
        return null
    }
  }

  const filteredData = historyData.filter((item) => {
    const matchesSearch =
      item.location.toLowerCase().includes(searchTerm.toLowerCase()) ||
      item.date.toLowerCase().includes(searchTerm.toLowerCase())
    const matchesStatus = statusFilter === "all" || item.status === statusFilter
    return matchesSearch && matchesStatus
  })

  return (
    <div className="min-h-screen bg-gradient-to-br from-green-50 to-amber-50 p-4">
      <div className="max-w-6xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center gap-4">
          <Button variant="outline" size="icon" className="border-green-200 bg-transparent">
            <ArrowLeft className="w-4 h-4" />
          </Button>
          <div>
            <h1 className="text-3xl font-bold text-green-800">Historial de Análisis</h1>
            <p className="text-green-600">Revisa tus análisis anteriores</p>
          </div>
        </div>

        {/* Filters */}
        <Card className="border-green-200">
          <CardHeader>
            <CardTitle className="flex items-center gap-2 text-green-800">
              <Filter className="w-5 h-5" />
              Filtros
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex flex-col sm:flex-row gap-4">
              <div className="relative flex-1">
                <Search className="absolute left-3 top-3 h-4 w-4 text-green-500" />
                <Input
                  placeholder="Buscar por ubicación o fecha..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="pl-10 border-green-200 focus:border-green-500"
                />
              </div>
              <Select value={statusFilter} onValueChange={setStatusFilter}>
                <SelectTrigger className="w-full sm:w-48 border-green-200">
                  <SelectValue placeholder="Estado del suelo" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">Todos los estados</SelectItem>
                  <SelectItem value="optimal">Óptimo</SelectItem>
                  <SelectItem value="warning">Precaución</SelectItem>
                  <SelectItem value="critical">Crítico</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </CardContent>
        </Card>

        {/* Results Summary */}
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
          <Card className="border-green-200">
            <CardContent className="pt-6">
              <div className="text-center">
                <div className="text-2xl font-bold text-green-600">{filteredData.length}</div>
                <p className="text-sm text-green-600">Análisis encontrados</p>
              </div>
            </CardContent>
          </Card>
          <Card className="border-green-200">
            <CardContent className="pt-6">
              <div className="text-center">
                <div className="text-2xl font-bold text-green-600">
                  {filteredData.filter((item) => item.status === "optimal").length}
                </div>
                <p className="text-sm text-green-600">Estados óptimos</p>
              </div>
            </CardContent>
          </Card>
          <Card className="border-green-200">
            <CardContent className="pt-6">
              <div className="text-center">
                <div className="text-2xl font-bold text-red-600">
                  {filteredData.filter((item) => item.status === "critical").length}
                </div>
                <p className="text-sm text-red-600">Estados críticos</p>
              </div>
            </CardContent>
          </Card>
        </div>

        {/* History List */}
        <div className="space-y-4">
          {filteredData.map((analysis) => (
            <Card key={analysis.id} className="border-green-200 hover:shadow-md transition-shadow">
              <CardContent className="pt-6">
                <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                  <div className="flex-1">
                    <div className="flex items-center gap-3 mb-2">
                      <Calendar className="w-4 h-4 text-green-500" />
                      <span className="font-semibold text-green-800">{analysis.date}</span>
                      <span className="text-sm text-green-600">{analysis.time}</span>
                      {getTrendIcon(analysis.trend)}
                    </div>
                    <p className="text-green-600 mb-3">{analysis.location}</p>

                    <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 text-sm">
                      <div>
                        <span className="text-green-700 font-medium">pH:</span>
                        <span className="ml-1 text-green-600">{analysis.ph}</span>
                      </div>
                      <div>
                        <span className="text-green-700 font-medium">Humedad:</span>
                        <span className="ml-1 text-green-600">{analysis.humidity}%</span>
                      </div>
                      <div>
                        <span className="text-green-700 font-medium">Temp:</span>
                        <span className="ml-1 text-green-600">{analysis.temperature}°C</span>
                      </div>
                      <div>
                        <Badge className={`${getStatusColor(analysis.status)} flex items-center gap-1 w-fit`}>
                          {getStatusIcon(analysis.status)}
                          {getStatusText(analysis.status)}
                        </Badge>
                      </div>
                    </div>
                  </div>

                  <div className="flex gap-2">
                    <Button variant="outline" size="sm" className="border-green-200 text-green-700 bg-transparent">
                      <Eye className="w-4 h-4 mr-1" />
                      Ver
                    </Button>
                    <Button variant="outline" size="sm" className="border-green-200 text-green-700 bg-transparent">
                      <Download className="w-4 h-4 mr-1" />
                      Exportar
                    </Button>
                  </div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>

        {/* Empty State */}
        {filteredData.length === 0 && (
          <Card className="border-green-200">
            <CardContent className="pt-6">
              <div className="text-center py-8">
                <Calendar className="w-12 h-12 text-green-300 mx-auto mb-4" />
                <h3 className="text-lg font-semibold text-green-800 mb-2">No se encontraron análisis</h3>
                <p className="text-green-600 mb-4">Intenta ajustar los filtros o realizar un nuevo análisis</p>
                <Button className="bg-green-600 hover:bg-green-700 text-white">Nuevo Análisis</Button>
              </div>
            </CardContent>
          </Card>
        )}
      </div>
    </div>
  )
}
