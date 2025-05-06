import time
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s %(message)s')

while True:
    logging.info("Hello from Python log writer!")
    time.sleep(5)
