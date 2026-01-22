import mysql.connector

# CREDENTIALS ARE PUBLIC 
# le credenziali sono pubbliche, non le caricherei altrimenti!
db = mysql.connector.connect(
    host="relational.fel.cvut.cz",
    user="guest",
    password="ctu-relational",
    database="Same_gen"
    )

cursor = db.cursor()


cursor.execute("SELECT * FROM Same_gen.target")
models = cursor.fetchall()

i = 1
for model in models:
    print(f"begin(model({i})).")
    ## i genitori e i figli di entrambi i nomi
    cursor.execute(f"SELECT * FROM Same_gen.parent WHERE name1 IN (\"{model[0]}\", \"{model[1]}\") OR name2 IN (\"{model[0]}\", \"{model[1]}\")")
    parents_offsprings = cursor.fetchall()
    # voglio le loro relazioni same_gen ma non quelle dei nomi interessati
    string_names = "("
    for parent_offspring in parents_offsprings:
        if parent_offspring[0] != model[0] and parent_offspring[0] != model[1]:
            string_names += "\"" + parent_offspring[0] + "\"" + ","
        if parent_offspring[1] != model[0] and parent_offspring[1] != model[1]:
            string_names += "\"" + parent_offspring[1] + "\"" + ","
    string_names = string_names[:-1] + ")"
    ## adesso ho nonni e nipoti
    cursor.execute(f"SELECT * FROM Same_gen.parent WHERE name1 IN {string_names} OR name2 IN {string_names}")
    grandpas_nephews = cursor.fetchall()
    string_names = string_names[:-1]
    for grandpa_nephew in grandpas_nephews:
        if grandpa_nephew[0] != model[0] and grandpa_nephew[0] != model[1]:
            string_names += "," + "\"" + grandpa_nephew[0] + "\""
        if grandpa_nephew[1] != model[0] and grandpa_nephew[1] != model[1]:
            string_names += "," + "\"" + grandpa_nephew[1] + "\""
    string_names += ")"

    string_names_gn = "("
    for grandpa_nephew in grandpas_nephews:
        if grandpa_nephew[0] != model[0] and grandpa_nephew[0] != model[1]:
            string_names_gn += "\"" + grandpa_nephew[0] + "\"" + ","
        if grandpa_nephew[1] != model[0] and grandpa_nephew[1] != model[1]:
            string_names_gn += "\"" + grandpa_nephew[1] + "\"" + ","
    string_names_gn = string_names_gn[:-1] + ")"
    cursor.execute(f"SELECT * FROM Same_gen.same_gen WHERE name1 IN {string_names_gn} OR name2 IN {string_names_gn}")
    same_gens = cursor.fetchall()
    
    string_names = string_names[:-1] + "\"" + model[0] + "\"" + "," + "\"" + model[1] + "\"" + ")"
    # stampo le persone coinvolte
    cursor.execute(f"SELECT * FROM Same_gen.person WHERE name IN {string_names}")
    people = cursor.fetchall()
    for person in people:
        print(f"person({person[0]}).")
    print("\n")
    ## stampo tutti nonni, genitori, figli, nipoti
    for grandpa_nephew in grandpas_nephews:
        print(f"parent({grandpa_nephew[0]},{grandpa_nephew[1]}).")
    print("\n")
    
    # stampo same_gen di nonni e nipoti
    for same_gen in same_gens:
        if same_gen[0] != model[0] and same_gen[0] != model[1] and same_gen[1] != model[0] and same_gen[1] != model[1]:
            print(f"same_gen({same_gen[0]}, {same_gen[1]}).")
    print("\n")
    
    if model[2] == 1:
        print(f"target({model[0]}, {model[1]}).")
    else:
        print(f"neg(target({model[0]}, {model[1]})).")
    print(f"end(model({i})).")
    print("\n")
    i += 1


