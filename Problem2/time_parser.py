#!/usr/local/bin python
# -*-coding:utf-8-*-

from datetime import datetime

time_record = [
    {1: False, 2: False, 3: False, 4: False, 5: False, 6: False, 7: False, 8: False, 9: False, 10: False, 11:False, 12:False}, # 2000
    {1: False, 2: False, 3: False, 4: False, 5: False, 6: False, 7: False, 8: False, 9: False, 10: False, 11:False, 12:False}, # 2001
    {1: False, 2: False, 3: False, 4: False, 5: False, 6: False, 7: False, 8: False, 9: False, 10: False, 11:False, 12:False}, # 2002
    {1: False, 2: False, 3: False, 4: False, 5: False, 6: False, 7: False, 8: False, 9: False, 10: False, 11:False, 12:False}, # 2003
]

def to_time_bin(year, month):
    global time_record
    year = int(year)
    month = int(month)
    time_record[year - 2000][month] = True
    if year == 2003:
        return 12
    if year == 2000:
        if (month == 4) or (month == 5) or (month == 6):
            return 1
        elif (month == 7) or (month == 8) or (month == 9):
            return 2
        elif (month == 10) or (month == 11) or (month == 12):
            return 3
    elif year == 2001:
        if (month == 1) or (month == 2) or (month == 3):
            return 4
        elif (month == 4) or (month == 5) or (month == 6):
            return 5
        elif (month == 7) or (month == 8) or (month == 9):
            return 6
        elif (month == 10) or (month == 11) or (month == 12):
            return 7
    elif year == 2002:
        if (month == 1) or (month == 2) or (month == 3):
            return 8
        elif (month == 4) or (month == 5) or (month == 6):
            return 9
        elif (month == 7) or (month == 8) or (month == 9):
            return 10
        elif (month == 10) or (month == 11) or (month == 12):
            return 11

def main():
    with open('ratings_train.csv', 'rb') as trainf, open('ratings_train_with_time.csv', 'wb') as outputf:
        lines = trainf.readlines()
        for line in lines:
            line = line.strip().split(',')
            timestamp = int(line[3])
            t = datetime.fromtimestamp(timestamp)
            output_str = ','.join(line) + ',' + str(t.year) + ',' + str(t.month) + ',' + str(t.day) + ',' + str(to_time_bin(t.year, t.month)) + '\n'
            outputf.write(output_str)
    with open('ratings_test.csv', 'rb') as trainf, open('ratings_test_with_time.csv', 'wb') as outputf:
        lines = trainf.readlines()
        for line in lines:
            line = line.strip().split(',')
            timestamp = int(line[3])
            t = datetime.fromtimestamp(timestamp)
            output_str = ','.join(line) + ',' + str(t.year) + ',' + str(t.month) + ',' + str(t.day) + ',' + str(to_time_bin(t.year, t.month)) + '\n'
            outputf.write(output_str)
if __name__ == "__main__":
    main()
    print time_record
    # 2000.4 - 2003.3
