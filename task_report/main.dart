import 'database.dart';

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

void resumo(){
  print('ID: $id, Título: $titulo');}

}

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

  @override
  void resumo() {
    print('ID: $id, Título: $titulo, Prioridade: $prioridade');
}
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

class RelatorioTarefas {
 
 final List<Tarefa> _tarefas;

 RelatorioTarefas(this._tarefas);

 int get totalTarefas => _tarefas.length;

 int contarPorStatus(String status) => _tarefas.where((tarefa) => tarefa.status == status).length;
  }

void main(){

  // Convertendo os dados do banco para objetos Tarefa

  List<Tarefa> tarefasConvertidas = [];

  for (var tarefaMap in dadosTarefas) {
    Tarefa novaTarefa = Tarefa.fromMap(tarefaMap);

    tarefasConvertidas.add(novaTarefa);
}

print('---- Tarefas convertidas: ----');

  for (var tarefa in tarefasConvertidas) {
  print('ID: ${tarefa.id}, Título: ${tarefa.titulo}, Responsável: ${tarefa.responsavel}, Status: ${tarefa.status}, Prioridade: ${tarefa.prioridade}, Valor: R\$ ${tarefa.valor.toStringAsFixed(2)}, Horas: ${tarefa.horas}\n');

}

// Filtrando as tarefas por status

List<Tarefa> tarefasConcluidas = tarefasConvertidas
.where((tarefa) => tarefa.status == 'concluida').toList();

print('--- Tarefas concluidas:----');
  if(tarefasConcluidas.isEmpty){
    print('Nenhuma tarefa concluída encontrada.');
  } else {
    for (var tarefa in tarefasConcluidas) {
      print('ID: ${tarefa.id}, Título: ${tarefa.titulo}, Responsável: ${tarefa.responsavel}, Status: ${tarefa.status}, Prioridade: ${tarefa.prioridade}, Valor: R\$ ${tarefa.valor.toStringAsFixed(2)}, Horas: ${tarefa.horas}\n');
    }
  }

List<Tarefa> tarefasEmAndamento = tarefasConvertidas
.where((tarefa) => tarefa.status == 'em andamento').toList();

print('--- Tarefas em andamento:---');
  if(tarefasEmAndamento.isEmpty){
    print('Nenhuma tarefa em andamento encontrada.');
  } else {
    for (var tarefa in tarefasEmAndamento) {
      print('ID: ${tarefa.id}, Título: ${tarefa.titulo}, Responsável: ${tarefa.responsavel}, Status: ${tarefa.status}, Prioridade: ${tarefa.prioridade}, Valor: R\$ ${tarefa.valor.toStringAsFixed(2)}, Horas: ${tarefa.horas}\n');
    }
  }

List<Tarefa> tarefasPendentes = tarefasConvertidas
.where((tarefa) => tarefa.status == 'pendente').toList();

print('--- Tarefas pendentes:---');
  if(tarefasPendentes.isEmpty){
    print('Nenhuma tarefa pendente encontrada.');
  } else {
    for (var tarefa in tarefasPendentes) {
      print('ID: ${tarefa.id}, Título: ${tarefa.titulo}, Responsável: ${tarefa.responsavel}, Status: ${tarefa.status}, Prioridade: ${tarefa.prioridade}, Valor: R\$ ${tarefa.valor.toStringAsFixed(2)}, Horas: ${tarefa.horas}\n');
    }
  }

List<Tarefa> tarefasCanceladas = tarefasConvertidas
.where((tarefa) => tarefa.status == 'cancelada').toList();

print('--- Tarefas canceladas:---');
  if(tarefasCanceladas.isEmpty){
    print('Nenhuma tarefa cancelada encontrada.');
  } else {
    for (var tarefa in tarefasCanceladas) {
      print('ID: ${tarefa.id}, Título: ${tarefa.titulo}, Responsável: ${tarefa.responsavel}, Status: ${tarefa.status}, Prioridade: ${tarefa.prioridade}, Valor: R\$ ${tarefa.valor.toStringAsFixed(2)}, Horas: ${tarefa.horas}\n');
    }
  }

// Calculando o valor total das tarefas concluídas

double valorTotalConcluidas = 0.0;

for (var tarefa in tarefasConcluidas){

  valorTotalConcluidas += tarefa.valor;
}
print('Valor total das tarefas concluídas: R\$ ${valorTotalConcluidas.toStringAsFixed(2)}\n');

// Calculando a média do valor das tarefas pendentes

double valorTotalPendentes = 0.0;
for (var tarefa in tarefasPendentes){

  valorTotalPendentes += tarefa.valor;
}

double mediaValorPendentes = 0.0;

mediaValorPendentes = tarefasPendentes.isNotEmpty ? valorTotalPendentes / tarefasPendentes.length : 0.0;
print('Média do valor das tarefas pendentes: R\$ ${mediaValorPendentes.toStringAsFixed(2)}\n');

// Calculo de horas por status de tarefa

int horasConcluidas = 0;
for (var tarefa in tarefasConcluidas){

  horasConcluidas += tarefa.horas;
}

int horasEmAndamento = 0;
for (var tarefa in tarefasEmAndamento){

  horasEmAndamento += tarefa.horas;}

int horasPendentes = 0;
for (var tarefa in tarefasPendentes){
  horasPendentes += tarefa.horas;}

int horasCanceladas = 0;
for (var tarefa in tarefasCanceladas){
  horasCanceladas += tarefa.horas;}

print('Horas totais por staus: \n Concluídas: ${horasConcluidas} horas;\n Em andamento: ${horasEmAndamento} horas; \n Pendentes: ${horasPendentes} horas; \n Canceladas: ${horasCanceladas} horas.\n');

// Encontrando tarefas com valores nulos

print('\n--- TAREFAS COM DADOS INCOMPLETOS ---');

  for (var mapa in dadosTarefas) {
    List<String> problemas = [];

    if (mapa['titulo'] == null) problemas.add('título ausente');
    if (mapa['responsavel'] == null) problemas.add('responsável ausente');
    if (mapa['horas'] == null) problemas.add('horas ausentes');
    if (mapa['status'] == null || mapa['status'].toString().trim().isEmpty) problemas.add('status vazio');

    if (problemas.isNotEmpty) {
      print('- ID ${mapa['id']}: ${problemas.join(' ou ')}');
    }
}

Set<String> statusUnicos = {};

for (var tarefa in tarefasConvertidas){
  statusUnicos.add(tarefa.status);}

  print('\nStatus únicos encontrados: ${statusUnicos.join(', ')}');


// Criação do relatório final

print('\n--- RELATÓRIO FINAL ---\n');
print('Total de tarefas: ${tarefasConvertidas.length}\n');
print('Tarefas por status:');
print('Concluídas: ${tarefasConcluidas.length}');
print('Em andamento: ${tarefasEmAndamento.length}');
print('Pendentes: ${tarefasPendentes.length}');
print('Canceladas: ${tarefasCanceladas.length}\n');
print('Valor total das tarefas concluídas: R\$ ${valorTotalConcluidas.toStringAsFixed(2)}\n');
print('Média do valor das tarefas pendentes: R\$ ${mediaValorPendentes.toStringAsFixed(2)}\n');
print('Horas totais em tarefas concluídas: ${horasConcluidas} horas\n');
print('Status únicos encontrados: ${statusUnicos.join(', ')}\n');
print('Tarefas com dados incompletos:');
for (var mapa in dadosTarefas) {
    if (mapa['titulo'] == null || mapa['responsavel'] == null || mapa['horas'] == null) {
      print('ID ${mapa['id']} - ${mapa['titulo'] ?? "Sem título"}');}


}



}