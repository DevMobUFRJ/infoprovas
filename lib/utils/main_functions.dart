// Função que ordena a lista de tipos de prova
// entrada: lista de strings -> sendo cada string um tipo de prova.
// saida: lista ordenada.
void sortTypesList(List<String> typesList) =>
    typesList.sort((it, other) => compare(it, other));

// Função que compara se `it` é "maior" que `other`, retorna um inteiro.
// entrada: 2 strings -> it e other são 2 tipos de prova.
// saida: int positivo se it é maior que other, 0 caso int = other, int negativo
// caso it for menor que other.
int compare(String it, String other) =>
    evaluateType(it).compareTo(evaluateType(other));

// Função que "enumera" o tipo da prova por nível de importância,
// sendo 0 mais importante e crescentemente diminuindo a importância.
// entrada: String -> tipo de prova.
// saida: um inteiro para cada tipo de prova.
int evaluateType(String examType) {
  switch (examType) {
    case "Prova 1":
      return 0;
    case "Prova 2":
      return 1;
    case "Prova 3":
      return 2;
    case "Prova Final":
      return 3;
    case "2ª Chamada":
      return 4;
    case "Outros":
      return 5;
    default:
      return -1;
  }
}

Map<String, String> types = {
  "Prova 1": "P1",
  "Prova 2": "P2",
  "Prova 3": "P3",
  "Prova Final": "PF",
  "2ª Chamada" : "2ªCH",
  "Outros" : "Outros",
};

String getShortType(String type) => types[type] ?? "Default";