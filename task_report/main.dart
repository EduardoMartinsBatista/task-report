class Tarefa extends ItemTrabalho{
 
  String responsavel;
  String status;
  String prioridade;
  double valor;
  int horas;

  Tarefa ({
   required super.id,
   required super.titulo,
    required this.responsavel,
    required this.status,
    required this.prioridade,
    required this.valor,
    required this.horas,
  });

  Tarefa.fromMap(Map<String, dynamic> map)
      : responsavel = (map['responsavel'] ?? 'Não informado').toString().trim(),
        status = (map['status'] ?? 'sem status').toString().trim(),
        prioridade = (map['prioridade'] ?? 'sem prioridade').toString().trim(),
        valor = map['valor'] ?? 0.0,
        horas = map['horas'] ?? 0,
        super.fromMap(map);
}

class ItemTrabalho {

  String id;
  String titulo;

  ItemTrabalho ({

    required this.id,
    required this.titulo, 
});

ItemTrabalho.fromMap(Map<String, dynamic> map)
: id = map['id'],
titulo = (map['titulo'] ?? 'Sem título').toString().trim();

}

double conveterValor(dynamic valor){

  if (valor == null) {
    return 0.0;
  }


  String valorTexto = valor.toString(){

  valorTexto = valorTexto.replaceAll('R\$', '').replaceAll(',', '.').replaceAll(' ', '');
  return converterValor;
}
}