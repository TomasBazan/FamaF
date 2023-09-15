from commands import (close_connection, get_file_listing,
    get_metadata, get_slice,get_suma)
from constants import INVALID_COMMAND

# MAPEO DE LAS FUNCIONES CON SUS DESCRIPCCIONES Y CANTIDAD DE ARGUMETNOS

FUNCTION_MAP = {
    'get_file_listing': {
        'args_count': 0,
        'description': b'Return the list of files availables to download.\r\n',
        'command': get_file_listing,
        'dir': True
    },
    'quit': {
        'args_count': 0,
        'description': b'Close Connection.\r\n',
        'command': close_connection,
        'dir': False
    },
    'get_metadata': {
        'args_count': 1,
        'description': b'Return the metada of the file.\r\n',
        'command': get_metadata,
        'dir': True
    },
    'get_slice': {
        'args_count': 3,
        'description': b'Return a slice of the file.\r\n',
        'command': get_slice,
        'dir': True
    },'get_suma': {
        'args_count': 2,
        'description': b'Return the sum of two nums.\r\n',
        'command': get_suma,
        'dir': False
    },
}


def get_function(name):
    '''Devuelve la funcion o INVALID_COMMAND si no existe'''
    function = FUNCTION_MAP.get(name, None)
    if function is None:
        return INVALID_COMMAND
    return function
