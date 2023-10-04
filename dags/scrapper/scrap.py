import datetime
from nikescrapi import NikeScrAPI
from sales_generator import SalesGenerator

nike_args = {
    'max_pages': 1,
    'day_count': 0,
    'min_sales': 1,
    'max_sales': 1
}

def nike_scrapper():
    print(f""" 
    #########
    Loading job with the following parameters:
    max_pages={nike_args["max_pages"]}
    day_count={nike_args["day_count"]}
    min_sales={nike_args["min_sales"]}
    max_sales={nike_args["max_sales"]}
    #########""")

    # NOTE: for production set max_pages = 200
    nikeAPI = NikeScrAPI(max_pages=nike_args["max_sales"], path='data/products')
    df = nikeAPI.getData()

    # Sales generator
    gen = SalesGenerator(nike_df=df, min_sales=nike_args["min_sales"], max_sales=nike_args["max_sales"])

    end = datetime.datetime.now()
    start = end - datetime.timedelta(days=nike_args["day_count"])
    gen.generate_interval(start=start, end=end)

if __name__ == "__main__":
    nike_scrapper()