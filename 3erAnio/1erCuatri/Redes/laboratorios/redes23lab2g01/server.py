#!/usr/bin/env python
# encoding: utf-8
# Revisión 2019 (a Python 3 y base64): Pablo Ventura
# Revisión 2014 Carlos Bederián
# Revisión 2011 Nicolás Wolovick
# Copyright 2008-2010 Natalia Bidart y Daniel Moisset
# $Id: server.py 656 2013-03-18 23:49:11Z bc $

import optparse
import socket
import sys
from connection import Connection
from constants import DEFAULT_ADDR, DEFAULT_PORT, DEFAULT_DIR
import threading


class Server(object):
    """
    El servidor, que crea y atiende el socket en la dirección y puerto
    especificados donde se reciben nuevas conexiones de clientes.
    """

    def _check_for_available_ports(self, port, addr):
        is_connected = False
        i = 0
        while not is_connected:
            try:
                self.s.bind((addr, port + i))
                is_connected = True
            except OSError:
                i += 1
        return port + i

    def __init__(self, addr=DEFAULT_ADDR, port=DEFAULT_PORT,
                 directory=DEFAULT_DIR):
        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        port = self._check_for_available_ports(port, addr)
        print("Serving %s on %s:%s." % (directory, addr, port))
        self.s.listen(5)  # aca puedo poner un int de cuantos comandos seguidos puedo escuchar como max
        self.my_directory = directory

    def serve(self):
        """
        Loop principal del servidor.
        Usando threading la cual es una libreria que permite crear hilos
        Creamos subprocesos para atender a los clientes.
        """

        while True:
            socket_conexion, address = self.s.accept()  # aceptar peticiones / comandos
            threading.Thread(target=self.handle_client, args=(socket_conexion,)).start()

    def handle_client(self, socket_conexion):
        """
        Atiende una conexión del cliente.
        """
        close = False
        while not close:
            # Connection para la conexión y atenderla hasta que termine. 
            conexion = Connection(socket_conexion, self.my_directory)  # ver directorio
            close = conexion.handle()


def main():
    """Parsea los argumentos y lanza el server"""

    parser = optparse.OptionParser()
    parser.add_option(
        "-p", "--port",
        help="Número de puerto TCP donde escuchar", default=DEFAULT_PORT)
    parser.add_option(
        "-a", "--address",
        help="Dirección donde escuchar", default=DEFAULT_ADDR)
    parser.add_option(
        "-d", "--datadir",
        help="Directorio compartido", default=DEFAULT_DIR)

    options, args = parser.parse_args()
    if len(args) > 0:
        parser.print_help()
        sys.exit(1)
    try:
        port = int(options.port)
    except ValueError:
        sys.stderr.write(
            "Numero de puerto invalido: %s\n" % repr(options.port))
        parser.print_help()
        sys.exit(1)

    server = Server(options.address, port, options.datadir)
    server.serve()


if __name__ == '__main__':
    main()
