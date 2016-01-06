#!/usr/local/bin python
# -*-coding:utf-8-*-

# Created by 1352847 Junpeng Ouyang on 2015/12/24

from operator import itemgetter

# Global Variables
RATINGS_COUNT = 1000000
USER_COUNT = 6040


# Main Function
def main():
    try:
        with open('./ratings.dat', 'rb') as f_movie, \
             open('./ratings_train.txt', 'wb') as f_movie_train, \
             open('./ratings_test.txt', 'wb') as f_movie_test:
            # Read data from movies.dat and sort
            rating_lines = f_movie.readlines()

            # c = user_rank_movie_count[i] represents user #i has c ranks in total
            user_rank_movie_count = [0] * (USER_COUNT + 1)

            for line_idx in xrange(len(rating_lines)):
                line = rating_lines[line_idx].strip() # Clear ' ', '\n'
                line = map(int, line.split('::'))     # line_dt example: [1, 1193, 5, 978300760]
                user_id = line[0]
                user_rank_movie_count[user_id] += 1
                rating_lines[line_idx] = line
            # After covert strings into arrays, we sort by timestamp (line[3])
            rating_lines = sorted(rating_lines, key=itemgetter(0, 3))
            # We calculate how many movies each user should contribute
            selected_train_dt_count = map(lambda x: int(float(x) * 0.9), user_rank_movie_count)
            # The remaining will be used as validation data
            selected_test_dt_count = [0] * (USER_COUNT + 1)
            for idx in xrange(USER_COUNT + 1):
                selected_test_dt_count[idx] = user_rank_movie_count[idx] - selected_train_dt_count[idx]

            # Output filtered data
            last_user_id, counter, ln_count = 0, 0, 0
            for line in rating_lines:
                ln_count += 1
                user_id = line[0]
                if user_id != last_user_id:
                    counter = 0
                    last_user_id = user_id
                counter += 1
                print line
                output = '%d,%d,%d,%d\n' % tuple(line)
                if counter <= selected_train_dt_count[user_id]:
                    # This should be a training data line
                    f_movie_train.write(output)
                    print output + (' => user %d, train' % (user_id,))
                else:
                    # This should be a test data line
                    f_movie_test.write(output)
                    print output + (' => user %d, test' % (user_id,))
    except IOError:
        print 'Unable to open dataSets. Abort.'


if __name__ == '__main__':
    main()