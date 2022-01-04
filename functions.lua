log = function (name, logvalue)
  local level = 'debug'
  (freeswitch.consoleLog)(level, '------>pesquisa_log_' .. name .. '......: ' .. tostring(logvalue) .. '<-----------\n')
end

converterData = function (intTempo)
  local tempoFormatado = string.match(tostring(intTempo), '%d%d%d%d%d%d%d%d%d%d')

  return os.date('!%Y-%m-%dT%H:%M:%S', tonumber(tempoFormatado))
end
