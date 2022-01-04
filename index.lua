package.path = package.path .. ";" .. [[/usr/share/lua/5.1/?.lua]]
require('pesquisa_functions')

-- Variáveis do FreeSWITCH
local last_sent_callee_id_number = env:getHeader('last_sent_callee_id_number')
local origination_callee_id_name = env:getHeader('origination_callee_id_name')
local sip_from_user = env:getHeader('sip_from_user')
local hangup_time = session:getVariable('hangup_time')

log('last_sent_callee_id_number', env:getHeader('last_sent_callee_id_number'))
log('origination_callee_id_name', env:getHeader('origination_callee_id_name'))
log('sip_from_user', env:getHeader('sip_from_user'))
log('hangup_time', converterData(session:getVariable('hangup_time')))

-- Variável nota
local nota

-- Verificações para atribuir um valor para a variável nota
if origination_callee_id_name == '1001' then
  nota = 1
elseif origination_callee_id_name == '1002' then
  nota = 2
elseif origination_callee_id_name == '1003' then
  nota = 3
elseif origination_callee_id_name == '1004' then
  nota = 4
elseif origination_callee_id_name == '1005' then
  nota = 5
end

log('nota', nota)

-- Configurações do servidor de e-mail
smtp = require('socket.smtp')
ltn12 = require('ltn12')
mime = require('mime')

local SMTP_SERVER = ''
local SMTP_PASS = ''
local SMTP_PORT = 
local SMTP_USERNAME = ''

-- Montando o e-mail
from = '<>'

rcpt = {
  '<>'
}

mesgt = {
  headers = {
    to = 'Anderson <>',
    from = from,
    subject = ''
  },
  body = 'Número ' .. sip_from_user .. ' deu nota ' .. nota .. ' para o atendimento do ramal ' .. last_sent_callee_id_number
}

-- Enviando o e-mail
r, e = smtp.send{
  from = from,
  rcpt = rcpt,
  source = smtp.message(mesgt),
  server = SMTP_SERVER,
  port = SMTP_PORT,
  user = SMTP_USERNAME,
  password = SMTP_PASS
}

log('r', r)
log('e', e)
