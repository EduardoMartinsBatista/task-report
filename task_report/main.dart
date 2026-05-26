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
      : responsavel = map['responsavel'] ?? 'Sem responsável',
        status = map['status'],
        prioridade = map['prioridade'],
        valor = map['valor'],
        horas = map['horas'],
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
titulo = map['titulo'];

}