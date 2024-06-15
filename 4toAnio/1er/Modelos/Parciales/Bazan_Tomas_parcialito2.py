from random import random
import numpy as np

def generarX():
    U=random()
    if U<0.22:
        return 1
    elif U<0.55:
        return 2
    elif U<0.72:
        return 3
    elif U<0.9999:
        return 4
    else:
        return 5
val = 0
for _ in range(100_000):
    val += generarX()
print(val/10_0000)
