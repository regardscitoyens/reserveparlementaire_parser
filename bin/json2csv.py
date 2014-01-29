import json
import sys

keys = ['id_beneficiaire', 'beneficiaire', 'descriptif', 'adresse', 'programme_budgetaire', 'id_acteur', 'civilite', 'nom', 'prenom', 'departement', 'groupe']

for key in keys:
  sys.stdout.write(key+";");
print("")

for arg in sys.argv[1:]:
  myfile = open(arg)
  data = json.load(myfile)

  for (num, subvention) in data.items():
    for key in keys:
      if (subvention[key]):
        sys.stdout.write(subvention[key].encode('utf-8').replace('\n', ' - ').replace('"', '')+";");
      else:
        sys.stdout.write(";");
    print("")
