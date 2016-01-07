#!/usr/local/bin python
# -*-coding:utf-8-*-

userid_list = []
movieid_list = []
timestamp_list = []

def parse_format(infile, outfile):
    lines = infile.readlines()
    i = -1
    for line in lines:
        i += 1
        values = line.strip().split(',')
        outlist = [userid_list[i], movieid_list[i], values[0], timestamp_list[i]]
        outfile.write('::'.join(outlist) + '\n')

def main():
    global userid_list
    global movieid_list
    global timestamp_list
    with open('ratings_test.csv', 'rb') as testfile:
        lines = testfile.readlines()
        for line in lines:
            v = line.strip().split(',')
            userid_list.append(v[0])
            movieid_list.append(v[1])
            timestamp_list.append(v[3])
    with open('baseline_predict.csv', 'rb') as csv1, \
         open('neighbour_predict_1.csv', 'rb') as csv2, \
         open('neighbour_predict_2.csv', 'rb') as csv3, \
         open('incorporating_temporal_dynamics_predict.csv', 'rb') as csv4, \
         open('baseline_predict.dat', 'wb') as out1, \
         open('neighbour_item_predict.dat', 'wb') as out2, \
         open('neighbour_user_predict.dat', 'wb') as out3, \
         open('temporal_dynamics_predict.dat', 'wb') as out4:
         parse_format(csv1, out1)
         parse_format(csv2, out2)
         parse_format(csv3, out3)
         parse_format(csv4, out4)


if __name__ == '__main__':
    main()