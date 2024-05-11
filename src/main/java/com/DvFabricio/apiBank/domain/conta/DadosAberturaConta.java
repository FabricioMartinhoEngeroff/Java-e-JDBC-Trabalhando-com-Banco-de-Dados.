package com.DvFabricio.apiBank.domain.conta;

import com.DvFabricio.apiBank.domain.cliente.DadosCadastroCliente;

public record DadosAberturaConta(Integer numero, DadosCadastroCliente dadosCliente) {
}
