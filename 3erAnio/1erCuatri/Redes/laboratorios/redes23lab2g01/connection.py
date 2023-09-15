# encoding: utf-8
# Revisión 2019 (a Python 3 y base64): Pablo Ventura
# Copyright 2014 Carlos Bederián
# $Id: connection.py 455 2011-05-01 00:32:09Z carlos $

from constants import (BAD_EOL, BUFFER_SIZE, CODE_OK, INVALID_ARGUMENTS,
    INVALID_COMMAND, error_messages)
from mapping import get_function


class Connection(object):
    """
    Conexión punto a punto entre el servidor y un cliente.
    Se encarga de satisfacer los pedidos del cliente hasta
    que termina la conexión.
    """

    def __init__(self, socket_client, directory):
        self.s = socket_client
        self.dir = directory

    def _call_quit(self):
        comand_data, uses_dir = self._get_comand_data('quit', 0)
        status, ret, close = comand_data['command']()
        if status == CODE_OK:
            self.s.send(ret)
            self.s.close()
        return close

    def _get_buffer_data(self, sock):
        '''Obtiene los datos del buffer.'''
        datos = b""
        buff_size = BUFFER_SIZE
        while b'\r\n' not in datos:
            parte = sock.recv(buff_size)
            datos += parte
        return datos

    def _get_comand_data(self, comand, args_count):
        '''Checkea errores y obtiene la funcion a ejecutar.'''
        comand_data = get_function(comand)
        if comand_data == INVALID_COMMAND:
            return INVALID_COMMAND, None
        elif args_count != comand_data['args_count']:
            return INVALID_ARGUMENTS, None
        return comand_data, comand_data['dir']

    def handle(self):
        """Atiende eventos de la conexión hasta que termina."""
        close = False
        buffer = self._get_buffer_data(self.s)

        for datos in buffer.split(b'\r\n'):
            if b'\n' in datos[:-2]:
                error_code = BAD_EOL
                error_message = error_messages[error_code].encode(
                    'ascii').decode('ascii')
                message_string = f"{error_code} {error_message}\r\n"
                message_bytes = message_string.encode('ascii')
                self.s.send(message_bytes)
                return self._call_quit()

            comand_list = datos.decode('ascii').split(' ')

            args_count = len(comand_list) - 1
            comand_data, uses_dir = self._get_comand_data(comand_list[0], args_count)

            if comand_data == INVALID_ARGUMENTS:
                error_code = INVALID_ARGUMENTS
                error_message = error_messages[error_code].encode(
                    'ascii').decode('ascii')
                message_string = f"{error_code} {error_message}\r\n"
                message_bytes = message_string.encode('ascii')
                self.s.send(message_bytes)
            elif comand_data == INVALID_COMMAND:
                error_code = INVALID_COMMAND
                error_message = error_messages[error_code].encode(
                    'ascii').decode('ascii')
                message_string = f"{error_code} {error_message}\r\n"
                message_bytes = message_string.encode('ascii')
                self.s.send(message_bytes)
            else:
                args = []
                if args_count > 0:
                    args = comand_list[1:]

                if uses_dir:
                    args.append(self.dir)

                status, ret, close = comand_data['command'](*args)
                if close:
                    print(ret)
                    if status == CODE_OK:
                        self.s.send(ret)
                    return self._call_quit()
                elif status == CODE_OK:
                    # Envía los bytes a traves de la conexion del socket
                    aux_ret = ret
                    while True:
                        # Es lo mismo que enviar el archivo entero solo que
                        # Al enviarlo por pedacitos se puede ver una mejora en la performance
                        fragment = aux_ret[:BUFFER_SIZE]
                        if not fragment:
                            break
                        self.s.send(fragment)
                        aux_ret = aux_ret[BUFFER_SIZE:]
                elif status != CODE_OK:
                    error_code = status
                    error_message = error_messages[error_code].encode(
                        'ascii').decode('ascii')
                    message_string = f"{error_code} {error_message}\r\n"
                    message_bytes = message_string.encode('ascii')
                    self.s.send(message_bytes)
            return close
