import os
import base64
from constants import DEFAULT_DIR, CODE_OK, FILE_NOT_FOUND, INVALID_ARGUMENTS, BAD_OFFSET

"""
EN ESTE ARCHIVO COLOCAMOS LAS DEFINICIONES DE LAS FUNCIONES QUE USAMOS EN NUESTRO CLIENTE
"""


def get_file_listing(directory):
    close = False
    files = os.listdir(directory)
    ret = f'{CODE_OK} OK\r\n'.encode('ascii')
    for i in files:
        ret += i.encode('ascii') + b'\r\n'
    return (CODE_OK, ret + b'\r\n', close)


def get_metadata(filename, directory):
    filepath = directory + filename
    close = False

    if len(filename) > 255:
        return (FILE_NOT_FOUND, f'\n {FILE_NOT_FOUND}.\r\n'.encode('ascii'), close)

    try:
        filestat = os.stat(filepath)
        ret = f'{CODE_OK} OK\r\n{filestat.st_size}\r\n'.encode('ascii')
        return (CODE_OK, ret, close)

    except FileNotFoundError:
        return (FILE_NOT_FOUND, f'\n {FILE_NOT_FOUND}.\r\n'.encode('ascii'), close)


def get_slice(filename, offset, size, directory):
    close = False
    fragment = ''
    try:
        offset_int = int(offset)
        size_int = int(size)
        file_size = os.stat(directory + filename).st_size

        if offset_int + size_int > file_size:
            return (BAD_OFFSET, f'\nERROR: {BAD_OFFSET}.\r\n'.encode('ascii'), close)
    except ValueError:
        return (INVALID_ARGUMENTS, f'\nERROR: {INVALID_ARGUMENTS}.\r\n'.encode('ascii'), close)

    try:
        f = open(directory + filename, 'rb')
    except FileNotFoundError:
        return (FILE_NOT_FOUND, f'\nERROR: {FILE_NOT_FOUND}.\r\n'.encode('ascii'), close)

    f.seek(offset_int)
    fragment = f.read(size_int)
    encoded_fragment = base64.b64encode(fragment)

    ret = f'{CODE_OK} OK\r\n{encoded_fragment.decode("ascii")}\r\n'.encode('ascii')
    return (CODE_OK, ret, close)


def close_connection():
    close = True
    ret = f'{CODE_OK} OK\r\n'.encode('ascii')
    return (CODE_OK, ret, close)

def get_suma(num1, num2):
    close = False
    try:
        numero1 = int(num1)
        numero2 = int(num2)
        suma = numero1 + numero2
        ret = f'{CODE_OK} Ok\r\n{suma}\r\n'.encode('ascii')
        return (CODE_OK, ret, close)
    except:
        ret = f'Invalid Arguments\r\n'
        return (INVALID_ARGUMENTS, ret, close)