import requests
from bs4 import BeautifulSoup as soup
import csv

p =[]
f = csv.writer(open('jumiapages.csv', 'w'))
f.writerow(['name', 'brand', 'price'])
for i in range(1, 26):
    ap='https://www.jumia.com.ng/ios-phones/'+'?page='+str(i)
    p.append(ap)

for items in p:
    j=requests.get(items)
    jsoup= soup(j.text, 'html.parser')
    jgallery=jsoup.find_all("div",{"class":"sku -gallery"})

    for jg in jgallery:
        name=jg.find_all("span", {"class":"name"})[0].text
        brand=jg.find_all("span", {"class":"brand"})[0].text
        price=jg.find_all("span", {"class":"price"})[0].text

        f.writerow([brand, name, price])

print('Completed Process')
