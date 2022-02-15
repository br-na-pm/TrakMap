#First, gather the points into a string (ex: 'x1,y1 x2,y2, x3,y3') --------------------------------------------------------------------
str_var = '1.1,1.1 2.2,2.2 3.3,3.3 4.4,4.4 5.5,5.5 '
print(str_var)
print('')
#Second, split the long string at spaces -----------------------------------------------------------------------------------------------
points_w_commas = str_var.split(' ')
print(points_w_commas)
print('')
#Third, take each point pair (ex: 'x1,y1') and split at commas -------------------------------------------------------------------------
points = []
for pointpair in points_w_commas:
    #weed out any empty pairs
    if (len(pointpair) > 0):
        templist = pointpair.split(',')
        points.append(templist)
print(points)
print('')
#Fourth, take each x & y and add it to the x & y lists respectively --------------------------------------------------------------------
list_xcoords = []
list_ycoords = []
for coordinatepair in points:
    list_xcoords.append(coordinatepair[0])
    list_ycoords.append(coordinatepair[1])
print(list_xcoords)
print(list_ycoords)
print('')
#Fifth, convert the x list and y list into lists of numbers (lists should be of same length) -------------------------------------------
for i in range(0, len(list_xcoords)):
    list_xcoords[i] = float(list_xcoords[i])
    list_ycoords[i] = float(list_ycoords[i])
print(list_xcoords)
print(list_ycoords)
print('')
#Sixth, negate the x coords ------------------------------------------------------------------------------------------------------------
for i in range(0, len(list_xcoords)):
    list_xcoords[i] = -1 * list_xcoords[i]
print(list_xcoords)
print(list_ycoords)
print('')
#Seventh, convert the x list and y list back into lists of strings ---------------------------------------------------------------------
for i in range(0, len(list_xcoords)):
    list_xcoords[i] = str(list_xcoords[i])
    list_ycoords[i] = str(list_ycoords[i])
print(list_xcoords)
print(list_ycoords)
print('')
#Eighth, combine the x's and y's into the points string---------------------------------------------------------------------------------
str_var = ''
for i in range(0, len(list_xcoords)):
    str_var = str_var + list_xcoords[i] + ',' + list_ycoords[i] + ' '
print(str_var)
print('')