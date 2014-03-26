from multiprocessing import Pool
from time import time
import sys

K = 5000
def CostlyFunction(z):
    r = 0
    for k in xrange(1, K+2):
        r += z ** (1 / k**1.5)
    return r


if __name__ == '__main__':
    currtime = time()
    pool = Pool(int(sys.argv[1]))
    pool.map(CostlyFunction, (i for i in xrange(1000)) )
    print time() - currtime

