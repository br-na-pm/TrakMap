def main() -> None:
    string = ''
    string = string + '1,2 3,4 5,6'
    lista = string.split()

    listb = []
    for x in lista:
        templist = x.split(',')
        listb.append(templist)
    print(listb)

    # listx = []
    # listy = []
    # for y in listb:
    #     listx.append(y[0])
    #     listy.append(y[1])
    # print(listx)
    # print(listy)

main()