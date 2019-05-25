import numpy as np
import glob
from netCDF4 import Dataset
import csv
try:
    # Python 2
    from itertools import izip
except ImportError:
    # Python 3
    izip = zip
from pytz import timezone
from datetime import datetime

utc_now = datetime.now(timezone('UTC'))
# print(utc_now)
utc_year = utc_now.strftime("%Y")
utc_month = utc_now.strftime("%m")
utc_day = utc_now.strftime("%d")
utc_monthday = utc_month + utc_day

dataDir = "/app/kaminari_python/nc/%s/%s/"%(utc_year, utc_monthday)
csvfile = "/app/kaminari_python/csv/isslis_flashloc_test.csv"

files = glob.glob(dataDir+'*.nc')

flash_lat = np.array([])
flash_lon = np.array([])
flash_TAI93_time = np.array([])

for i in files:
    datafile = Dataset(i)

    flash_lat_check = datafile.variables.get('lightning_flash_lat', 'None')
    flash_lon_check = datafile.variables.get('lightning_flash_lon', 'None')
    flash_TAI93_time_check = datafile.variables.get('lightning_flash_TAI93_time', 'None')

    if not flash_lat_check == 'None':
        flash_lat = np.concatenate([flash_lat,datafile.variables['lightning_flash_lat'][:]])
    if not flash_lon_check == 'None':
        flash_lon = np.concatenate([flash_lon,datafile.variables['lightning_flash_lon'][:]])
    if not flash_TAI93_time_check == 'None':
        flash_TAI93_time = np.concatenate([flash_TAI93_time,datafile.variables['lightning_flash_TAI93_time'][:]])

with open(csvfile, 'w') as myfile:
    writer = csv.writer(myfile)
    writer.writerows(izip(["flash_lat"], ["flash_lon"], ["flash_TAI93_time"]))
    writer.writerows(izip(flash_lat, flash_lon, flash_TAI93_time))
    print ("making csv file is compleated")

print ("information: flash_lat.size is %s, flash_lon.size is %s, flash_TAI93_time.size is %s"%(flash_lat.size, flash_lon.size, flash_TAI93_time.size))
