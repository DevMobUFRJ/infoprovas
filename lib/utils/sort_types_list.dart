void sortTypesList(List<String> typesList) =>
    typesList.sort((it, other) => compare(it, other));

int compare(String it, String other) =>
    evaluateType(it).compareTo(evaluateType(other));

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