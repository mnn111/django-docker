"""django command to wait for the database to be available."""

import time
import os

from psycopg2 import OperationalError as Psycopg2Error

from django.db.utils import OperationalError
from django.core .management.base import BaseCommand

class Command(BaseCommand):
    """Django command to wait for the database to be available."""

    def handle(self, *args,**kwargs):
        "Entrypoint for command"
        self.stdout.write('Waiting for database...')

        db_connection = False

        while not db_connection:
            try:
                self.check(databases=['default'])
                db_connection = True
            except (Psycopg2Error, OperationalError) as e:
                self.stdout.write('database unavailable, waiting for 1 second ...')
                time.sleep(1)

        self.stdout.write(self.style.SUCCESS('Database available!'))