import shutil

total,used,free = shutil.disk_usage("/")
usage = (used/total)*100
print(f"Disk Usage: {usage:.2f}%")
if usage >80:
    print ("Disk usage is higher than 80%:", usage)
else:
    print ("Current disk usage:", usage)
