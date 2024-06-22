def sort(items):

    for j in range(0, len(items)-1):

        for i in range(0, len(items)-1):
                
            if items[i] > items[i+1]:

                items[i], items[i+1] = items[i+1], items[i]

    return items

a = [3,2,1]
sort(a)
print(a)