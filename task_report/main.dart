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

List<Tarefa> tarefasConcluidas = tarefasConvertidas
.where((tarefa) => tarefa.status == 'concluida').toList();

print('Tarefas concluidas:');
  if(tarefasConcluidas.isEmpty){
    print('Nenhuma tarefa concluída encontrada.');
  } else {
    for (var tarefa in tarefasConcluidas) {
      print('ID: ${tarefa.id}, Título: ${tarefa.titulo}, Responsável: ${tarefa.responsavel}, Status: ${tarefa.status}, Prioridade: ${tarefa.prioridade}, Valor: R\$ ${tarefa.valor.toStringAsFixed(2)}, Horas: ${tarefa.horas}');
    }
  }

List<Tarefa> tarefasEmAndamento = tarefasConvertidas
.where((tarefa) => tarefa.status == 'em andamento').toList();

print('Tarefas em andamento:');
  if(tarefasEmAndamento.isEmpty){
    print('Nenhuma tarefa em andamento encontrada.');
  } else {
    for (var tarefa in tarefasEmAndamento) {
      print('ID: ${tarefa.id}, Título: ${tarefa.titulo}, Responsável: ${tarefa.responsavel}, Status: ${tarefa.status}, Prioridade: ${tarefa.prioridade}, Valor: R\$ ${tarefa.valor.toStringAsFixed(2)}, Horas: ${tarefa.horas}');
    }
  }

List<Tarefa> tarefasPendentes = tarefasConvertidas
.where((tarefa) => tarefa.status == 'pendente').toList();

print('Tarefas pendentes:');
  if(tarefasPendentes.isEmpty){
    print('Nenhuma tarefa pendente encontrada.');
  } else {
    for (var tarefa in tarefasPendentes) {
      print('ID: ${tarefa.id}, Título: ${tarefa.titulo}, Responsável: ${tarefa.responsavel}, Status: ${tarefa.status}, Prioridade: ${tarefa.prioridade}, Valor: R\$ ${tarefa.valor.toStringAsFixed(2)}, Horas: ${tarefa.horas}');
    }
  }

List<Tarefa> tarefasCanceladas = tarefasConvertidas
.where((tarefa) => tarefa.status == 'cancelada').toList();

print('Tarefas canceladas:');
  if(tarefasCanceladas.isEmpty){
    print('Nenhuma tarefa cancelada encontrada.');
  } else {
    for (var tarefa in tarefasCanceladas) {
      print('ID: ${tarefa.id}, Título: ${tarefa.titulo}, Responsável: ${tarefa.responsavel}, Status: ${tarefa.status}, Prioridade: ${tarefa.prioridade}, Valor: R\$ ${tarefa.valor.toStringAsFixed(2)}, Horas: ${tarefa.horas}');
    }
  }

double valorTotalConcluidas = 0.0;

for (var tarefa in tarefasConcluidas){

  valorTotalConcluidas += tarefa.valor;
}
print('Valor total das tarefas concluídas: R\$ ${valorTotalConcluidas.toStringAsFixed(2)}');


double valorTotalPendentes = 0.0;
for (var tarefa in tarefasPendentes){

  valorTotalPendentes += tarefa.valor;
}

double mediaValorPendentes = 0.0;

mediaValorPendentes = tarefasPendentes.isNotEmpty ? valorTotalPendentes / tarefasPendentes.length : 0.0;
print('Média do valor das tarefas pendentes: R\$ ${mediaValorPendentes.toStringAsFixed(2)}');

}