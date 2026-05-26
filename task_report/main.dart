import 'database.dart';

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
        valor = converterValor(map['valor']),
        horas = converterHoras(map['horas']),
        super.fromMap(map);
}

class ItemTrabalho {

  int id;
  String titulo;

  ItemTrabalho ({

    required this.id,
    required this.titulo, 
});

ItemTrabalho.fromMap(Map<String, dynamic> map)
: id = map['id'],
titulo = (map['titulo'] ?? 'Sem título').toString().trim();

}

double converterValor(dynamic valor){

  if (valor == null || valor.toString().isEmpty){
    return 0.0;
  }

  String valorTexto = valor.toString();

  valorTexto = valorTexto.replaceAll('R\$', '');
  valorTexto = valorTexto.replaceAll(',', '.');
  valorTexto = valorTexto.replaceAll(' ', '');
  return double.tryParse(valorTexto) ?? 0.0;
}

int converterHoras(dynamic horas) {
  
  if (horas == null) {
    return 0;
  }

  return int.tryParse(horas.toString()) ?? 0;
}

void main(){

  List<Tarefa> tarefasConvertidas = [];

  for (var tarefaMap in dadosTarefas) {
    Tarefa novaTarefa = Tarefa.fromMap(tarefaMap);

    tarefasConvertidas.add(novaTarefa);
}

print('Tarefas convertidas:');

  for (var tarefa in tarefasConvertidas) {
  print('ID: ${tarefa.id}, Título: ${tarefa.titulo}, Responsável: ${tarefa.responsavel}, Status: ${tarefa.status}, Prioridade: ${tarefa.prioridade}, Valor: R\$ ${tarefa.valor.toStringAsFixed(2)}, Horas: ${tarefa.horas}');

}
}